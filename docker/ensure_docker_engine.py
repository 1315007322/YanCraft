# -*- coding: utf-8 -*-
"""Make sure the local Docker engine answers before compose build."""
from __future__ import print_function

import os
import subprocess
import sys
import time


def log(msg):
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    print(msg, flush=True)


def docker_version(timeout=8):
    proc = subprocess.Popen(
        ["docker", "version", "--format", "{{.Server.Version}}"],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    try:
        out, _err = proc.communicate(timeout=timeout)
    except subprocess.TimeoutExpired:
        proc.kill()
        proc.communicate()
        return None
    text = (out or b"").decode("utf-8", "replace").strip()
    if proc.returncode == 0 and text[:1].isdigit():
        return text
    return None


def run_bounded(args, timeout):
    proc = subprocess.Popen(args, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    try:
        proc.wait(timeout)
    except subprocess.TimeoutExpired:
        proc.kill()
        proc.wait()


def taskkill(image):
    subprocess.call(
        ["taskkill", "/F", "/IM", image],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )


def restart_desktop():
    program_files = os.environ.get("ProgramFiles", r"C:\Program Files")
    docker_dir = os.path.join(program_files, "Docker", "Docker")
    cli = os.path.join(docker_dir, "DockerCli.exe")
    app = os.path.join(docker_dir, "Docker Desktop.exe")
    if not os.path.isfile(app):
        raise SystemExit("Docker Desktop.exe not found: " + app)

    log("Docker engine is not responding. Restarting Docker Desktop...")
    if os.path.isfile(cli):
        run_bounded([cli, "-Shutdown"], 15)
    for image in ("Docker Desktop.exe", "com.docker.backend.exe", "com.docker.build.exe"):
        taskkill(image)
    time.sleep(2)
    run_bounded(["wsl", "--shutdown"], 30)
    run_bounded(
        ["powershell", "-NoProfile", "-Command", "Start-Service com.docker.service"],
        20,
    )
    subprocess.Popen([app], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    for attempt in range(1, 16):
        version = docker_version(8)
        if version:
            log("Docker engine ready: " + version)
            return
        log("waiting for Docker engine (%s/15)..." % attempt)
        time.sleep(4)
    raise SystemExit("Docker engine did not start. Open Docker Desktop and retry.")


def main():
    version = docker_version(8)
    if version:
        log("Docker engine ready: " + version)
        return
    restart_desktop()


if __name__ == "__main__":
    main()
