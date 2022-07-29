-- wifi button/widget
-- ~~~~~~~~~~~~~~~~~~

-- misc/vars
-- ~~~~~~~~~

local service_name = "Bluetooth"
local service_icon = icons.bluetooth

-- widgets
-- ~~~~~~~

-- icon
local icon =
    wibox.widget {
    image = service_icon,
    widget = wibox.widget.imagebox,
    valign = "center",
    align = "center",
    forced_width = dpi(48),
    forced_height = dpi(48)
}

-- name
local name =
    wibox.widget {
    font = beautiful.font .. "11",
    widget = wibox.widget.textbox,
    text = service_name,
    valign = "center",
    align = "center"
}

-- animation :love:
local circle_animate =
    wibox.widget {
    widget = wibox.container.background,
    shape = beautiful.client_shape_rounded_xl,
    bg = beautiful.accent,
    forced_width = 110
}

-- mix those
local alright =
    wibox.widget {
    {
        {
            nil,
            {
                icon,
                top = dpi(14),
                bottom = dpi(14),
                left = dpi(24),
                right = dpi(24),
                widget = wibox.container.margin
            },
            layout = wibox.layout.align.vertical
        },
        layout = wibox.layout.stack
    },
    shape = beautiful.client_shape_rounded_xl,
    widget = clickable_container,
    forced_width = dpi(96),
    forced_height = dpi(96)
}

local animation_button_opacity =
    rubato.timed {
    pos = 0,
    rate = 60,
    intro = 0.08,
    duration = 0.3,
    awestore_compat = true,
    subscribed = function(pos)
        circle_animate.opacity = pos
    end
}

-- function that updates everything
local function update_everything(value)
    if value then
        icon.image = service_icon
        name.text = service_name
        animation_button_opacity:set(1)
    else
        icon.image = service_icon
        name.text = service_name
        animation_button_opacity:set(0)
    end
end

awesome.connect_signal(
    "signal::bluetooth",
    function(value, isrun)
        if value then
            update_everything(true)

            alright:buttons(
                gears.table.join(
                    awful.button(
                        {},
                        1,
                        function()
                            awful.spawn("bluetoothctl power off", false)
                            update_everything(false)
                        end
                    )
                )
            )
        else
            update_everything(false)

            alright:buttons(
                gears.table.join(
                    awful.button(
                        {},
                        1,
                        function()
                            awful.spawn("bluetoothctl power on", false)
                            update_everything(true)
                        end
                    )
                )
            )
        end
    end
)

return alright
