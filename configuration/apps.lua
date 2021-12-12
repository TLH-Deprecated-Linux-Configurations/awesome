local filesystem = require('gears.filesystem')
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. 'utilities/'
local HOME = os.getenv 'HOME'

return {
    -- The default applications that we will use in keybindings and widgets
    default = {
        -- Default terminal emulator
        terminal = 'kitty',
        -- Default web browser
        browser = 'firefox-nightly',
        -- Default text editor
        text_editor = 'nvim',
        -- Default file manager
        file_manager = 'caja',
        -- Default media player
        multimedia = 'vlc',
        -- Default graphics editor
        graphics = 'gimp',
        -- Default sandbox
        sandbox = 'virtualbox',
        -- Default IDE
        development = 'code-oss',
        -- Default network manager
        network_manager = 'sh ' .. HOME .. '/.config/awesome/bin/wifi.sh',
        -- Default bluetooth manager
        bluetooth_manager = 'blueman',
        -- Default power manager
        power_manager = 'xfce4-power-manager',
        -- Default GUI package manager
        package_manager = 'pamac-manager',
        -- Default locker
        lock = 'bash ~/.config/awesome/blur.sh',
        -- Default quake terminal
        quake = 'itty --name QuakeTerminal',
        -- Default rofi global menu
        rofi_global = 'cmenu',
        -- Default app menu
        rofi_appmenu = ' bash ' ..
            HOME ..
                '/.config/awesome/bin/applauncher.sh ' ..
                    screen.primary.dpi .. ' ' .. filesystem.get_configuration_dir()

        -- You can add more default applications here
    },
    -- List of apps to start once on start-up
    run_on_start_up = {
        -- Compositor
        'picom -b --experimental-backends --dbus --config ' .. config_dir .. '/configuration/picom.conf',
        -- Blueman applet
        'blueberry-tray',
        'pnmixer',
        -- Polkit and keyring
        '/usr/bin/lxqt-policykit-agent &' .. ' eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)',
        -- Load X colors
        'xrdb $HOME/.Xresources',
        'xinput set-prop "ELAN1301:00 04F3:30C6 Touchpad" "libinput Tapping Enabled" 1 &',
        -- Audio equalizer
        'pulseeffects --gapplication-service',
        -- Make App Drawe Spawn with Single Key Press
        'xcape -e "Super_L=Super_L|Control_L|Escape"',
        -- Lockscreen timer
        'goautolock -l ~/.config/awesome/bin/blur.sh'
        -- You can add more start-up applications here
    },
    -- List of binaries/shell scripts that will execute for a certain task
    utils = {
        -- Fullscreen screenshot
        full_screenshot = utils_dir .. 'xfce4-screenshooter',
        -- Area screenshot
        area_screenshot = utils_dir .. 'xfce4-screenshooter',
        -- Update profile picture
        update_profile = utils_dir .. 'profile-image'
    }
}
