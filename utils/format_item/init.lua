local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi

local format_item = function(widget)
  return wibox.widget {
		{
			{
				layout = wibox.layout.align.vertical,
				expand = 'none',
				nil,
				widget,
				nil
			},
			margins = dpi(5),
			widget = wibox.container.margin
		},
		shape =beautiful.client_shape_rounded_xl,


    bg = 'transparent',
		widget = wibox.container.background
	}
end

return format_item
