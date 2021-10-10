-- _______
-- |   _   |.-----.-----.-----.
-- |       ||  _  |  _  |__ --|
-- |___|___||   __|   __|_____|
--          |__|  |__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local filesystem = require "gears.filesystem"
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- lib to retrieve current theme
local beautiful = require "beautiful"
local color = beautiful.xforeground
local HOME = os.getenv "HOME"

package.loaded["awful.hotkeys_popup.keys.tmux"] = {}

-- ########################################################################
-- ########################################################################
-- ########################################################################
return {
    -- List of apps to start by default on some actions
    default = {
        terminal = "kitty",
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        editor = "nvim",
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        web_browser = "firefox",
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        file_manager = "caja",
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        rofi = "rofi -dpi " ..
            screen.primary.dpi ..
                ' -show "Global Search" -modi "Global Search":' ..
                    HOME ..
                        "/.config/awesome/external/rofi/sidebar/rofi-spotlight.sh -theme " ..
                            HOME .. "/.config/awesome/external/rofi/sidebar/rofi.rasi",
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        web = "rofi -dpi " ..
            screen.primary.dpi ..
                " -show Search -modi Search:" ..
                    HOME ..
                        "/external/rofi/search.py" ..
                            " -theme " .. HOME .. "/.config/awesome/external/rofi/sidebar/rofi.rasi",
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        rofiappmenu = "bash " ..
            HOME ..
                "/.config/awesome/bin/applauncher.sh " ..
                    screen.primary.dpi .. " " .. filesystem.get_configuration_dir(),
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        roficlipboard = "rofi -dpi " ..
            screen.primary.dpi ..
                ' -modi "clipboard:greenclip print" -show clipboard -theme ' ..
                    HOME .. "/.config/awesome/external/rofi/appmenu/drun.rasi",
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        rofiwifimenu = "sh " .. HOME .. "/.config/awesome/bin/wifi.sh",
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        lock = "bash " .. HOME .. "/.config/awesome/external/i3lock/blur.sh",
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        quake = (os.getenv "TERMINAL" or "kitty") .. " -T QuakeTerminal",
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        duplicate_screens = "bash " .. HOME .. "xrandr-duplicate.sh"
    },
    -- ########################################################################
    -- List of apps to start once on start-up
    run_on_start_up = {
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        --  Set the Super key to all three of the below for menu on single key press
        'xcape -e "Super_L=Super_L|Control_L|Escape"'

        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    },
    -- ########################################################################
    bins = {
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        full_screenshot = "sh" .. HOME .. '/.config/awesome/bin/snapshot.sh full "' .. color .. '"',
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        full_blank_screenshot = "sh " .. HOME .. " /.config/awesome/bin/snapshot.sh full_blank",
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        area_screenshot = "sh " .. HOME .. "/.config/awesome/bin/snapshot.sh area ",
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        area_blank_screenshot = "sh " .. HOME .. "/.config/awesome/bin/snapshot.sh area_blank",
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        window_screenshot = "sh " .. HOME .. '/.config/awesome/bin/snapshot.sh" window ' .. color .. '"',
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        window_blank_screenshot = "sh " .. HOME .. "/.config/awesome/bin/snapshot.sh window_blank"
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    }
}
