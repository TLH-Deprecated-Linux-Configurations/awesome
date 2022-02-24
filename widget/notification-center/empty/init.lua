--  _______                  __
-- |    ___|.--------.-----.|  |_.--.--.
-- |    ___||        |  _  ||   _|  |  |
-- |_______||__|__|__|   __||____|___  |
--                   |__|        |_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
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
		shape = gears.shape.rect,
		bg = beautiful.bg_normal,
		widget = wibox.container.background
	},
	forced_width = dpi(90),
	forced_height = dpi(90),
	widget = clickable_container
}
-- ------------------------------------------------- --
-- content of the notification that there are notifications ;]
local content =
	wibox.widget {
	{
		{
			text = "You have no new notifications",
			font = "Nineteen Ninety Seven  12",
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
	shape = beautiful.client_shape_rounded,
	fg = colors.white,
	border_width = dpi(1),
	border_color = beautiful.bg_normal,
	widget = wibox.container.background
}

return box
