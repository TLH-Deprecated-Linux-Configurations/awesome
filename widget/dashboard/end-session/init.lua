--  _______           __
-- |    ___|.-----.--|  |
-- |    ___||     |  _  |
-- |_______||__|__|_____|

--  _______                     __
-- |     __|.-----.-----.-----.|__|.-----.-----.
-- |__     ||  -__|__ --|__ --||  ||  _  |     |
-- |_______||_____|_____|_____||__||_____|__|__|

--  ________ __     __               __
-- |  |  |  |__|.--|  |.-----.-----.|  |_
-- |  |  |  |  ||  _  ||  _  |  -__||   _|
-- |________|__||_____||___  |_____||____|
--                     |_____|
-- ------------------------------------------------- --
local widget_button =
	wibox.widget {
	{
		{
			{
				{
					image = icons.power,
					widget = wibox.widget.imagebox
				},
				widget = wibox.container.place,
				valign = "Center",
				halign = "center"
			},
			forced_width = dpi(48),
			forced_height = dpi(48),
			widget = clickable_container
		},
		shape = beautiful.client_shape_rounded_medium,
		bg = colors.black,
		widget = wibox.container.background
	},
	margins = dpi(3),
	widget = wibox.container.margin
}

widget_button:buttons(
	gears.table.join(
		awful.button(
			{},
			1,
			nil,
			function()
				_G.exit_screen_show()
			end
		)
	)
)

return widget_button
