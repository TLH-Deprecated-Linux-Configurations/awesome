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
		widget = wibox.widget.imagebox
	},
	nil
}
-- ------------------------------------------------- --
local widget =
	wibox.widget {
	{
		{
			{
				widget_icon,
				layout = wibox.layout.fixed.horizontal
			},
			margins = dpi(10),
			widget = wibox.container.margin
		},
		forced_height = dpi(50),
		widget = clickable_container
	},
	shape = beautiful.client_shape_rounded_small,
	bg = colors.colorA,
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
		widget.bg = colors.colorA
	end
)
-- ------------------------------------------------- --
widget:buttons(gears.table.join(awful.button({}, 1, nil, awesome.restart)))

return widget
