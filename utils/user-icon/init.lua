-- .--.--.-----.-----.----.
-- |  |  |__ --|  -__|   _|
-- |_____|_____|_____|__|

--  __
-- |__|.----.-----.-----.
-- |  ||  __|  _  |     |
-- |__||____|_____|__|__|

local settings = require("settings")
local dir = os.getenv("HOME") .. "/.config/awesome/themes/profile_pictures/"

-- ------------------------------------------------- --
-- Icon widget
local widget_icon =
	wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = "none",
	nil,
	{
		id = "icon",
		image = dir .. settings.profile_picture,
		resize = true,
		widget = wibox.widget.imagebox
	},
	nil
}

-- Icon widget container
local widget =
	wibox.widget {
	{
		{
			{
				widget_icon,
				layout = wibox.layout.fixed.horizontal
			},
			margins = dpi(0),
			widget = wibox.container.margin
		},
		forced_height = dpi(50),
		widget = clickable_container
	},
	shape = beautiful.client_shape_rounded_small,
	bg = "transparent",
	widget = wibox.container.background
}

return widget
