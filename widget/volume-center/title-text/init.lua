local user_content =
	wibox.widget {
	text = " Volume Center ",
	font = "Nineteen Ninety Seven  Regular  14",
	widget = wibox.widget.textbox
}

local widget_user =
	wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = "max",
	nil,
	{
		user_content,
		layout = wibox.layout.flex.horizontal
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
	fg = beautiful.g,
	widget = wibox.container.background
}

return widget
