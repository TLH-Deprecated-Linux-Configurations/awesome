--  ___ ___         __
-- |   |   |.-----.|  |.--.--.--------.-----.
-- |   |   ||  _  ||  ||  |  |        |  -__|
--  \_____/ |_____||__||_____|__|__|__|_____|

--  _______ __ __     __
-- |     __|  |__|.--|  |.-----.----.
-- |__     |  |  ||  _  ||  -__|   _|
-- |_______|__|__||_____||_____|__|
-- ------------------------------------------------- --
local widget_name =
	wibox.widget {
	text = "Volume",
	font = "SF Pro Rounded Heavy  0",
	align = "left",
	widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
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
-- ------------------------------------------------- --
local widget_content =
	wibox.widget {
	{
		{
			widget_icon,
			margins = dpi(2),
			widget = wibox.container.margin
		},
		widget = clickable_container
	},
	bg = beautiful.bg_focus,
	shape = beautiful.client_shape_rounded,
	widget = wibox.container.background
}
-- ------------------------------------------------- --
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
		handle_shape = beautiful.client_shape_rounded,
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
-- ------------------------------------------------- --
volume_slider:connect_signal(
	"property::value",
	function()
		local volume_level = volume_slider:get_value()
		if volume_level ~= nil then
			spawn("pamixer --set-volume " .. volume_level, false)
			awesome.emit_signal("signal::volume:update", tonumber(volume_level))
			awesome.emit_signal("signal::volume", tonumber(volume_level))
		else
			volume_slider:set_value(0)
			spawn("amixer set Master mute", false)
		end
	end
)
-- ------------------------------------------------- --
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
				awesome.emit_signal("signal::volume:update", volume_slider:get_value())
				collectgarbage("collect")
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

				awesome.emit_signal("signal::volume:update", volume_slider:get_value())
				collectgarbage("collect")
			end
		)
	)
)
-- ------------------------------------------------- --
local update_slider_mute = function()
	awful.spawn.easy_async_with_shell(
		[["pamixer --get-mute"]],
		function(stdout)
			if stdout ~= nil then
				local status = string.match(stdout, "%a+")
				if stdout == "true" then
					widget_icon.icon:set_image(icons.mute)
					awesome.emit_signal("signal::volume:update", 0)
					collectgarbage("collect")
				elseif status == "false" then
					widget_icon.icon:set_image(icons.volume)
					awesome.emit_signal("signal::volume:update")
					collectgarbage("collect")
				end
			end
		end
	)
end
-- ------------------------------------------------- --
local update_slider = function()
	awful.spawn.easy_async_with_shell(
		[["awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master)"]],
		function(stdout)
			if stdout ~= nil then
				local volume = tonumber(stdout)
				volume_slider:set_value(volume)
				awesome.emit_signal("signal::volume:update", volume)
				update_slider_mute()
				collectgarbage("collect")
			end
		end
	)
end

-- Update on startup
update_slider()
-- ------------------------------------------------- --
local mute_toggle = function()
	awful.spawn.easy_async_with_shell(
		[[ amixer set Master toggle]],
		function()
			if volume_slider:get_value() ~= 0 then
				widget_icon.icon:set_image(icons.mute)
				volume_slider:set_value(0)
			else
				volume_slider:set_value(100)
				widget_icon.icon:set_image(icons.volume)
			end
		end
	)
end
-- ------------------------------------------------- --
widget_content:buttons(
	awful.util.table.join(
		awful.button(
			{},
			1,
			nil,
			function()
				mute_toggle()
				update_slider_mute()
			end
		)
	)
)
-- ------------------------------------------------- --
local volume_tooltip =
	awful.tooltip {
	objects = {widget_icon},
	text = "None",
	mode = "outside",
	align = "right",
	margin_leftright = dpi(8),
	margin_topbottom = dpi(8),
	preferred_positions = {"right", "left", "top", "bottom"}
}
-- ------------------------------------------------- --
-- The emit will come from the global keybind
awesome.connect_signal(
	"signal::volume",
	function(value, muted)
		update_slider()
		volume_slider:set_value(tonumber(value))
		if muted == 1 then
			update_slider_mute()
		end

		volume_tooltip:set_text("Volume Level is Currently: " .. value .. "%")
	end
)
-- ------------------------------------------------- --
local cc_volume =
	wibox.widget {
	{
		{
			layout = wibox.layout.fixed.vertical,
			forced_height = dpi(64),
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
						forced_height = dpi(64),
						forced_width = dpi(64),
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
