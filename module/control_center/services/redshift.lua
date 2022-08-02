-- redshift button/widget
-- ~~~~~~~~~~~~~~~~~~~~~~

-- misc/vars
-- ~~~~~~~~~

local service_name = "Blue Light"
local service_icon = icons.moon

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
                circle_animate,
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.align.horizontal,
            expand = "none"
        },
        {
            nil,
            {
                icon,
                name,
                layout = wibox.layout.fixed.vertical,
                spacing = dpi(10)
            },
            layout = wibox.layout.align.vertical,
            expand = "none"
        },
        layout = wibox.layout.stack
    },
    shape = beautiful.client_shape_rounded_xl,
    widget = wibox.container.background,
    border_color = beautiful.fg_color .. "33",
    forced_width = dpi(110),
    forced_height = dpi(110),
    bg = beautiful.bg_normal
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

-- kill every redshift process

local readwrite = require("utilities.platform.readwrite")

local output = readwrite.readall("blue_light_state")

if output:match("true") then
    icon.text = service_icon
    name.text = service_name
    animation_button_opacity:set(1)
else
    icon.text = service_icon
    name.text = service_name
    animation_button_opacity:set(0)
end

-- buttons
alright:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn.easy_async_with_shell(
                    [[
		if [ ! -z $(pgrep redshift) ];
		then
			redshift -x && pkill redshift && killall redshift
            echo "false" > $HOME/.config/awesome/misc/.information/blue_light_state
			echo 'OFF'
		else
			redshift -l 0:0 -t 4500:4500 -r &>/dev/null &
            echo "true" > $HOME/.config/awesome/misc/.information/blue_light_state
			echo 'ON'
		fi
		]],
                    function(stdout)
                        if stdout:match("ON") then
                            icon.text = service_icon
                            name.text = service_name
                            animation_button_opacity:set(1)
                            naughty.notification({title = "", message = "Night Light enabled"})
                        else
                            icon.text = service_icon
                            name.text = service_name
                            animation_button_opacity:set(0)
                            naughty.notification({title = "", message = "Night Light disabled"})
                        end
                    end
                )
            end
        )
    )
)

return alright
