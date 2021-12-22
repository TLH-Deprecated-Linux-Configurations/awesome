--  _______                                             ________ _______
-- |   _   |.--.--.--.-----.-----.-----.--------.-----.|  |  |  |   |   |
-- |       ||  |  |  |  -__|__ --|  _  |        |  -__||  |  |  |       |
-- |___|___||________|_____|_____|_____|__|__|__|_____||________|__|_|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Flying Spaghetti Monster of Code & Core of the Electric Tantra Linux
-- by Thomas Leon Highbaugh
-- ########################################################################
-- ########################################################################
-- ########################################################################

require('configuration.global_variables')
require('configuration.garbage_collection')
require('awful.autofocus')
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Theme
--
beautiful.init(require('theme'))
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Layout
require('layout')
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Configuration

require('configuration')

-- ########################################################################
-- ########################################################################
-- ########################################################################
require('module.notifications')
require('module.auto-start')
require('module.exit-screen')
require('module.quake-terminal')
require('module.menu')
require('module.titlebar')
require('module.brightness-osd')
require('module.volume-osd')

require('module.application-switcher')

-- ░█░█░█▀█░█░░░█░░░█▀█░█▀█░█▀█░█▀▀░█▀▄
-- ░█▄█░█▀█░█░░░█░░░█▀▀░█▀█░█▀▀░█▀▀░█▀▄
-- ░▀░▀░▀░▀░▀▀▀░▀▀▀░▀░░░▀░▀░▀░░░▀▀▀░▀░▀

screen.connect_signal(
    'request::wallpaper',
    function(s)
        -- If wallpaper is a function, call it with the screen
        if beautiful.wallpaper then
            if type(beautiful.wallpaper) == 'string' then
                -- Check if beautiful.wallpaper is color/image
                if beautiful.wallpaper:sub(1, #'#') == '#' then
                    -- If beautiful.wallpaper is color
                    gears.wallpaper.set(beautiful.wallpaper)
                elseif beautiful.wallpaper:sub(1, #'/') == '/' then
                    -- If beautiful.wallpaper is path/image
                    gears.wallpaper.maximized(beautiful.wallpaper, s)
                end
            else
                beautiful.wallpaper(s)
            end
        end
    end
)
