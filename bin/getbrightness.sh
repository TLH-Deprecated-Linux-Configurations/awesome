#! /usr/bin/bash
#  _______         __
# |     __|.-----.|  |_
# |    |  ||  -__||   _|
# |_______||_____||____|

#  ______        __         __     __
# |   __ \.----.|__|.-----.|  |--.|  |_.-----.-----.-----.-----.
# |   __ <|   _||  ||  _  ||     ||   _|     |  -__|__ --|__ --|
# |______/|__|  |__||___  ||__|__||____|__|__|_____|_____|_____|
#                   |_____|
###########################################################################
###########################################################################
###########################################################################
# Environmental Variables
#
MONITOR_NAMES=$(xrandr --listmonitors | grep '^\s' | awk '{print $4}')
MONITOR_BRIGHTNESSES=$(xrandr --verbose | grep Brightness | grep -o '[0-9].*')

# Function
#
for i in "${!MONITOR_NAMES[@]}"; do
    if [ "$1" == "${MONITOR_NAMES[i]}" ]; then
        echo "${MONITOR_BRIGHTNESSES[i]}"
    fi
done

# Command to xrandr
#
xrandr --output "$1" --brightness "$2"
