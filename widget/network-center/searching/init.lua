--  _______                         __     __
-- |     __|.-----.---.-.----.----.|  |--.|__|.-----.-----.
-- |__     ||  -__|  _  |   _|  __||     ||  ||     |  _  |
-- |_______||_____|___._|__| |____||__|__||__||__|__|___  |
--                                                  |_____|
-- ------------------------------------------------- --
local box = {}

local signalIcon =
	wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = "none",
	nil,
	{
		id = "icon",
		image = icons.wifi_2,
		resize = true,
		widget = wibox.widget.imagebox
	},
	nil
}

local wifiIcon =
	wibox.widget {
	{
		{
			signalIcon,
			margins = dpi(7),
			widget = wibox.container.margin
		},
		shape = gears.shape.rect,
		bg = colors.color4,
		widget = wibox.container.background
	},
	forced_width = 40,
	forced_height = 40,
	widget = clickable_container
}

local content =
	wibox.widget {
	{
		{
			{
				text = "Searching...",
				font = "SF Pro Rounded Heavy  Regular  10",
				widget = wibox.widget.textbox
			},
			layout = wibox.layout.align.vertical
		},
		margins = dpi(10),
		widget = wibox.container.margin
	},
	shape = gears.shape.rect,
	bg = colors.colorB,
	widget = wibox.container.background
}

box =
	wibox.widget {
	{
		wifiIcon,
		content,
		-- buttons,
		layout = wibox.layout.align.horizontal
	},
	shape = beautiful.client_shape_rounded_xl,
	fg = colors.white,
	border_width = dpi(1),
	border_color = colors.colorA,
	widget = wibox.container.background
}

return box
