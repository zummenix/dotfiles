#!/usr/bin/env bash

dir_size() {
    du -hs "$1"
}
export -f dir_size

run_clean() {
    DIR=$(dirname "$1")
    dir_size "$DIR"
    cargo clean --verbose --manifest-path "$1"
    dir_size "$DIR"
}
export -f run_clean

find . -depth 2 -name "Cargo.toml" -print0 | xargs -0 -n 1 -I{} bash -c "run_clean {}"

