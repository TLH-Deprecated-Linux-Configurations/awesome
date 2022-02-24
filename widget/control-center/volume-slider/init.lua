--DEPENDENCIES
--pamixer

local main_color = colors.white

local widget_name =
	wibox.widget {
	text = "Volume",
	font = "Nineteen Ninety Seven Regular 10",
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
		image = icons.volume,
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
	shape = beautiful.client_shape_rounded,
	widget = wibox.container.background
}

local slider =
	wibox.widget {
	nil,
	{
		id = "volume_slider",
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

local volume_slider = slider.volume_slider

volume_slider:connect_signal(
	"property::value",
	function()
		local volume_level = volume_slider:get_value()
		if volume_level ~= nil then
			spawn("pamixer --set-volume " .. volume_level, false)
			awesome.emit_signal("signal::volume:update", tonumber(volume_level))
		end
	end
)

volume_slider:buttons(
	gears.table.join(
		awful.button(
			{},
			9,
			nil,
			function()
				if volume_slider:get_value() > 100 then
					volume_slider:set_value(100)
					return
				end
				volume_slider:set_value(volume_slider:get_value() + 5)
				awesome.emit_signal("signal::volume:update")
			end
		),
		awful.button(
			{},
			8,
			nil,
			function()
				if volume_slider:get_value() < 0 then
					volume_slider:set_value(0)
					return
				end
				volume_slider:set_value(volume_slider:get_value() - 5)
				awesome.emit_signal("signal::volume:update")
			end
		)
	)
)

local update_slider = function()
	awful.spawn.easy_async_with_shell(
		[["pacmd list-sinks | awk '/\\* index: /{nr[NR+7];nr[NR+11]}; NR in nr'"]],
		function(stdout)
			local volume = stdout:match("(%d+)%% /")
			volume_slider:set_value(tonumber(volume))
			awesome.emit_signal("signal::volume:update", tonumber(volume))
		end
	)
end

local update_slider_mute = function()
	awful.spawn.easy_async_with_shell(
		[[bash -c "pamixer --get-mute"]],
		function(stdout)
			local status = string.match(stdout, "%a+")
			if status == "true" then
				widget_icon.icon:set_image(icons.mute)
				awesome.emit_signal("signal::volume:update")
			elseif status == "false" then
				widget_icon.icon:set_image(icons.volume)
				awesome.emit_signal("signal::volume:update")
			end
		end
	)
end

-- Update on startup
update_slider()

local mute_toggle = function()
	awful.spawn.easy_async_with_shell(
		[[bash -c "pamixer --get-mute"]],
		function(stdout)
			local status = string.match(stdout, "%a+")
			if status == "true" then
				spawn("pamixer -u")

				widget_icon.icon:set_image(icons.volume)
			elseif status == "false" then
				spawn("pamixer -m")

				widget_icon.icon:set_image(icons.mute)
			end
		end
	)
end

widget_content:buttons(
	awful.util.table.join(
		awful.button(
			{},
			1,
			nil,
			function()
				mute_toggle()
			end
		)
	)
)

-- The emit will come from the global keybind
awesome.connect_signal(
	"signal::volume",
	function()
		update_slider()
		update_slider_mute()
	end
)

local cc_volume =
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
	shape = beautiful.client_shape_rounded_xl,
	bg = colors.colorA,
	fg = colors.white,
	widget = wibox.container.background
}

return cc_volume
