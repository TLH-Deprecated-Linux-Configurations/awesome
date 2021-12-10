-- _______
-- |   _   |.-----.-----.-----.
-- |       ||  _  |  _  |__ --|
-- |___|___||   __|   __|_____|
--          |__|  |__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local filesystem = require 'gears.filesystem'
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- lib to retrieve current theme

local HOME = os.getenv 'HOME'

package.loaded['awful.hotkeys_popup.keys.tmux'] = {}

-- ########################################################################
-- ########################################################################
-- ########################################################################
return {
    -- List of apps to start by default on some actions
    default = {
        terminal = 'kitty',
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        editor = 'nvim',
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        web_browser = 'firefox',
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        file_manager = 'caja',
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        web = 'rofi -dpi ' ..
            screen.primary.dpi ..
                ' -show "Global Search" -modi "Global Search":' ..
                    HOME ..
                        '/.config/awesome/external/rofi/sidebar/rofi-spotlight.sh -theme ' ..
                            HOME .. '/.config/awesome/external/rofi/sidebar/rofi.rasi',
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        rofiappmenu = 'bash ' ..
            HOME ..
                '/.config/awesome/bin/applauncher.sh ' ..
                    screen.primary.dpi .. ' ' .. filesystem.get_configuration_dir(),
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        roficlipboard = 'rofi -dpi ' ..
            screen.primary.dpi ..
                ' -modi "clipboard:greenclip print" -show clipboard -theme ' ..
                    HOME .. '/.config/awesome/external/rofi/sidebar/rofi.rasi',
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        rofiwifimenu = 'sh ' .. HOME .. '/.config/awesome/bin/wifi.sh',
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        lock = 'bash ' .. HOME .. '/.config/awesome/external/i3lock/blur.sh',
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        quake = (os.getenv 'TERMINAL' or 'kitty') .. ' -T QuakeTerminal'
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    },
    -- ########################################################################
    -- List of apps to start once on start-up
    run_on_start_up = {
        -- Note: if this is set in a script it errors the system into non-functioning, so we are
        -- still using this structure. You could add additional functions here or you could add
        -- them to bin/autorun.sh
        --  Set the Super key to all three of the below for menu on single key press
        --
        'xcape -e "Super_L=Super_L|Control_L|Escape"'

        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    }
    -- ########################################################################
}
