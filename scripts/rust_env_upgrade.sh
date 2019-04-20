#!/usr/bin/env bash

# Updates rustup and rustc, installs some tools

set -ex

rustup self update
rustup update stable
cargo install --force cargo-bloat
cargo install --force cargo-outdated
