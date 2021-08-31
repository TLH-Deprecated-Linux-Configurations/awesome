#!/usr/bin/env bash

userlocation="$HOME/.config/awesome/"

function run() {
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}

setxkbmap "$(cut -d= -f2 /etc/vconsole.conf | cut -d- -f1)"

if [[ "$(command -v udiskie)" ]]; then
    pgrep udiskie &>/dev/null || udiskie &>/dev/null &
fi

# autolock the system
if [[ "$(command -v i3lock)" != "" && "$1" -gt "5" ]]; then
    echo "Lock screen time set to: $1 seconds"
    "$HOME"/.config/awesome/bin/autolock.sh &>/dev/null &
fi

# run clipboard manager
if [[ "$(command -v greenclip)" ]]; then
    pgrep greenclip || greenclip daemon
fi

# run clipboard manager
if [[ "$(command -v picom)" ]]; then
    picom -b --experimental-backends --config ~/.config/awesome/external/picom.conf &>/dev/null &
fi
