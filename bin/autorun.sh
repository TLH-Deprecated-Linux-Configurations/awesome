#!/usr/bin/env bash
###################################################
#  _______         __
# |   _   |.--.--.|  |_.-----.----.--.--.-----.
# |       ||  |  ||   _|  _  |   _|  |  |     |
# |___|___||_____||____|_____|__| |_____|__|__|
###################################################
# Like ~/.xprofile, but within the configuratiom amdm
# runs everytime awesome starts instead of once per
# logins which has pros and cons
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
if [[ "$(command -v gautolock)" ]]; then
    echo "Lock screen time set to: 90 seconds"
    goautolock --locker "$HOME"/.config/awesome/external/i3lock/blur.sh --time 360 --notify 30  >/dev/null &
fi

# run clipboard manager
if [[ "$(command -v greenclip)" ]]; then
    pgrep greenclip || greenclip daemon
fi

# run clipboard manager
if [[ "$(command -v picom)" ]]; then
    picom -b --experimental-backends --config ~/.config/awesome/external/picom.conf &>/dev/null &
fi
