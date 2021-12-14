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

gears = require('gears')
beautiful = require('beautiful')
awful = require('awful')
wibox = require('wibox')

filesystem = require('gears.filesystem')
config_dir = filesystem.get_configuration_dir()
utils_dir = config_dir .. 'utilities/'
HOME = os.getenv 'HOME'
clickable_container = require('widget.clickable-container')
beautiful = require('beautiful')
dpi = beautiful.xresources.apply_dpi
--assignments
awful.util.shell = 'zsh'
awful = require('awful')
wibox = require('wibox')
gears = require('gears')
naughty = require('naughty')
string = require('string')
watch = require('awful.widget.watch')
spawn = require('awful.spawn')
