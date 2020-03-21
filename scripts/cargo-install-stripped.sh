#!/usr/bin/env bash

# Compiles an executable crate at current path, itsalls and strips it.

function _bail {
    echo "$1" 1>&2 ; exit 1
}

function _strip {
    local size_before=$(du -h "$1" | cut -f1)
    test -z "$size_before" && _bail "Wasn't able to get file size before strip."
    strip "$1" || _bail "Wasn't able to strip the executable."
    local size_after=$(du -h "$1" | cut -f1)
    test -z "$size_after" && _bail "Wasn't able to get file size after strip."
    echo "Stripped $size_after, was $size_before"
}

CRATE_NAME=$(grep "name" Cargo.toml | head -n1 | cut -d'=' -f2 | cut -d'"' -f2)
test -z "$CRATE_NAME" && _bail "Wasn't able to get a crate name."

cargo install --path . && _strip $(which "$CRATE_NAME")
