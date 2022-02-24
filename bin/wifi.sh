#!/bin/bash

# network ssid's
networks="$(nmcli d wifi list | awk '$1 !~ /IN-USE|*/{print $0}' | grep -Eo '^.* Infra' | sed 's/Infra//' | sed -r 's/([0-9A-F]{2}:){5}[0-9A-F]{2}\s+//' | awk '{print "\""$0"\""}' | sed -r -e 's/^\"\s+/\"/g' -e 's/\s*\"//g' | sort | uniq)" # get all screens
DPI=${1:-"100"}

val="$(printf "%s" "$networks" | rofi -dmenu -dpi "$DPI" -theme $HOME/.config/awesome/config/rofi/general/rofi.rasi)" # get the requested network

if [[ "$val" == "" ]]; then
        exit 1 # user aborted
fi

nmcli dev wifi connect "$val" || echo "Asking for password of $val"
# shellcheck disable=SC2063
nmcli dev wifi list | grep '*' | head -n1 | grep -q " $val " && exit # exit if a connection has been made
# otherwise we ask the password from the user
password=$(printf "What is the password of %s?" "$val" | rofi -dmenu -dpi "$DPI" -password -theme $HOME/.config/awesome/config/rofi/general/rofi.rasi) # get the requested dpi

if [[ "$password" == "" ]]; then
        exit 1 # user aborted password entry field
fi

nmcli dev wifi connect "$val" password "$password"
