local host_content =
	wibox.widget {
	text = "Control Center",
	font = "SF Pro Rounded Heavy    18",
	widget = wibox.widget.textbox
}

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
		widget_host,
		spacer_bar,
		layout = wibox.layout.fixed.horizontal
	},
	fg = colors.white,
	widget = wibox.container.background
}

return widget
