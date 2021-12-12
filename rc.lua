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
local gears = require('gears')
local beautiful = require('beautiful')
local awful = require('awful')
require('awful.autofocus')
dofile('configuration.global_variables')
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- shell
--
awful.util.shell = 'zsh'

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- theme
beautiful.init(require('theme'))

-- ░█░░░█▀█░█░█░█▀█░█░█░▀█▀
-- ░█░░░█▀█░░█░░█░█░█░█░░█░
-- ░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░░▀░

require('layout')

-- ░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀
-- ░█░░░█░█░█░█░█▀▀░░█░░█░█░█░█░█▀▄░█▀█░░█░░░█░░█░█░█░█░▀▀█
-- ░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀

require('configuration.client')
require('configuration.root')
require('configuration.tags')
root.keys(require('configuration.keys.global'))

-- ░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀░█▀▀
-- ░█░█░█░█░█░█░█░█░█░░░█▀▀░▀▀█
-- ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀

require('module.notifications')
require('module.auto-start')
require('module.exit-screen')
require('module.quake-terminal')
require('module.menu')
require('module.titlebar')
require('module.brightness-osd')
require('module.volume-osd')
require('module.lockscreen')
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

awful.util.spawn_with_shell('nm-applet --indicator &')
awful.util.spawn_with_shell('xfce4-power-manager &')
awful.util.spawn_with_shell('picom &')
awful.util.spawn_with_shell('xfce4-clipman &')
awful.util.spawn_with_shell('numlockx on &')
awful.util.spawn_with_shell(
    '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg) &'
)
awful.util.spawn_with_shell('iris &')
awful.util.spawn_with_shell('virtdown &')
