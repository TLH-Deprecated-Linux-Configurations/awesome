--  ______               ___ __                          __   __
-- |      |.-----.-----.'  _|__|.-----.--.--.----.---.-.|  |_|__|.-----.-----.
-- |   ---||  _  |     |   _|  ||  _  |  |  |   _|  _  ||   _|  ||  _  |     |
-- |______||_____|__|__|__| |__||___  |_____|__| |___._||____|__||_____|__|__|
--                              |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Nexus and central point of the configuration files that modify some builtin
-- feature or functionality of the WM and provides user defaults
local awful = require('awful')
local gears = require('gears')
local gfs = gears.filesystem
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

local bling = require('module.bling')
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Default Applications
terminal = 'kitty'
editor = 'nvim'
editor_cmd = terminal .. ' start ' .. os.getenv('EDITOR')
browser = 'firefox'
filemanager = 'thunar'
discord = 'telegram'
launcher = 'rofi -show drun -theme .config/awesome/ui/appmenu/drun.rasi'
music = terminal .. ' start --class music ncmpcpp'
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Global Vars
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Default modkey.
-- This is generally the Voldemort(WINDOWS) key everyone acts like they can't even name.
modkey = 'Mod4'
altkey = 'Mod1'
shift = 'Shift'
ctrl = 'Control'
-- ########################################################################
-- ########################################################################
-- ########################################################################
local yy = 10 + beautiful.wibar_height

-- Enable Playerctl Module from Bling
bling.signal.playerctl.enable {
    ignore = {'chromium'},
    backend = 'playerctl_lib',
    update_on_activity = true
}
-- Provides preview of tag when hovered, very nifty
bling.widget.tag_preview.enable {
    show_client_content = false,
    x = dpi(10),
    y = dpi(750) + beautiful.wibar_height,
    scale = 0.15,
    honor_padding = true,
    honor_workarea = false
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Set Wallpaper
screen.connect_signal(
    'request::wallpaper',
    function(s)
        gears.wallpaper.maximized(beautiful.wallpaper, s, false, nil)
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Set Autostart Applications
require 'configuration.autostart'

-- Garbage Collection
require 'configuration.garbage_collection'

-- Get Keybinds
require 'configuration.keys'

-- Get Rules
require 'configuration.ruled'

-- Layouts and Window Stuff
require 'configuration.window'
