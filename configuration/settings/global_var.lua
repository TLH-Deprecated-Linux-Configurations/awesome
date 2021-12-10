-- |     __|  |.-----.|  |--.---.-.|  |
-- |    |  |  ||  _  ||  _  |  _  ||  |
-- |_______|__||_____||_____|___._||__|
--  ___ ___              __         __     __
-- |   |   |.---.-.----.|__|.---.-.|  |--.|  |.-----.-----.
-- |   |   ||  _  |   _||  ||  _  ||  _  ||  ||  -__|__ --|
--  \_____/ |___._|__|  |__||___._||_____||__||_____|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- general conf is used by sentry (to opt out of it)
--
general = require("widget.functions.parser")(os.getenv("HOME") .. "/.cache/awesome/general.conf")
awful = require("awful")
awful.screen.set_auto_dpi_enabled(true)
beautiful = require("beautiful")
gears = require("gears")
HOME = os.getenv("HOME")
icons = require("theme.icons")
timer = gears.timer
math = require("math")
cairo = require("lgi").cairo
awful.client = require("awful.client")

wibox = require("wibox")
dpi = beautiful.xresources.apply_dpi
xresources = require("beautiful.xresources")
gfs = gears.filesystem
filesystem = require("gears.filesystem")
modkey = require("configuration.keys.mod").modKey
require("awful.autofocus")
client_buttons = require("configuration.client.buttons")
client_keys = require("configuration.client.keys")
signals = require("configuration.settings.signals")
file = require("widget.functions.file")
spawn = require("awful.spawn")
slider = require("widget.interface.slider")
progressbar = require("widget.interface.progress_bar")
naughty = require("naughty")
math = require("math")
common = require("awful.widget.common")
sound = require("sound")
ipairs = ipairs
ruled = require("ruled")
queue = require("lib.datastructure.queue")()
menubar = require("menubar")
client = client
tag = tag

run_once = require("configuration.settings.application_runner")

serialize = require("widget.functions.serialize")
filehandle = require("widget.functions.file")

volume = require("widget.hardware.volume")
gtable = require("gears.table")
home = os.getenv("HOME")
base = require("wibox.widget.base")
fixed = require("wibox.layout.fixed")
separator = require("wibox.widget.separator")

gshape = require("gears.shape")
gobject = require("gears.object")

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
_G.update_anim_speed(tonumber("1"))
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Theme
--
beautiful.init(require("theme"))

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Require theme initialization first before declaration
--
hardware = require("widget.hardware.hardware-check")
task_list = require("layout.bottom-panel.widgets.task-list")
tag_list = require("layout.bottom-panel.widgets.tag-list")
file = require("widget.functions.file")
clickable_container = require("widget.interface.clickable-container")
delayed_timer = require("widget.functions.delayed-timer")
icons = require("theme.icons")
rubato = require("widget.interface.animations.rubato")
hotkeys_popup = require("widget.interface.hotkeys_popup")
volume = require("widget.hardware.volume")
xrandr = require("widget.hardware.xrandr")
apps = require("configuration.settings.apps")
icon_button = require("widget.interface.icon-button")
seperator_widget = require("layout.left-panel.widgets.separator")
card = require("widget.interface.card")
mat_list_item = require("widget.interface.list-item")
scrollbox = require("widget.interface.scrollbox")
checkbox = require("widget.interface.checkbox")
button = require("widget.interface.button")
config = require("widget.functions")
watch = require "awful.widget.watch"
vicious = require "lib.vicious"
animate = require("widget.interface.animations").createAnimObject

-- #######################################################################
-- ########################################################################
-- ########################################################################
-- ########################################################################
