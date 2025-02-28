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
	text = ' Bluetooth ',
	font = 'Operaror SSm Black 22',
	widget = wibox.widget.textbox
}

local widget_user =
	wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = 'none',
	nil,
	{
		user_content,
		layout = wibox.layout.align.horizontal
	},
	nil
}

local widget =
	wibox.widget {
	{
		widget_user,
		layout = wibox.layout.fixed.horizontal
	},
	fg = colors.white,
	widget = wibox.container.background
}

return widget
