#!/bin/sh

killall xautolock

xautolock -detectsleep -time 3 -locker "$HOME/.config/awesome/external/i3lock/blur.sh" \
        -notify 30 \
        -notifier "notify-send -u critical -t 10000 -- 'LOCKING SCREEN in 30 seconds'"
