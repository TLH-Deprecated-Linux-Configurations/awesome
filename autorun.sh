#!/usr/bin/env bash

userlocation="$HOME/.config/awesome/scripts/"



function run() {
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

setxkbmap "$(cut -d= -f2 /etc/vconsole.conf | cut -d- -f1)"

if [[ "$(command -v light-locker)" ]]; then
    light-locker --no-lock-on-suspend &>/dev/null &
fi

if [[ "$(command -v udiskie)" ]]; then
    pgrep udiskie &>/dev/null || udiskie &>/dev/null &
fi

if [[ "$(command -v psi-notify)" ]]; then
    pgrep psi-notify &>/dev/null || psi-notify &>/dev/null &
fi

if grep -q "bluetooth=false" ~/.config/tos/theme; then
        pgrep bluetoothctl &>/dev/null || bluetoothctl power off
fi

# launch a polkit authentication manager
if [[ "$(command -v lxsession)" ]]; then
    pgrep lxsession || lxsession -s TOS -e TDE &
fi

# autolock the system
if [[ "$(command -v xidlehook)" != "" && "$1" -gt "5" ]]; then
    echo "Lock screen time set to: $1 seconds"
    sh /etc/xdg/tde/autolock.sh "$1" &>/dev/null &
fi

# run clipboard manager
if [[ "$(command -v greenclip)" ]]; then
    pgrep greenclip || greenclip daemon
fi

# run kde connect
if [[ -f "/usr/lib/kdeconnectd" ]]; then
    pgrep kdeconnectd || /usr/lib/kdeconnectd &
fi

if [[ "$(command -v touchegg)" ]]; then
    [[ "$(pgrep touchegg | wc -l)" -lt 2 ]] && touchegg &
fi

# autostart user scripts if that directory exists
if [[ -d "$userlocation" ]]; then
        for script in "$userlocation"/*.sh; do
            "$script" & # launch all user scripts in the background
        done
fi

