-- Create function
local create_button = function(icon, text, bgcolor, cmd)
	local button =
		clickable_container {
		nil,
		{
			id = 'button',
			image = icon,
			halign = 'center',
			valign = 'center',
			widget = wibox.widget.imagebox,
			forced_width = 108,
			forced_height = 108
		},
		nil,
		layout = wibox.layout.align.horizontal,
		bg = bgcolor,
		shape = beautiful.client_shape_rounded_xl,
		widget = wibox.container.margin,
		margins = dpi(26)
	}

	button:buttons(
		gears.table.join(
			awful.button(
				{},
				1,
				function()
					awful.spawn(cmd, false)
				end
			)
		)
	)

	return button
end

return create_button
