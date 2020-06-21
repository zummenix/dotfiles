#!/usr/bin/env bash

# Updates rustup and rustc, installs some tools

set -ex

# Remove rust-analyzer for coc (it will be downloaded later by the plugin)
trash ~/.config/coc/extensions/coc-rust-analyzer-data/rust-analyzer

rustup self update
rustup update stable
cargo install cargo-bloat
cargo install cargo-outdated
