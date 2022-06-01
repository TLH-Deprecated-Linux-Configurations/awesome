--  ______               __               __
-- |   __ \.-----.-----.|  |_.---.-.----.|  |_
-- |      <|  -__|__ --||   _|  _  |   _||   _|
-- |___|__||_____|_____||____|___._|__|  |____|

--  _______
-- |   _   |.--.--.--.-----.-----.-----.--------.-----.
-- |       ||  |  |  |  -__|__ --|  _  |        |  -__|
-- |___|___||________|_____|_____|_____|__|__|__|_____|

-- ------------------------------------------------- --

local widget_icon =
	wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = "none",
	nil,
	{
		id = "icon",
		image = icons.restart,
		resize = true,
		widget = wibox.widget.imagebox,
		valign = "center",
		align = "center",
		forced_height = dpi(80),
		forced_width = dpi(80)
	},
	nil
}
-- ------------------------------------------------- --
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
-- ------------------------------------------------- --
widget:connect_signal(
	"mouse::enter",
	function()
		widget.bg = beautiful.accent
	end
)
-- ------------------------------------------------- --
widget:connect_signal(
	"mouse::leave",
	function()
		widget.bg = beautiful.bg_focus
	end
)
-- ------------------------------------------------- --
widget:buttons(gears.table.join(awful.button({}, 1, nil, awesome.restart)))

return widget
