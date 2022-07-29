-- Mic button/widget
-- ~~~~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~

-- misc/vars
-- ~~~~~~~~~

local service_name = "Mic"
local service_icon = icons.rad

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
    font = beautiful.font .. "12",
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
                circle_animate,
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.align.horizontal
        },
        {
            nil,
            {
                {
                    icon,
                    top = dpi(14),
                    bottom = dpi(14),
                    left = dpi(24),
                    right = dpi(24),
                    widget = wibox.container.margin
                },
                name,
                layout = wibox.layout.align.vertical,
                spacing = dpi(5)
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

-- update information
local function update_server(send_notif)
    awful.spawn.easy_async_with_shell(
        [[
        amixer -D pulse get Capture toggle | tail -n 1 | awk '{print $6}' | tr -d '[]'
		]],
        function(stdout)
            if stdout:match("on") then
                icon.text = service_icon
                name.text = service_name
                animation_button_opacity:set(1)

                if send_notif then
                    naughty.notification({title = "", message = "Microphone enabled"})
                end
            else
                icon.text = service_icon
                name.text = service_name
                animation_button_opacity:set(0)

                if send_notif then
                    naughty.notification({title = "", message = "Microphone disabled"})
                end
            end
        end
    )
end

-- run once every startup/reload
update_server()

-- buttons
alright:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn("amixer -D pulse set Capture toggle", false)
                update_server(true)
            end
        )
    )
)

return alright
