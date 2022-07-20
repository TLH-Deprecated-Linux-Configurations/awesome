--  _______ __ __   __
-- |_     _|__|  |_|  |.-----.
--   |   | |  |   _|  ||  -__|
--   |___| |__|____|__||_____|
--  _______               __
-- |_     _|.-----.--.--.|  |_
--   |   |  |  -__|_   _||   _|
--   |___|  |_____|__.__||____|
-- ------------------------------------------------- --
local user_content =
	wibox.widget {
	text = ' Network Center ',
	font = beautiful.font .. ' Heavy 22',
	halign = 'center',
	valign = 'center',
	align = 'center',
	widget = wibox.widget.textbox
}
local image =
	wibox.widget {
	widget = wibox.widget.imagebox,
	align = 'center',
	valign = 'center',
	image = icons.wifi_3
}
local widget_user =
	wibox.widget {
	layout = wibox.layout.flex.vertical,
	{
		user_content,
		layout = wibox.layout.flex.horizontal
	}
}

local spacer_bar =
	wibox.widget {
	{
		orientation = 'vertical',
		forced_height = dpi(1),
		forced_width = dpi(2),
		shape = gears.shape.rounded_bar,
		widget = wibox.widget.separator
	},
	margins = dpi(10),
	widget = wibox.container.margin
}

local widget =
	wibox.widget {
	{
		image,
		spacer_bar,
		widget_user,
		spacer_bar,
		image,
		spacer_bar,
		layout = wibox.layout.fixed.horizontal
	},
	fg = colors.white,
	bg = beautiful.bg_normal,
	widget = wibox.container.background
}

return widget
