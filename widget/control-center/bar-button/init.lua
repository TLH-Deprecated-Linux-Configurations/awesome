local widget_icon =
	wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = "none",
	nil,
	{
		id = "icon",
		image = icons.magnify,
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
		forced_height = dpi(50),
		widget = clickable_container
	},
	shape = beautiful.client_shape_rounded_small,
	bg = beautiful.bg_normal,
	widget = wibox.container.background
}

awesome.connect_signal(
	"bar:false",
	function()
		widget.bg = beautiful.accent
	end
)

awesome.connect_signal(
	"bar:true",
	function()
		widget.bg = beautiful.bg_normal
	end
)

widget:buttons(
	gears.table.join(
		awful.button(
			{},
			1,
			nil,
			function()
				awesome.emit_signal("bar:toggle")
				cc_resize()
				widget.bg = beautiful.bg_normal
			end
		)
	)
)

return widget
