# -*- coding: utf-8 -*-
"""Save local Docker image and upload to the server. Secrets come from docker/deploy.env."""
from __future__ import print_function

import gzip
import os
import shutil
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ENV_FILE = Path(__file__).resolve().parent / "deploy.env"
COMPOSE_FILE = ROOT / "docker-compose.yml"


def log(msg):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace") if hasattr(sys.stdout, "reconfigure") else None
    print(msg, flush=True)


def load_env(path):
    data = {}
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        data[key.strip()] = value.strip()
    return data


def require(env, *keys):
    missing = [k for k in keys if not env.get(k)]
    if missing:
        raise SystemExit("deploy.env missing: " + ", ".join(missing))


def save_image(image, dest):
    log("saving " + image + " -> " + str(dest))
    proc = subprocess.Popen(["docker", "save", image], stdout=subprocess.PIPE)
    with gzip.open(dest, "wb", compresslevel=6) as fh:
        shutil.copyfileobj(proc.stdout, fh)
    rc = proc.wait()
    if rc != 0:
        raise SystemExit("docker save failed: %s" % rc)
    log("archive bytes %s" % dest.stat().st_size)


def ssh_client(env):
    import paramiko

    last = None
    for i in range(1, 6):
        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        try:
            log("ssh try %s" % i)
            client.connect(
                env["DEPLOY_HOST"],
                username=env["DEPLOY_USER"],
                password=env["DEPLOY_PASS"],
                timeout=25,
                allow_agent=False,
                look_for_keys=False,
                banner_timeout=25,
                auth_timeout=25,
            )
            transport = client.get_transport()
            if transport is not None:
                transport.set_keepalive(15)
            return client
        except Exception as exc:
            last = exc
            log("ssh fail %s %s" % (type(exc).__name__, exc))
            try:
                client.close()
            except Exception:
                pass
            time.sleep(3 * i)
    raise SystemExit("ssh failed: %s" % last)


def run(client, cmd, timeout=300):
    log("remote: " + cmd[:220])
    stdin, stdout, stderr = client.exec_command(cmd, timeout=timeout)
    out = stdout.read().decode("utf-8", "replace")
    err = stderr.read().decode("utf-8", "replace")
    code = stdout.channel.recv_exit_status()
    if out:
        log(out[-8000:])
    if err:
        log(err[-2000:])
    if code != 0:
        raise SystemExit("remote cmd failed %s" % code)
    return out


def remote_env_body(env):
    return (
        "MYSQL_HOST={MYSQL_HOST}\n"
        "MYSQL_PORT={MYSQL_PORT}\n"
        "MYSQL_USER={MYSQL_USER}\n"
        "MYSQL_PASSWORD={MYSQL_PASSWORD}\n"
        "MYSQL_URL={MYSQL_URL}\n"
    ).format(**env)


def upload(env, archive):
    import paramiko  # noqa: F401  # ensure installed

    remote_dir = env.get("REMOTE_DIR") or "/opt/yancraft"
    client = ssh_client(env)
    run(client, "mkdir -p %s && swapon /opt/swap/swapfile || true" % remote_dir)
    sftp = client.open_sftp()
    log("upload image")
    t0 = time.time()
    sftp.put(str(archive), remote_dir + "/yancraft-app.tar.gz")
    log("image uploaded in %ss" % int(time.time() - t0))
    sftp.put(str(COMPOSE_FILE), remote_dir + "/docker-compose.yml")
    with sftp.file(remote_dir + "/.env", "w") as fh:
        fh.write(remote_env_body(env))
    sftp.chmod(remote_dir + "/.env", 0o600)
    sftp.close()
    run(
        client,
        "cd %s && docker load -i yancraft-app.tar.gz && docker images %s"
        % (remote_dir, env["IMAGE_NAME"]),
        timeout=300,
    )
    run(
        client,
        "cd %s && docker compose up -d --force-recreate app && docker compose ps" % remote_dir,
        timeout=180,
    )
    time.sleep(16)
    run(
        client,
        "cd %s && docker inspect yancraft-app-1 --format '{{.State.Status}}' && "
        "curl -sI -m 8 http://127.0.0.1:3001 | head -8 && "
        "curl -sI -m 8 http://127.0.0.1:3000 | head -8" % remote_dir,
        timeout=40,
    )
    client.close()
    log("publish done")
    log("admin http://%s:3001" % env["DEPLOY_HOST"])
    log("blog  http://%s:3000" % env["DEPLOY_HOST"])


def main():
    if not ENV_FILE.exists():
        raise SystemExit("missing %s (copy from deploy.env.example)" % ENV_FILE)
    env = load_env(ENV_FILE)
    require(
        env,
        "DEPLOY_HOST",
        "DEPLOY_USER",
        "DEPLOY_PASS",
        "IMAGE_NAME",
        "MYSQL_HOST",
        "MYSQL_PORT",
        "MYSQL_USER",
        "MYSQL_PASSWORD",
        "MYSQL_URL",
    )
    archive = Path(os.environ.get("TEMP") or "/tmp") / "yancraft-app.tar.gz"
    if "--skip-save" not in sys.argv:
        save_image(env["IMAGE_NAME"], archive)
    if not archive.exists():
        raise SystemExit("image archive not found: %s" % archive)
    upload(env, archive)


if __name__ == "__main__":
    main()
