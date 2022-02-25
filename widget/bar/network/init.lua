--DEPENDENCIES
--speedtest-cli

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local clickable_container = require("widget.clickable-container")
local dpi = require("beautiful").xresources.apply_dpi
local icons = require("themes.icons")

local return_button = function(color, lspace, rspace)
	local widget_icon =
		wibox.widget {
		layout = wibox.layout.align.vertical,
		expand = "none",
		nil,
		{
			id = "icon",
			image = icons.wired_off,
			resize = true,
			widget = wibox.widget.imagebox
		},
		nil
	}
	local widget_button =
		wibox.widget {
		{
			{
				{
					widget_icon,
					top = dpi(4),
					bottom = dpi(4),
					left = dpi(12),
					right = dpi(12),
					widget = wibox.container.margin
				},
				shape = gears.shape.rounded_bar,
				bg = color.color,
				widget = wibox.container.background
			},
			forced_width = icon_size,
			forced_height = icon_size,
			widget = clickable_container
		},
		top = dpi(3),
		bottom = dpi(3),
		left = dpi(lspace),
		right = dpi(rspace),
		widget = wibox.container.margin
	}

	widget_button:buttons(
		gears.table.join(
			awful.button(
				{},
				1,
				nil,
				function()
					awesome.emit_signal("network::center:toggle")
					awesome.emit_signal("network::networks:refreshPanel")
				end
			)
		)
	)
	awesome.connect_signal(
		"network::status::wireless",
		function(interface, healthy, essid, bitrate, strength)
			if healthy == true then
				if strength <= 100 then
					widget_icon.icon:set_image(icons.wifi_3)
				elseif strength <= 75 then
					widget_icon.icon:set_image(icons.wifi_2)
				elseif strength <= 50 then
					widget_icon.icon:set_image(icons.wifi_1)
				elseif strength <= 25 then
					widget_icon.icon:set_image(icons.wifi_0)
				end
			else
				widget_icon.icon:set_image(icons.wifi_problem)
			end
		end
	)
	awesome.connect_signal(
		"network::connected::wired",
		function(interface, healthy)
			if healthy == true then
				widget_icon.icon:set_image(icons.wired)
			else
				widget_icon.icon:set_image(icons.wired_alert)
			end
		end
	)

	awesome.connect_signal(
		"network::disconnected::wireless",
		function()
			widget_icon.icon:set_image(icons.wifi_off)
		end
	)
	awesome.connect_signal(
		"network::disconnected::wired",
		function()
			widget_icon.icon:set_image(icons.wired_off)
		end
	)

	return widget_button
end

return return_button
