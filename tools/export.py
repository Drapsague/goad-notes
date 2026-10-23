#!/usr/bin/env python3
"""
Convert SilverBullet-flavored markdown into GitHub-flavored markdown.

Transforms (only OUTSIDE fenced code blocks):
  ![[images/foo.png]]        ->  ![foo](images/foo.png)
  > **note** Note            ->  > [!NOTE]     (GitHub alert)
  > **success** Success      ->  > [!TIP]
  > **warning** Warning      ->  > [!WARNING]
  > **danger** Danger        ->  > [!CAUTION]
  [[Page]] / [[Page|alias]]  ->  [Page](Page.md)
  ==highlight==              ->  <mark>highlight</mark>

Pass-through (unchanged):
  README.md, tables, fenced code, frontmatter, anything already-standard.

Usage:
  python3 export.py --space /path/to/space --out /tmp/export-dir
"""

import argparse
import re
import shutil
import sys
import urllib.parse
from pathlib import Path

SKIP_DIRS = {".git", ".github", "tools", "System", "Library", ".export-test"}
PASS_THROUGH = {"README.md"}  # already GitHub-flavored, copy as-is

# SilverBullet flavor -> GitHub alert (GitHub supports exactly these five)
CALLOUT_MAP = {
    "note": "NOTE",
    "info": "NOTE",
    "question": "NOTE",
    "example": "NOTE",
    "important": "IMPORTANT",
    "tip": "TIP",
    "success": "TIP",
    "warning": "WARNING",
    "caution": "WARNING",
    "danger": "CAUTION",
    "bug": "CAUTION",
    # "quote" is intentionally NOT mapped: keep as a plain blockquote
}

RE_TRANSCLUSION = r"!\[\[([^\]|]+?)(?:\|[^\]]*)?\]\]"
RE_WIKILINK = r"\[\[([^\]|]+?)(?:\|([^\]]+))?\]\]"
RE_CALLOUT = r"^(>\s*)\*\*([a-zA-Z-]+)\*\*\s*(.*)$"
RE_HIGHLIGHT = r"==([^=\n]+)=="


def encode_path(path: str) -> str:
    """Percent-encode a file path so it is a valid link target."""
    return urllib.parse.quote(path, safe="/.-_()")


def convert_callout(line: str) -> str | None:
    m = re.match(RE_CALLOUT, line)
    if not m:
        return None
    flavor = m.group(2).lower()
    gh = CALLOUT_MAP.get(flavor)
    if not gh:
        return None  # unknown flavor ("quote", custom): keep blockquote as-is
    title = (m.group(3) or "").strip()
    # drop redundant titles: "> **danger** Danger", "> **warning** Warning"
    if title.lower() in {flavor, gh.lower()}:
        return f"{m.group(1)}[!{gh}]\n"
    return f"{m.group(1)}[!{gh}] {title}\n"


def convert_text(text: str) -> str:
    out = []
    in_fence = False
    fence_marker = ""
    for line in text.splitlines(keepends=True):
        stripped = line.lstrip()
        if stripped.startswith("```") or stripped.startswith("~~~"):
            marker = stripped[:3]
            if not in_fence:
                in_fence, fence_marker = True, marker
            elif marker == fence_marker:
                in_fence = False
            out.append(line)
            continue

        if in_fence:
            out.append(line)
            continue

        line = re.sub(  # ![[images/foo.png]] -> ![foo](images/foo.png)
            RE_TRANSCLUSION,
            lambda m: "![{}]({})".format(
                Path(m.group(1)).stem, encode_path(m.group(1))
            ),
            line,
        )
        line = re.sub(  # [[Page]] -> [Page](Page.md)  |  [[Page|alias]]
            RE_WIKILINK,
            lambda m: "[{}]({})".format(
                m.group(2) or Path(m.group(1)).stem,
                encode_path(m.group(1)) + ".md",
            ),
            line,
        )
        if callout := convert_callout(line):  # > **flavor** -> > [!FLAVOR]
            line = callout
        line = re.sub(RE_HIGHLIGHT, r"<mark>\1</mark>", line)
        out.append(line)
    return "".join(out)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--space", required=True, type=Path)
    ap.add_argument("--out", required=True, type=Path)
    args = ap.parse_args()
    space, out = args.space.resolve(), args.out.resolve()
    if not space.is_dir():
        print(f"export: space not found: {space}", file=sys.stderr)
        return 1
    out.mkdir(parents=True, exist_ok=True)

    n_md, n_img = 0, 0
    for src in sorted(space.rglob("*")):
        if not src.is_file():
            continue
        rel = src.relative_to(space)
        if any(part in SKIP_DIRS for part in rel.parts):
            continue
        if src.name.startswith(".") or src.suffix in {".sh"}:
            continue

        dst = out / rel
        dst.parent.mkdir(parents=True, exist_ok=True)

        if src.suffix == ".md" and rel.name not in PASS_THROUGH:
            dst.write_text(convert_text(src.read_text(encoding="utf-8")), "utf-8")
            n_md += 1
        elif (src.suffix == ".md" and rel.name in PASS_THROUGH) or suffix_allowed(src):
            shutil.copy2(src, dst)
            n_img += 1

    # GitHub: avoid trying to build Jekyll when browsing this branch
    (out / ".nojekyll").write_text("", encoding="utf-8")

    print(f"export: wrote {n_md} markdown pages, {n_img} assets -> {out}")
    return 0


def suffix_allowed(src: Path) -> bool:
    """Copy assets we care about; ignore everything else (scripts, db, etc.)."""
    return src.suffix.lower() in {".png", ".jpg", ".jpeg", ".gif", ".svg",
                                  ".webp"}


if __name__ == "__main__":
    sys.exit(main())