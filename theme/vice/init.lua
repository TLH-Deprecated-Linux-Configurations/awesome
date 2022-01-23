--  ___ ___ __
-- |   |   |__|.----.-----.
-- |   |   |  ||  __|  -__|
--  \_____/|__||____|_____|

--  _______ __
-- |_     _|  |--.-----.--------.-----.
--   |   | |     |  -__|        |  -__|
--   |___| |__|__|_____|__|__|__|_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- This is the theme file, which is rather minimal as
-- `theme/default-theme.lua` is doing most of the heavy lifting while this
-- file is reserved primarily for the purpose of setting the default color
-- scheme the widgets could pull from (but don't usually tbh)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Import libraries and modules
--
local filesystem = require('gears.filesystem')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- setup declaration
--
local theme = {}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Set Icons Location and Default Font
--
theme.icons = theme_dir .. '/icons/'
theme.font = 'SFMono Nerd Font Mono Heavy  10'
theme.font_bold = 'SFMono Nerd Font Mono Heavy  10'
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Colorscheme
--
theme.system_black_dark = '#17191e'
theme.system_black_light = '#555e70'

theme.system_red_dark = '#ff28a9'
theme.system_red_light = '#ff3d81'

theme.system_green_dark = '#44ffdd'
theme.system_green_light = '#00ffcc'

theme.system_yellow_dark = '#F9f871'
theme.system_yellow_light = '#F0ffaa'

theme.system_blue_dark = '#0badff'
theme.system_blue_light = '#00caff'

theme.system_magenta_dark = '#6c71c4'
theme.system_magenta_light = '#8265ff'

theme.system_cyan_dark = '#00eaff'
theme.system_cyan_light = '#00fae9'

theme.system_white_dark = '#b2bfd9'
theme.system_white_light = '#F4f4f7'

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Accent color
--
theme.accent = 'linear:0,0:0,51:0,#8b9cbe:1,#5A647A'
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Background color
--
theme.background = '#00000066'
theme.background_light = '#f2f2f266'
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Transparent
--
theme.transparent = '#00000033'
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Awesome icon
--
theme.awesome_icon = theme.icons .. 'awesome.svg'
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- add theme additions to overrides function
local awesome_overrides = function(theme)
end
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- return overrides and theme
return {
    theme = theme,
    awesome_overrides = awesome_overrides
}
