--  _______ __ __   __
-- |_     _|__|  |_|  |.-----.
--   |   | |  |   _|  ||  -__|
--   |___| |__|____|__||_____|
--  _______               __
-- |_     _|.-----.--.--.|  |_
--   |   |  |  -__|_   _||   _|
--   |___|  |_____|__.__||____|
-- ------------------------------------------------- --
local host_content =
	wibox.widget {
	text = "Control Center",
	font = "Nineteen Ninety Seven Bold 16",
	widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
local widget_host =
	wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = "none",
	shape = gears.shape.rounded_rect,
	bg = colors.colorA,
	fg = colors.white,
	nil,
	{
		host_content,
		layout = wibox.layout.flex.horizontal,
		valign = "center",
		halign = "right"
	},
	nil
}
-- ------------------------------------------------- --
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

-- ------------------------------------------------- --
-- title of the center
local title =
	wibox.widget {
	{
		{
			spacing = dpi(0),
			layout = wibox.layout.fixed.vertical,
			format_item(
				{
					layout = wibox.layout.align.horizontal,
					spacing = dpi(30),
					require("widget.user-icon"),
					{
						layout = wibox.container.place,
						halign = "center",
						valign = "center",
						{
							spacer_bar,
							widget_host,
							spacer_bar,
							layout = wibox.layout.fixed.horizontal,
							fg = colors.white
						}
					},
					require("widget.user-icon")
				}
			)
		},
		margins = dpi(5),
		widget = wibox.container.margin
	},
	shape = beautiful.client_shape_rounded_xl,
	bg = beautiful.bg_normal,
	forced_width = dpi(475),
	forced_height = dpi(70),
	border_width = dpi(2),
	border_color = colors.colorA,
	widget = wibox.container.background
}
return title
