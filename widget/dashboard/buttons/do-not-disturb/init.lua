--  _____  _______ _____
-- |     \|    |  |     \
-- |  --  |       |  --  |
-- |_____/|__|____|_____/

local widget_icon =
	wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = "none",
	nil,
	{
		id = "icon",
		image = icons.airplane_mode,
		resize = true,
		widget = wibox.widget.imagebox,
		forced_width = dpi(80),
		forced_height = dpi(80),
		valign = "center",
		align = "center"
	},
	nil
}

local widget =
	wibox.widget {
	{
		{
			{
				{
					widget_icon,
					layout = wibox.layout.fixed.horizontal
				},
				margins = dpi(10),
				widget = wibox.container.margin
			},
			widget = clickable_container
		},
		widget = wibox.container.margin,
		margins = dpi(5)
	},
	shape = beautiful.client_shape_rounded_xl,
	bg = beautiful.bg_focus,
	widget = wibox.container.background
}

_G.dnd_status = false

widget:buttons(
	gears.table.join(
		awful.button(
			{},
			1,
			nil,
			function()
				if dnd_status == true then
					dnd_status = false
					widget.bg = beautiful.bg_focus
				elseif dnd_status == false then
					dnd_status = true
					widget.bg = beautiful.accent
				end
			end
		)
	)
)

return widget
