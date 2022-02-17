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
local filesystem = require("gears.filesystem")
local theme_dir = filesystem.get_configuration_dir() .. "/theme"
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
theme.icons = theme_dir .. "/icons/"
theme.font = "Nineteen Ninety Seven Regular  10"
theme.font_bold = "Nineteen Ninety Seven Regular  10"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Colorscheme
--
theme.system_black_dark = "#17191e"
theme.xcolor0 = theme.system_black_dark
theme.system_black_light = "#555e70"
theme.xcolor8 = theme.system_black_light

theme.system_red_dark = "#ff28a9"
theme.xcolor1 = theme.system_red_dark
theme.system_red_light = "#ff3d81"
theme.xcolor9 = theme.system_red_light
theme.system_green_dark = "#44ffdd"
theme.xcolor2 = theme.system_green_dark
theme.system_green_light = "#00ffcc"
theme.xcolor10 = theme.system_green_light

theme.system_yellow_dark = "#F9f871"
theme.xcolor3 = theme.system_yellow_dark
theme.system_yellow_light = "#F0ffaa"
theme.xcolor11 = theme.system_yellow_light
theme.system_blue_dark = "#0badff"
theme.xcolor4 = theme.system_blue_dark
theme.system_blue_light = "#00caff"
theme.xcolor12 = theme.system_blue_light
theme.system_magenta_dark = "#6c71c4"
theme.xcolor5 = theme.system_magenta_dark
theme.system_magenta_light = "#8265ff"
theme.xcolor13 = theme.system_magenta_light
theme.system_cyan_dark = "#00eaff"
theme.xcolor6 = theme.system_cyan_dark
theme.system_cyan_light = "#00fae9"
theme.xcolor14 = theme.system_cyan_light
theme.system_white_dark = "#b2bfd9"
theme.xcolor7 = theme.system_white_dark
theme.system_white_light = "#F4f4f7"
theme.xcolor15 = theme.system_white_light

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Accent color
--
theme.accent = "linear:0,0:0,51:0,#8b9cbe:1,#5A647A"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Background color
--
theme.background = "#00000066"
theme.background_light = "#f2f2f266"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Transparent
--
theme.transparent = "#00000033"
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Awesome icon
--
theme.awesome_icon = theme.icons .. "awesome.svg"
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
