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

if [[ "$(command -v psi-notify)" ]]; then
    pgrep psi-notify &>/dev/null || psi-notify &>/dev/null &
fi

if grep -q "bluetooth=false" ~/.config/awesome/theme; then
    pgrep bluetoothctl &>/dev/null || bluetoothctl power off
fi

# autolock the system
if [[ "$(command -v i3lock)" != "" && "$1" -gt "5" ]]; then
    echo "Lock screen time set to: $1 seconds"
    sh $HOME/.config/awesome/autolock.sh "$1" &>/dev/null &
fi


# run clipboard manager
if [[ "$(command -v greenclip)" ]]; then
    pgrep greenclip || greenclip daemon
fi


# autostart user scripts if that directory exists
if [[ -d "$userlocation" ]]; then
    for script in "$userlocation"/scripts/*.sh; do
        "$script" & # launch all user scripts in the background
    done
fi

