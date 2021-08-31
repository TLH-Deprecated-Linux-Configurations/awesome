#!/usr/bin/env bash
set -o noglob

DPI="$1"
CONFIG="$2"

theme="$CONFIG/external/rofi/appmenu/drun.rasi"

result="$(rofi -dpi "$DPI" -show drun -theme "$theme")"

while [[ ! "$result" == "" ]]; do
    qalculatedResult="$(qalc "$result")"

    if ! echo "$qalculatedResult" | grep -q "^error: "; then
        result="$(qalc "$result" | rofi -no-default-config -dpi "$DPI" -dmenu -theme "$theme")"
    else
        result=""
    fi
done
