#!/bin/bash

killall xidlehook

timeone=2
timetwo=3
timethree=5
timefour=10
timetwolock="bash  $HOME/.config/awesome/external/i3lock/blur.sh"
#timetwolock=${5:-dm-tool lock}

xidlehook \
        --not-when-fullscreen \
        --not-when-audio \
        --timer "$timeone" \
        'brightnessctl set 45%' \
        --timer "$timetwo" \
        "$timetwolock" \
        'brightnessctl set 35%' \
        --timer "$timethree" \
        "xset dpms force off" \
        'brightnessctl set 15%' \
        --timer "$timefour" \
        "systemctl suspend"
'brightness -s $(cat /tmp/brightness)'
