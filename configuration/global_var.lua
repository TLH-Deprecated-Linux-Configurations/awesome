--  _______ __         __           __      ___ ___              __         __     __
-- |     __|  |.-----.|  |--.---.-.|  |    |   |   |.---.-.----.|__|.---.-.|  |--.|  |.-----.-----.
-- |    |  |  ||  _  ||  _  |  _  ||  |    |   |   ||  _  |   _||  ||  _  ||  _  ||  ||  -__|__ --|
-- |_______|__||_____||_____|___._||__|     \_____/ |___._|__|  |__||___._||_____||__||_____|_____|
-- ###############################################
-- ###############################################
-- ###############################################
-- ###############################################
-- ###############################################
-- ###############################################
-- general conf is used by sentry (to opt out of it)
general = require('module.functions.parser')(os.getenv('HOME') .. '/.cache/awesome/general.conf')
awful = require('awful')
awful.screen.set_auto_dpi_enabled(true)
beautiful = require('beautiful')
gears = require('gears')
HOME = os.getenv 'HOME'
icons = require('theme.icons')
timer = gears.timer
math = require('math')
cairo = require('lgi').cairo

wibox = require('wibox')
dpi = beautiful.xresources.apply_dpi
xresources = require('beautiful.xresources')
gfs = gears.filesystem
filesystem = require 'gears.filesystem'
modkey = require('configuration.keys.mod').modKey
require('awful.autofocus')
client_buttons = require 'configuration.client.buttons'
client_keys = require 'configuration.client.keys'
signals = require('module.settings.signals')
file = require('module.functions.file')
spawn = require('awful.spawn')
slider = require('module.interface.slider')

-- ###############################################
-- ###############################################
-- ###############################################
-- dynamic variables are defined here
-- update the value through this setter, making sure that the animation speed is disabled on weak hardware
_G.update_anim_speed = function(value)
    _G.anim_speed = value
end
-- ###############################################
-- ###############################################
-- ###############################################
_G.update_anim_speed(tonumber('1'))
-- ###############################################
-- ###############################################
-- ###############################################
-- Theme
beautiful.init(require('theme'))
-- ###############################################
-- ###############################################
-- ###############################################
-- Fixes for Default Modules
require('lib.fixed-align')
require('lib.fixed-margin')
