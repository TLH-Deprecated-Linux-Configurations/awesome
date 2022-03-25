--  _______                  __
-- |    ___|.--------.-----.|  |_.--.--.
-- |    ___||        |  _  ||   _|  |  |
-- |_______||__|__|__|   __||____|___  |
--                   |__|        |_____|
-- ------------------------------------------------- --
--  icon that is displayed
local notifIcon =
	wibox.widget {
	{
		{
			{
				image = icons.noNotifications,
				widget = wibox.widget.imagebox
			},
			margins = dpi(5),
			widget = wibox.container.margin
		},
		shape = beautiful.client_shape_rounded,
		widget = wibox.container.background
	},
	forced_width = dpi(70),
	forced_height = dpi(70),
	widget = clickable_container
}
-- ------------------------------------------------- --
-- content of the notification that there are notifications ;]
local content =
	wibox.widget {
	{
		{
			text = "You have no new notifications",
			font = "SF Pro Rounded Heavy  12",
			widget = wibox.widget.textbox
		},
		margins = dpi(10),
		widget = wibox.container.margin
	},
	shape = beautiful.client_shape_rounded,
	bg = beautiful.bg_normal,
	widget = wibox.container.background
}
-- ------------------------------------------------- --
-- box it renders in
local box =
	wibox.widget {
	{
		notifIcon,
		content,
		layout = wibox.layout.align.horizontal
	},
	shape = beautiful.client_shape_rounded_xl,
	fg = colors.white,
	widget = wibox.container.background
}

return box
