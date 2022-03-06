local left_content =
	wibox.widget {
	text = "status",
	font = "SF Pro Rounded Heavy 14",
	widget = wibox.widget.textbox
}

local right_content =
	wibox.widget {
	text = "placeholder",
	font = "SF Pro Rounded Heavy 14",
	widget = wibox.widget.textbox
}

local widget_user =
	wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = "none",
	nil,
	{
		left_content,
		layout = wibox.layout.align.horizontal
	},
	nil
}

local widget_host =
	wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = "none",
	nil,
	{
		right_content,
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

awesome.connect_signal(
	"network::connected::wireless",
	function(interface, essid)
		right_content:set_text(essid)
	end
)

local widget =
	wibox.widget {
	{
		widget_user,
		spacer_bar,
		widget_host,
		layout = wibox.layout.fixed.horizontal
	},
	fg = beautiful.white,
	widget = wibox.container.background
}

return widget
