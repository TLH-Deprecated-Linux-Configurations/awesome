--  _______ __         __           __      ___ ___              __         __     __
-- |     __|  |.-----.|  |--.---.-.|  |    |   |   |.---.-.----.|__|.---.-.|  |--.|  |.-----.-----.
-- |    |  |  ||  _  ||  _  |  _  ||  |    |   |   ||  _  |   _||  ||  _  ||  _  ||  ||  -__|__ --|
-- |_______|__||_____||_____|___._||__|     \_____/ |___._|__|  |__||___._||_____||__||_____|_____|
-- ###############################################
-- ###############################################
-- ###############################################
-- In calling the libraries below I have removed the local keyword which
-- constrains their application to this file specifically as this file
-- calls the other files and assigning these libraries a global scope
-- means no need to call them again later.
-- TODO remove local awful = require'awful' from other files
--
awful = require 'awful'
awestore = require('awestore')
beautiful = require('beautiful')
dpi = beautiful.xresources.apply_dpi
gears = require 'gears'
gfs = require 'gears.filesystem'
helpers = require('helpers')
hotkeys_popup = require('awful.hotkeys_popup')
naughty = require('naughty')
wibox = require('wibox')
xresources = require('beautiful.xresources')

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Enable DPI
--
awful.screen.set_auto_dpi_enabled(true)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Initialize Theme
--
theme = 'vice'
beautiful.init(gfs.get_configuration_dir() .. 'theme/' .. theme .. '/theme.lua')

-- Must come after theme init
--
bling = require 'module.bling'

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- animations
panel_anim =
    awestore.tweened(
    -551,
    {
        duration = 650,
        easing = awestore.easing.circ_in_out
    }
)

strut_anim =
    awestore.tweened(
    0,
    {
        duration = 650,
        easing = awestore.easing.circ_in_out
    }
)

HOME = os.getenv('HOME')

PATH_TO_ICONS = HOME .. '/.config/awesome/theme/icons/matangi/'
