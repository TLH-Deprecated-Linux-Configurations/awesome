 #!/bin/sh
#  _______         __          _____               __
# |   _   |.--.--.|  |_.-----.|     |_.-----.----.|  |--.
# |       ||  |  ||   _|  _  ||       |  _  |  __||    <
# |___|___||_____||____|_____||_______|_____|____||__|__|
###########################################################################
###########################################################################
###########################################################################
# This simple script runs goautolock which can be installed on Arch with
# yay -S goautolock
# the command uses the script in this configuration as its locker and works
# well with  self-explanatory argument flafs and no frills functionality.

goautolock --locker "$HOME"/.config/awesome/external/i3lock/blur.sh --time 360 --notify 30 &

