#!/bin/sh
###################################################
#  _______         __
# |   _   |.--.--.|  |_.-----.----.--.--.-----.
# |       ||  |  ||   _|  _  |   _|  |  |     |
# |___|___||_____||____|_____|__| |_____|__|__|
###################################################

#  Disk Automounting & User Controls
if "$(command -v udiskie)"; then
    udiskie &
fi


#  clipboard manager
if "$(command -v greenclip)"; then
    greenclip daemon &
fi

#  clipboard manager
if "$(command -v picom)"; then
    pkill picom && picom -b --experimental-backends &
fi

if "$(command -v xcape)"; then
    xcape -e "Super_L=Super_L|Control_L|Escape" &
fi

# clipboard manager
if "$(command -v pnmixer)"; then
    pnmixer &
fi

#  Make sure the colors are as they are supposed to be
if "$(command -v xrdb)"; then
    xrdb "$HOME"/.Xresources &
fi

# clipboard manager
if "$(command -v xsettingsd)"; then
    xsettingsd &
fi

#  Make sure the colors are as they are supposed to be
if "$(command -v xinput)"; then
    xinput set-prop "ELAN1301:00 04F3:30C6 Touchpad" "libinput Tapping Enabled" 1 &
fi

if "$(command -v goautolock)"; then
    goautolock --time 360 --notify 30 --locker "$HOME/.config/awesome/bin/blur.sh" &
fi
# Dropbox
if "$(command -v dropbox)"; then
    dropbox start &
fi
# Pulse Effects Equalizer
if "$(command -v pulseeffects)"; then
    pulseeffects --gapplication-service &
fi
# Pulse Effects Equalizer
if "$(command -v lxqt-policykit-agent)"; then
    /usr/bin/lxqt-policykit-agent &
fi

# Pulse Effects Equalizer
if "$(command -v lxqt-policykit-agent)"; then
    /usr/bin/lxqt-policykit-agent &
fi
if "$(command -v gnome-keyring-daemon)"; then
    eval "$(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)"
fi
