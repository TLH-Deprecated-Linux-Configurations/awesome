#!/usr/bin/env bash

userlocation="$HOME/.config/awesome/scripts/"



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

# launch a polkit authentication manager
if [[ "$(command -v lxsession)" ]]; then
    pgrep lxsession || lxsession -s the Electric Tantra Linux -e AwesomeWM -r &
fi

# autolock the system


# run clipboard manager
if [[ "$(command -v greenclip)" ]]; then
    pgrep greenclip || greenclip daemon
fi


# autostart user scripts if that directory exists
if [[ -d "$userlocation" ]]; then
        for script in "$userlocation"/*.sh; do
            "$script" & # launch all user scripts in the background
        done
fi

