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
clickable_container = require('widget.clickable-container')
filesystem = require('gears.filesystem')
gears = require('gears')
HOME = os.getenv 'HOME'
icons = require('theme.icons')
naughty = require('naughty')
spawn = require('awful.spawn')
string = require('string')
task_list = require('widget.task-list')
watch = require('awful.widget.watch')
wibox = require('wibox')
cairo = require('lgi').cairo

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Assignments dependent on above list
awful.util.shell = 'zsh'
dpi = beautiful.xresources.apply_dpi
config_dir = filesystem.get_configuration_dir()
utils_dir = config_dir .. 'utilities/'
