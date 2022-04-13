--  ______
-- |   __ \.---.-.----.
-- |   __ <|  _  |   _|
-- |______/|___._|__|
--  ______         __   __
-- |   __ \.--.--.|  |_|  |_.-----.-----.
-- |   __ <|  |  ||   _|   _|  _  |     |
-- |______/|_____||____|____|_____|__|__|
-- ------------------------------------------------- --
local widget_icon =
	wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = "none",
	nil,
	{
		id = "icon",
		image = icons.awesome,
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
		margins = dpi(5),
		widget = wibox.container.margin
	},
	shape = beautiful.client_shape_rounded_xl,
	bg = beautiful.bg_focus,
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
		widget.bg = beautiful.bg_focus
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

				widget.bg = beautiful.bg_focus
			end
		)
	)
)

return widget
