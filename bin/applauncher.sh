#!/usr/bin/env bash
set -o noglob

DPI="$1"

theme="$HOME/.config/awesome/configuration/rofi/appmenu/rofi.rasi"

result="$(rofi -dpi "$DPI" -show drun -theme "$theme")"

while [[ ! "$result" == "" ]]; do
    qalculatedResult="$(qalc "$result")"

    if ! echo "$qalculatedResult" | grep -q "^error: "; then
        result="$(qalc "$result" | rofi -no-default-config -dpi "$DPI" -dmenu -theme "$theme")"
    else
        result=""
    fi
done
