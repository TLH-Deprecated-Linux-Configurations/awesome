--- Screenshot Widget
--- ~~~~~~~~~~~~~~~~~

local screenshot = {}

local function button(icon, command)
	clickable_container(
		{
			forced_width = dpi(60),
			forced_height = dpi(60),
			shape = gears.shape.circle,
			{
				{
					widget = wibox.widget.imagebox,
					image = icons.icon
				},
				widget = wibox.container.margin,
				margins = dpi(6)
			},
			on_release = function()
				awesome.emit_signal('central_panel::toggle', awful.screen.focused())
				gears.timer(
					{
						timeout = 1,
						autostart = true,
						single_shot = true,
						callback = function()
							awful.spawn.with_shell(command)
						end
					}
				)
			end
		}
	)
end

screenshot.area = button('compress', apps.utils.area_screenshot)
screenshot.full = button('camera', apps.utils.full_screenshot)

return screenshot
