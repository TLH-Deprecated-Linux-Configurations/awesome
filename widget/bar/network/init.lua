local return_button = function(bg_color, left, right)
    local widget =
        wibox.widget(
        {
            {
                id = 'icon',
                image = icons.wifi,
                align = 'center',
                valign = 'center',
                widget = wibox.widget.imagebox
            },
            layout = wibox.layout.align.horizontal
        }
    )

    local widget_button =
        wibox.widget(
        {
            {
                widget,
                margins = dpi(8),
                widget = wibox.container.margin
            },
            widget = clickable_container
        }
    )

    widget_button:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                nil,
                function()
                    -- awful.spawn(apps.default.network_manager, false)
                end
            )
        )
    )

    watch(
        [[sh -c "
		nmcli g | tail -n 1 | awk '{ print $1 }'
		"]],
        5,
        function(_, stdout)
            local net_ssid = stdout
            net_ssid = string.gsub(net_ssid, '^%s*(.-)%s*$', '%1')

            if not net_ssid:match('disconnected') and net_ssid ~= nil then
                local getstrength = [[
					awk '/^\s*w/ { print  int($3 * 100 / 70) }' /proc/net/wireless
					]]
                awful.spawn.easy_async_with_shell(
                    getstrength,
                    function(stdout)
                        if not tonumber(stdout) then
                            return
                        end
                        local strength = tonumber(stdout)
                        if strength <= 20 then
                            widget.icon:set_image(icons.wifi_strength_1)
                        elseif strength <= 40 then
                            widget.icon:set_image(icons.wifi_strength_2)
                        elseif strength <= 60 then
                            widget.icon:set_image(icons.wifi_strength_3)
                        elseif strength <= 80 then
                            widget.icon:set_image(icons.wifi_strength_3)
                        else
                            widget.icon:set_image(icons.wifi_strength_4)
                        end
                    end
                )
            else
                widget.icon:set_image(icons.wifi_strength_alert)
            end
        end
    )

    return widget_button
end

return return_button
