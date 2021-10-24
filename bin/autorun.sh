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

#  Disk Automounting & User Controls
if [[ "$(command -v udiskie)" ]]; then
    pgrep udiskie &>/dev/null || udiskie &>/dev/null &
fi

# Set the Super key to all three of the below for menu on single key press,
# better as a configuration specific setting as on xfce4 or whatever, this
# would not be helpful but the opposite really
#if [[ "$(command -v xcape)" ]]; then
#   xcape -e "Super_L=Super_L|Control_L|Escape" &
#fi

# run clipboard manager
if [[ "$(command -v greenclip)" ]]; then
    pgrep greenclip || greenclip daemon
fi

# run clipboard manager
if [[ "$(command -v picom)" ]]; then
    picom -b --experimental-backends &>/dev/null &
fi
#  Make sure the colors are as they are supposed to be
if [[ "$(command -v xrdb)" ]]; then
    xrdb "$HOME"/.Xresources &
fi

# run clipboard manager
if [[ "$(command -v xsettingsd)" ]]; then
    xsettingsd &
fi

# run xsetroot
if [[ "$(command -v xsetroot)" ]]; then
    xsetroot -cursor_name left_ptr &
fi

# run power manager
if [[ "$(command -v xfce4-power-manager)" ]]; then
    xfce4-power-manager &
fi

#  Make sure the colors are as they are supposed to be
if [[ "$(command -v xrdb)" ]]; then
    xrdb "$HOME"/.Xresources &
fi

if [[ "$(command -v goautolock)" ]]; then
    goautolock --locker slock  &
fi
