--  ___ ___ __                  _______ __
-- |   |   |__|.----.-----.    |_     _|  |--.-----.--------.-----.
-- |   |   |  ||  __|  -__|      |   | |     |  -__|        |  -__|
--  \_____/|__||____|_____|      |___| |__|__|_____|__|__|__|_____|

-- ########################################################################
-- Totally unnecessary file, but having this here gives me the option of
-- adding a new theme in the future, which is an option I prefer having
-- ########################################################################
-- ########################################################################
-- ########################################################################
local filesystem = require("gears.filesystem")
local theme_dir = filesystem.get_configuration_dir() .. "/theme"

-- ########################################################################
-- ########################################################################
-- ########################################################################

local theme = {}
-- ########################################################################
-- ########################################################################
-- ########################################################################
theme.icons = theme_dir .. "/icons/"
theme.font = "SF Mono Powerline Bold "
theme.monitor_font = "SF Mono Powerline Bold 50"
theme.title_font = "SF Mono Powerline Bold 18"
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Colors Pallets
-- Load ~/.Xresources colors and set fallback colors
theme.xbackground = "#17191e" .. "66"
theme.background = "#17191e" .. "66"
theme.xforeground = "#b2bfd9"
theme.foreground = "#b2bfd9"
theme.xcolor0 = "#22262d"
theme.xcolor8 = "#2f303d"
theme.xcolor16 = "#3c3f4c"
theme.xcolor17 = "#0b0c0f"
theme.xcolor18 = "#383a47"
theme.xcolor19 = "#555e70"
theme.xcolor20 = "#727f96"
theme.xcolor21 = "#555566"

theme.xcolor1 = "#ff28a9"
theme.xcolor9 = "#ff3d81"

theme.xcolor2 = "#33ffdd"
theme.xcolor10 = "#00ffcc"

theme.xcolor3 = "#f0ffaa"
theme.xcolor11 = "#F1FA8C"

theme.xcolor13 = "#6c71c4"
theme.xcolor5 = "#8265ff"

theme.xcolor14 = "#00fae9"
theme.xcolor6 = "#00eaff"

theme.xcolor7 = "#8b9cbe"
theme.xcolor15 = "#f4f4f7"

theme.xcolor4 = "#0badff"
theme.xcolor12 = "#00caff"
-- ########################################################################
-- ########################################################################
-- ########################################################################
theme.background_transparency = "66"

-- Accent color
theme.accent = theme.xcolor7

-- Transparent
theme.transparent = "#00000000"

-- Awesome icon
theme.awesome_icon = theme.icons .. "awesome.svg"

local awesome_overrides = function(theme)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local gears = require("gears")
local icon_path = gears.filesystem.get_configuration_dir() .. "theme/icons/"
local titlebar_icon_path = icon_path .. "titlebar/"

theme.titlebar_close_button_normal = titlebar_icon_path .. "close_normal.svg"
theme.titlebar_close_button_focus = titlebar_icon_path .. "close_focus.svg"

theme.titlebar_minimize_button_normal = titlebar_icon_path .. "minimize_normal.svg"
theme.titlebar_minimize_button_focus = titlebar_icon_path .. "minimize_focus.svg"

theme.titlebar_ontop_button_normal_inactive = titlebar_icon_path .. "ontop_normal_inactive.svg"
theme.titlebar_ontop_button_focus_inactive = titlebar_icon_path .. "ontop_focus_inactive.svg"
theme.titlebar_ontop_button_normal_active = titlebar_icon_path .. "ontop_normal_active.svg"
theme.titlebar_ontop_button_focus_active = titlebar_icon_path .. "ontop_focus_active.svg"

theme.titlebar_sticky_button_normal_inactive = titlebar_icon_path .. "sticky_normal_inactive.svg"
theme.titlebar_sticky_button_focus_inactive = titlebar_icon_path .. "sticky_focus_inactive.svg"
theme.titlebar_sticky_button_normal_active = titlebar_icon_path .. "sticky_normal_active.svg"
theme.titlebar_sticky_button_focus_active = titlebar_icon_path .. "sticky_focus_active.svg"

theme.titlebar_floating_button_normal_inactive = titlebar_icon_path .. "floating_normal_inactive.svg"
theme.titlebar_floating_button_focus_inactive = titlebar_icon_path .. "floating_focus_inactive.svg"
theme.titlebar_floating_button_normal_active = titlebar_icon_path .. "floating_normal_active.svg"
theme.titlebar_floating_button_focus_active = titlebar_icon_path .. "floating_focus_active.svg"

theme.titlebar_maximized_button_normal_inactive = titlebar_icon_path .. "maximized_normal_inactive.svg"
theme.titlebar_maximized_button_focus_inactive = titlebar_icon_path .. "maximized_focus_inactive.svg"
theme.titlebar_maximized_button_normal_active = titlebar_icon_path .. "maximized_normal_active.svg"
theme.titlebar_maximized_button_focus_active = titlebar_icon_path .. "maximized_focus_active.svg"
-- ########################################################################
-- ########################################################################
-- ########################################################################
theme.background = {
	type = "linear",
	from = {0, 0},
	to = {-55, -55},
	stops = {
		{0, theme.xbackground .. "66"},
		{0.45, theme.xcolor0 .. "66"},
		{0.85, theme.xbackground .. "66"},
		{1, theme.xcolor19 .. "66"}
	}
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
return {
	theme = theme,
	awesome_overrides = awesome_overrides
}
