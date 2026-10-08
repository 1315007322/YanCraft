# -*- coding: utf-8 -*-
"""Copy Nuxt .output into a symlink-free tree for Linux Docker images.

Windows nuxt build creates node_modules links like
entities -> E:/project/.../.nitro/entities@7.0.1
which are broken inside the Linux container.
"""
from pathlib import Path
import shutil
import sys

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "ruoyi-blog-web" / ".output"
DST = ROOT / "ruoyi-blog-web" / ".output-docker"


def log(msg):
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    print(msg, flush=True)


def main():
    if not (SRC / "server" / "index.mjs").exists():
        raise SystemExit("missing ruoyi-blog-web/.output, run npm run build first")
    if DST.exists():
        shutil.rmtree(DST)
    log("materialize %s -> %s" % (SRC, DST))
    shutil.copytree(SRC, DST, symlinks=False, ignore_dangling_symlinks=True)
    entities = DST / "server" / "node_modules" / "entities"
    if entities.is_symlink():
        raise SystemExit("entities is still a symlink after materialize")
    decode = entities / "dist" / "commonjs" / "decode.js"
    if not decode.is_file():
        raise SystemExit("missing entities/dist/commonjs/decode.js after materialize")
    log("ok %s" % decode)


if __name__ == "__main__":
    main()
