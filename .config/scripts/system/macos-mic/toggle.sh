#!/bin/bash

set -e

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
HUD="$HOME/.local/bin/__macos-mic-hud"

[ -x "$HUD" ] || "$SCRIPT_DIR/build-hud-bin.sh" "$HUD"

STATE_FILE="$HOME/.local/state/mic-mute-volume"
mkdir -p "$(dirname "$STATE_FILE")"

RESTORE=$(cat "$STATE_FILE" 2>/dev/null)
RESTORE=${RESTORE:-75}

RESULT=$(osascript - "$RESTORE" <<'EOF'
on run argv
    set restoreVolume to item 1 of argv as integer
    set currentVolume to input volume of (get volume settings)

    if currentVolume > 0 then
        set volume input volume 0
        return "off:" & currentVolume
    else
        set volume input volume restoreVolume
        return "on:" & restoreVolume
    end if
end run
EOF
)

case "$RESULT" in
    off:*)
        CURRENT="${RESULT#off:}"
        echo "$CURRENT" > "$STATE_FILE"
        "$HUD" off &
        ;;
    on:*)
        CURRENT="${RESULT#on:}"
        "$HUD" on "$CURRENT" &
        ;;
esac
