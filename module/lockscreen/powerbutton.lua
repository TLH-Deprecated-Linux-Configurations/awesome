local create_button = require 'module.lockscreen.create_buttons'

local poweroff = create_button(icons.power, 'Poweroff', beautiful.bg_button, 'poweroff')
local reboot = create_button(icons.restart, 'Reboot', beautiful.bg_button, 'reboot')
local sleep = create_button(icons.sleep, 'Sleep', beautiful.bg_button, 'systemctl suspend')

return wibox.widget {
	nil,
	{
		poweroff,
		reboot,
		sleep,
		spacing = 20,
		layout = wibox.layout.fixed.horizontal,
		halign = 'center',
		valign = 'center'
	},
	nil,
	layout = wibox.layout.align.horizontal,
	widget_button = wibox.container.background
}
