--  _______                                             ________ _______
-- |   _   |.--.--.--.-----.-----.-----.--------.-----.|  |  |  |   |   |
-- |       ||  |  |  |  -__|__ --|  _  |        |  -__||  |  |  |       |
-- |___|___||________|_____|_____|_____|__|__|__|_____||________|__|_|__|

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
--
pcall(require, 'luarocks.loader')
-- ########################################################################
require 'configuration.global_variables'
-- ########################################################################
require 'awful.autofocus'
-- ########################################################################
require('awful.hotkeys_popup.keys')
-- ########################################################################
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
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Import Daemons and Widgets
--
require('signal')
require('ui')

local blacklisted_snid = setmetatable({}, {__mode = 'v'})
