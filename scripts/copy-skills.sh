#!/usr/bin/env bash

USER_ENV="${1:-}"

if test "$USER_ENV" = "home"; then
    DEST="$HOME/.qwen/skills"
elif test "$USER_ENV" = "work"; then
    DEST="$HOME/.nessy/skills"
else
    echo "Usage: $0 USER_ENV" >&2
    echo "USER_ENV must be 'home' or 'work'" >&2
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="$SCRIPT_DIR/../skills"

if test ! -d "$SOURCE"; then
    echo "Source skills directory not found: $SOURCE" >&2
    exit 1
fi

mkdir -p "$DEST"

echo "Copying skills from $SOURCE to $DEST"
copied=0
skipped=0
for skill_dir in "$SOURCE"/*/; do
    test -d "$skill_dir" || continue
    name=$(basename "$skill_dir")
    if test ! -f "$skill_dir/SKILL.md"; then
        echo "  warning: $name has no SKILL.md, skipping" >&2
        skipped=$((skipped + 1))
        continue
    fi
    rm -rf "${DEST:?}/$name"
    cp -R "$skill_dir" "$DEST/$name"
    echo "  copy $name → $DEST/$name"
    copied=$((copied + 1))
done

echo "Copied $copied skills, skipped $skipped."
