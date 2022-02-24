--DEPENDENCIES
--light

local main_color = colors.color1

local widget_name =
	wibox.widget {
	text = "Brightness",
	font = "Nineteen Ninety Seven Regular  10",
	align = "left",
	widget = wibox.widget.textbox
}

local widget_icon =
	wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = "none",
	nil,
	{
		id = "icon",
		image = icons.brightness,
		resize = true,
		widget = wibox.widget.imagebox
	},
	nil
}

local widget_content =
	wibox.widget {
	{
		{
			widget_icon,
			margins = dpi(5),
			widget = wibox.container.margin
		},
		widget = clickable_container
	},
	bg = beautiful.bg_button,
	shape = beautiful.client_shape_rounded_xl,
	widget = wibox.container.background
}

local slider =
	wibox.widget {
	nil,
	{
		id = "brightness_slider",
		bar_shape = gears.shape.rounded_bar,
		bar_height = dpi(24),
		bar_color = colors.colorB,
		bar_active_color = colors.color1,
		handle_color = colors.white,
		handle_shape = beautiful.client_shape_rounded_xl,
		handle_width = dpi(24),
		maximum = 100,
		value = 100,
		widget = wibox.widget.slider
	},
	nil,
	expand = "none",
	forced_height = dpi(24),
	layout = wibox.layout.align.vertical
}

local brightness_slider = slider.brightness_slider

brightness_slider:connect_signal(
	"property::value",
	function()
		local brightness_level = brightness_slider:get_value()
		if brightness_level ~= nil then
			spawn("light -S " .. brightness_level, false)
			awesome.emit_signal("signal::brightness", tonumber(brightness_level))
		end
	end
)

brightness_slider:buttons(
	gears.table.join(
		awful.button(
			{},
			9,
			nil,
			function()
				if brightness_slider:get_value() > 100 then
					brightness_slider:set_value(100)
					return
				end
				brightness_slider:set_value(brightness_slider:get_value() + 5)
				local updated_value = brightness_slider:get_value()
				awesome.emit_signal("signal::brightness", tonumber(updated_value))
			end
		),
		awful.button(
			{},
			8,
			nil,
			function()
				if brightness_slider:get_value() < 0 then
					brightness_slider:set_value(0)
					return
				end
				brightness_slider:set_value(brightness_slider:get_value() - 5)
				local updated_value = brightness_slider:get_value()
				awesome.emit_signal("signal::brightness", tonumber(updated_value))
			end
		)
	)
)

local update_slider = function()
	awful.spawn.easy_async_with_shell(
		[[bash -c "light -G"]],
		function(stdout)
			if stdout ~= nil then
				local brightness = stdout
				brightness_slider:set_value(tonumber(stdout))
				awesome.emit_signal("signal::brightness", tonumber(brightness))
			end
		end
	)
end

-- Update on startup
update_slider()

-- The emit will come from the global keybind
awesome.connect_signal(
	"signal::brightness",
	function()
		update_slider()
	end
)

local cc_brightness =
	wibox.widget {
	{
		{
			layout = wibox.layout.fixed.vertical,
			forced_height = dpi(48),
			spacing = dpi(5),
			widget_name,
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = dpi(5),
				{
					layout = wibox.layout.align.vertical,
					expand = "none",
					nil,
					{
						layout = wibox.layout.fixed.horizontal,
						forced_height = dpi(48),
						forced_width = dpi(48),
						widget_content
					},
					nil
				},
				slider
			}
		},
		margins = dpi(15),
		widget = wibox.container.margin
	},
	shape = beautiful.client_shape_rounded,
	bg = colors.colorA,
	fg = colors.white,
	widget = wibox.container.background
}

return cc_brightness
