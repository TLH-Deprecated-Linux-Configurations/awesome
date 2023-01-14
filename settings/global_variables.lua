--  _______ __         __           __
-- |     __|  |.-----.|  |--.---.-.|  |
-- |    |  |  ||  _  ||  _  |  _  ||  |
-- |_______|__||_____||_____|___._||__|
--  ___ ___              __         __     __
-- |   |   |.---.-.----.|__|.---.-.|  |--.|  |.-----.-----.
-- |   |   ||  _  |   _||  ||  _  ||  _  ||  ||  -__|__ --|
--  \_____/ |___._|__|  |__||___._||_____||__||_____|_____|
-- ------------------------------------------------- --
-- To prevent needing to call these at the beginning of *most*
-- files, this instead calls them once and they are globally scoped
-- thereafter.

-- ------------------------------------------------- --
-- ------------ Necessary Preliminaries ------------ --
filesystem = require('gears.filesystem')
require('lgi')
config_dir = filesystem.get_configuration_dir()
-- ------------------------------------------------- --
-- ------------------ assignments ------------------ --

debug = debug
keygrabber = keygrabber
mouse = mouse
pairs = pairs
string = string
tonumber = tonumber
tostring = tostring
unpack = unpack or table.unpack
awful = require('awful')
beautiful = require('beautiful')
gears = require('gears')
clickable_container = require('utilities.ui.clickable_container')
filesystem = require('gears.filesystem')
file = require('utilities.platform.file')
inputfield = require('utilities.ui.inputfield')
HOME = os.getenv 'HOME'
icons = require('themes.icons')
naughty = require('naughty')
spawn = require('awful.spawn')
string = require('string')
watch = require('awful.widget.watch')
wibox = require('wibox')
cairo = require('lgi').cairo
modkey = require('configuration.root.keys.mod').mod_key
altkey = require('configuration.root.keys.mod').alt_key
math = require('math')
ruled = require('ruled')
awestore = require('utilities.client.awestore')
client_keys = require('configuration.client.keys')
client_buttons = require('configuration.client.buttons')
gfs = filesystem
menubar = require('menubar')
awful_menu = awful.menu
menu_gen = menubar.menu_gen
menu_utils = menubar.utils
icon_theme = require('menubar.icon_theme')
hotkeys_popup = require('awful.hotkeys_popup').widget
freedesktop = require('utilities.ui.freedesktop')
colors = require('themes').colors
screen_geometry = require('awful').screen.focused().geometry
format_item = require('utilities.ui.format_item')
settings = require('settings')
hotkeys_popup = require('module.hotkeys-popup')
overflow = require('utilities.ui.overflow')
xresources = require('beautiful.xresources')
rubato = require('utilities.client.rubato')
Gio = require('lgi').Gio
awful_menu = require('awful.menu')
menu_gen = require('menubar.menu_gen')
menu_utils = require('menubar.utils')
prompt = require('utilities.ui.prompt')
gobject = require('gears.object')
gtable = require('gears.table')
gtimer = require('gears.timer')
gstring = require('gears.string')

snap_edge = require('utilities.client.snap_edge')
card = require('utilities.ui.card')

hardware = require('utilities.platform.hardware_check')

scrollbox = require('utilities.ui.scrollbox')
os = require('os')
readwrite = require('utilities.platform.readwrite')

-- ------------------------------------------------- --
-- Assignments dependent on above list otherwise it will throw errrors,
-- this results from trial and error (and lots of blood)
--
awful.util.shell = 'zsh'
dpi = beautiful.xresources.apply_dpi
config_dir = filesystem.get_configuration_dir()
utils_dir = config_dir .. 'bin/'

filesystem = gears.filesystem

gtk_variable = beautiful.gtk.get_theme_variables

theme_dir = filesystem.get_configuration_dir() .. '/themes'
titlebar_theme = 'dhumavati'
titlebar_icon_path = theme_dir .. '/icons/titlebar/' .. titlebar_theme .. '/'
tip = titlebar_icon_path
