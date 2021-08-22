-- rc.lua
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')

-- Standard awesome library
local gfs = require('gears.filesystem')
local awful = require('awful')
require('awful.autofocus')

-- Theme handling library
local beautiful = require('beautiful')

-- Notification library
local naughty = require('naughty')

local hotkeys_popup = require('awful.hotkeys_popup')
require('awful.hotkeys_popup.keys')

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal(
    'request::display_error',
    function(message, startup)
        naughty.notification {
            urgency = 'critical',
            title = 'Oops, an error happened' .. (startup and ' during startup!' or '!'),
            message = message
        }
    end
)

-- Initialize Theme
local theme = 'ghosts'
beautiful.init(gfs.get_configuration_dir() .. 'theme/' .. theme .. '/theme.lua')

-- Import Configuration
require('configuration')

-- Screen Padding and Tags
screen.connect_signal(
    'request::desktop_decoration',
    function(s)
        -- Screen padding
        screen[s].padding = {left = 0, right = 0, top = 0, bottom = 0}
        -- Each screen has its own tag table.
        awful.tag({'1', '2', '3', '4', '5'}, s, awful.layout.layouts[1])
    end
)

-- Import Daemons and Widgets
require('signal')
require('ui')

-- Create a launcher widget and a main menu
awesomemenu = {
    {
        'Key Binds',
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end
    },
    {'Manual', terminal .. ' start man awesome'},
    {'Edit Config', editor .. ' ' .. awesome.conffile},
    {'Restart', awesome.restart},
    {
        'Quit',
        function()
            awesome.quit()
        end
    }
}

appmenu = {{'Terminal', terminal}, {'Editor', editor}, {'Browser', browser}, {'Menu', launcher}}

mymainmenu =
    awful.menu(
    {
        items = {
            {'AwesomeWM', awesomemenu, beautiful.awesome_icon},
            {'Apps', appmenu}
        }
    }
)

awful.mouse.append_global_mousebindings(
    {
        awful.button(
            {},
            3,
            function()
                mymainmenu:toggle()
            end
        )
    }
)

local blacklisted_snid = setmetatable({}, {__mode = 'v'})

-- Garbage Collector Settings
collectgarbage('setpause', 110)
collectgarbage('setstepmul', 1000)

-- Use the following for a less intense, more battery saving GC
-- collectgarbage("setpause", 160)
-- collectgarbage("setstepmul", 400)
