--  _______
-- |     __|.----.----.-----.-----.-----.
-- |__     ||  __|   _|  -__|  -__|     |
-- |_______||____|__| |_____|_____|__|__|
--  ______               __
-- |      |.---.-.-----.|  |_.--.--.----.-----.
-- |   ---||  _  |  _  ||   _|  |  |   _|  -__|
-- |______||___._|   __||____|_____|__| |_____|
--               |__|
-- ------------------------------------------------- --
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local clickable_container = require("widget.clickable-container")
local dpi = require("beautiful").xresources.apply_dpi
local icons = require("themes.icons")
local colors = require("themes").colors
local watch = require("awful.widget.watch")

local widget_icon =
	wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = "none",
	nil,
	{
		id = "icon",
		image = icons.recording_button,
		resize = true,
		widget = wibox.widget.imagebox
	},
	nil
}

local widget =
	wibox.widget {
	{
		{
			{
				widget_icon,
				layout = wibox.layout.fixed.horizontal
			},
			margins = dpi(15),
			widget = wibox.container.margin
		},
		forced_height = dpi(60),
		widget = clickable_container
	},
	shape = beautiful.client_shape_rounded,
	bg = colors.colorA,
	widget = wibox.container.background
}

widget:connect_signal(
	"mouse::enter",
	function()
		widget.bg = beautiful.accent
	end
)

widget:connect_signal(
	"mouse::leave",
	function()
		widget.bg = colors.colorA
	end
)

widget:buttons(
	gears.table.join(
		awful.button(
			{},
			1,
			nil,
			function()
				cc_toggle()
				awful.spawn.with_shell(gfs .. "bin/snapshot.sh full")
			end
		)
	)
)

return widget
