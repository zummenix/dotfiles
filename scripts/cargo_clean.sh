#!/usr/bin/env bash

run_clean() {
    DIR=$(dirname "$1")
    du -hs "$DIR"
    pushd "$DIR" > /dev/null && cargo clean
    popd > /dev/null
    du -hd0 "$DIR"
}
export -f run_clean

find . -depth 2 -name "Cargo.toml" -print0 | xargs -0 -n 1 -I{} bash -c "run_clean {}"

