#!/bin/bash

set -e

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"
BIN="${1:-$BIN_DIR/_macos-mic-hud}"

mkdir -p "$BIN_DIR"

swiftc -O \
    "$SCRIPT_DIR/hud-source.swift" \
    -o "$BIN"

echo "Built $BIN"
