--  _______                             __
-- |    ___|.-----.----.--------.---.-.|  |_
-- |    ___||  _  |   _|        |  _  ||   _|
-- |___|    |_____|__| |__|__|__|___._||____|
--  _______ __
-- |_     _|  |_.-----.--------.
--  _|   |_|   _|  -__|        |
-- |_______|____|_____|__|__|__|
-- ------------------------------------------------- --

local format_item = function(widget)
	return wibox.widget {
		{
			{
				layout = wibox.layout.align.vertical,
				expand = "none",
				nil,
				widget,
				nil
			},
			margins = dpi(5),
			widget = wibox.container.margin
		},
		shape = beautiful.client_shape_rounded_xl,
		bg = "transparent",
		border_width = dpi(0),
		border_color = colors.black,
		widget = wibox.container.background
	}
end

return format_item
