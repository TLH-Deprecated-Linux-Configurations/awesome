--  _______                  __
-- |    ___|.--------.-----.|  |_.--.--.
-- |    ___||        |  _  ||   _|  |  |
-- |_______||__|__|__|   __||____|___  |
--                   |__|        |_____|
-- ------------------------------------------------- --

-- ------------------------------------------------- --
-- NOTE box it renders in
local box =
	wibox.widget {
	{
		{
			layout = wibox.layout.align.horizontal,
			nil,
			{
				text = 'No New Notifications',
				font = 'Operaror SSm Black 12',
				widget = wibox.widget.textbox,
				align = 'center'
			},
			nil
		},
		widget = wibox.container.margin,
		margins = dpi(5)
	},
	shape = beautiful.client_shape_rounded_xl,
	fg = colors.white,
	bg = beautiful.bg_panel,
	widget = wibox.container.background
}

return box
