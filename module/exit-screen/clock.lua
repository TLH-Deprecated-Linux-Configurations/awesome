-- Create clock
local clock = wibox.widget.textbox()
clock.font = beautiful.font .. ' 48'
clock.align = 'center'

local date = wibox.widget.textbox()
date.font = beautiful.font .. ' 32'
date.align = 'center'

local function update_time()
	clock.markup = "<span foreground='" .. colors.white .. "'>" .. os.date('%H:%M') .. '</span>'
	date.markup = "<span foreground='" .. colors.white .. "'>" .. os.date('%d %b %Y') .. '</span>'
end

gears.timer {
	timeout = 60,
	autostart = true,
	call_now = true,
	callback = function()
		update_time()
	end
}

return wibox.widget {
	nil,
	{
		{
			clock,
			date,
			layout = wibox.layout.fixed.vertical
		},
		spacing = 24,
		layout = wibox.layout.flex.horizontal
	},
	expand = 'none',
	layout = wibox.layout.flex.horizontal
}
