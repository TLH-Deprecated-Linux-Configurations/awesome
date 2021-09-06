--  _______ __         __           __      ___ ___              __         __     __
-- |     __|  |.-----.|  |--.---.-.|  |    |   |   |.---.-.----.|__|.---.-.|  |--.|  |.-----.-----.
-- |    |  |  ||  _  ||  _  |  _  ||  |    |   |   ||  _  |   _||  ||  _  ||  _  ||  ||  -__|__ --|
-- |_______|__||_____||_____|___._||__|     \_____/ |___._|__|  |__||___._||_____||__||_____|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- general conf is used by sentry (to opt out of it)
--
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
awful.client = require('awful.client')
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
naughty = require 'naughty'
math = require('math')

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- dynamic variables are defined here
-- update the value through this setter
--
_G.update_anim_speed = function(value)
    _G.anim_speed = value
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
_G.update_anim_speed(tonumber('1'))
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Theme
--
beautiful.init(require('theme'))
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Fixes for Default Modules
--
require('lib.fixed-align')
require('lib.fixed-margin')
require('awful.hotkeys_popup.keys')
-- ########################################################################
-- ########################################################################
-- ########################################################################
--Require theme initialization first before declaration
--
hardware = require('module.hardware.hardware-check')
task_list = require('layout.bottom-panel.widgets.task-list')
tag_list = require('layout.bottom-panel.widgets.tag-list')
file = require 'module.functions.file'
clickable_container = require 'widget.clickable-container'
delayed_timer = require('lib.function.delayed-timer')
icons = require('theme.icons')
rubato = require('module.interface.animations.rubato')
hotkeys_popup = require('awful.hotkeys_popup').widget
volume = require('module.hardware.volume')
xrandr = require('module.hardware.xrandr')
apps = require('configuration.apps')
mat_icon = require('module.interface.material.icon-button')
seperator_widget = require('layout.left-panel.widgets.separator')
button = require('module.interface.button')
card = require('module.interface.card')
mat_list_item = require('module.interface.material.list-item')
scrollbox = require('module.interface.scrollbox')
checkbox = require('module.interface.checkbox')

-- ########################################################################
-- ########################################################################
-- ########################################################################
