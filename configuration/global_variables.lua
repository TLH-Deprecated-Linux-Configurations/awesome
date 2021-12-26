--  _______ __         __           __
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
-- This makes for neater files without boilerplate and improves the
-- developer experience considerably compared to the standard use of
-- require statements to call libraries in per file
-- ########################################################################
-- ########################################################################
-- ########################################################################
--assignments
awful = require('awful')
beautiful = require('beautiful')
gears = require('gears')
clickable_container = require('module.clickable-container')
filesystem = require('gears.filesystem')
gears = require('gears')
HOME = os.getenv 'HOME'
icons = require('theme.icons')
naughty = require('naughty')
spawn = require('awful.spawn')
string = require('string')
task_list = require('layout.bottom-panel.widget.task-list')
watch = require('awful.widget.watch')
wibox = require('wibox')
cairo = require('lgi').cairo
modkey = require('configuration.keys.mod').mod_key
altkey = require('configuration.keys.mod').alt_key
math = require('math')
ruled = require('ruled')

client_keys = require('configuration.client.keys')
client_buttons = require('configuration.client.buttons')

menubar = require('menubar')
awful_menu = awful.menu
menu_gen = menubar.menu_gen
menu_utils = menubar.utils
icon_theme = require('menubar.icon_theme')
hotkeys_popup = require('awful.hotkeys_popup').widget

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Assignments dependent on above list otherwise it will throw errrors,
-- this results from trial and error (and lots of blood)
--
awful.util.shell = 'zsh'
dpi = beautiful.xresources.apply_dpi
config_dir = filesystem.get_configuration_dir()
utils_dir = config_dir .. 'bin/'
apps = require('configuration.apps')

terminal = apps.default.terminal
web_browser = apps.default.web_browser
file_manager = apps.default.file_manager
text_editor = apps.default.text_editor
editor_cmd = terminal .. ' -e ' .. (os.getenv('EDITOR') or 'nano')
