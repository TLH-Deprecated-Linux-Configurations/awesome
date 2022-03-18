--  _______ __         __           __
-- |     __|  |.-----.|  |--.---.-.|  |
-- |    |  |  ||  _  ||  _  |  _  ||  |
-- |_______|__||_____||_____|___._||__|
--  ___ ___              __         __     __
-- |   |   |.---.-.----.|__|.---.-.|  |--.|  |.-----.-----.
-- |   |   ||  _  |   _||  ||  _  ||  _  ||  ||  -__|__ --|
--  \_____/ |___._|__|  |__||___._||_____||__||_____|_____|
-- ------------------------------------------------- --
-- This makes for neater files without boilerplate and improves the
-- developer experience considerably compared to the standard use of
-- require statements to call libraries in per file
-- ------------------------------------------------- --
--assignments

awful = require("awful")
beautiful = require("beautiful")
gears = require("gears")
clickable_container = require("utils.clickable-container")
filesystem = require("gears.filesystem")
gears = require("gears")
HOME = os.getenv "HOME"
icons = require("themes.icons")
naughty = require("naughty")
spawn = require("awful.spawn")
string = require("string")
watch = require("awful.widget.watch")
wibox = require("wibox")
cairo = require("lgi").cairo
modkey = require("config.keys.mod").mod_key
altkey = require("config.keys.mod").alt_key
math = require("math")
ruled = require("ruled")
awestore = require("module.awestore")
client_keys = require("config.client.keys")
client_buttons = require("config.client.buttons")
gfs = gears.filesystem
menubar = require("menubar")
awful_menu = awful.menu
menu_gen = menubar.menu_gen
menu_utils = menubar.utils
icon_theme = require("menubar.icon_theme")
hotkeys_popup = require("awful.hotkeys_popup").widget
freedesktop = require("module.freedesktop")
colors = require("themes").colors
screen_geometry = require("awful").screen.focused().geometry
format_item = require("utils.format_item")
settings = require("settings")
hotkeys_popup = require("module.hotkeys-popup")

xresources = require("beautiful.xresources")
gears = require("gears")

Gio = require("lgi").Gio
awful_menu = require("awful.menu")
menu_gen = require("menubar.menu_gen")
menu_utils = require("menubar.utils")

-- ------------------------------------------------- --
-- Assignments dependent on above list otherwise it will throw errrors,
-- this results from trial and error (and lots of blood)
--
awful.util.shell = "zsh"
dpi = beautiful.xresources.apply_dpi
config_dir = filesystem.get_configuration_dir()
utils_dir = config_dir .. "bin/"

filesystem = gears.filesystem

gtk_variable = beautiful.gtk.get_theme_variables

theme_dir = filesystem.get_configuration_dir() .. "/themes"
titlebar_theme = "dhumavati"
titlebar_icon_path = theme_dir .. "/icons/titlebar/" .. titlebar_theme .. "/"
tip = titlebar_icon_path
