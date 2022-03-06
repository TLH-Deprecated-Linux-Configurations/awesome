local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local clickable_container = require("widget.clickable-container")
local dpi = require("beautiful").xresources.apply_dpi
local icons = require("themes.icons")
local colors = require("themes").colors
local watch = require("awful.widget.watch")

local user_content =
	wibox.widget {
	text = " Bluetooth Center ",
	font = "SF Pro Rounded Heavy 14",
	widget = wibox.widget.textbox
}

local widget_user =
	wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = "none",
	nil,
	{
		user_content,
		layout = wibox.layout.align.horizontal
	},
	nil
}

local spacer_bar =
	wibox.widget {
	{
		orientation = "vertical",
		forced_height = dpi(1),
		forced_width = dpi(2),
		shape = gears.shape.rounded_bar,
		widget = wibox.widget.separator
	},
	margins = dpi(10),
	widget = wibox.container.margin
}

local widget =
	wibox.widget {
	{
		spacer_bar,
		widget_user,
		spacer_bar,
		layout = wibox.layout.fixed.horizontal
	},
	fg = colors.white,
	widget = wibox.container.background
}

return widget
