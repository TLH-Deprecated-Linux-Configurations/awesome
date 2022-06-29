--  ______ ______ _______
-- |      |   __ \   |   |
-- |   ---|    __/   |   |
-- |______|___|  |_______|

--  _______         __
-- |   |   |.-----.|  |_.-----.----.
-- |       ||  -__||   _|  -__|   _|
-- |__|_|__||_____||____|_____|__|
-- ------------------------------------------------- --

local active_color = {
    type = 'linear',
    from = {0, 0},
    to = {200, 50}, -- replace with w,h later
    stops = {{0, colors.color3}, {0.75, colors.color15}}
}

local widget_text =
    wibox.widget {
    font = beautiful.icon_font .. '  18',
    text = 'CPU',
    valign = 'center',
    align = 'center',
    widget = wibox.widget.textbox
}

local cpu_bar =
    wibox.widget {
    max_value = 100,
    bg = colors.black,
    color = active_color,
    thickness = dpi(10),
    start_angle = 4.3,
    rounded_edge = true,
    colors = {active_color},
    widget = wibox.container.arcchart
}

awesome.connect_signal(
    'signal::cpu',
    function(value)
        cpu_bar.value = value
        widget_text:set_text(' \n' .. value .. '%')
    end
)

local cpu_meter =
    wibox.widget {
    {
        {
            {
                {
                    {
                        cpu_bar,
                        direction = 'east',
                        widget = wibox.container.rotate
                    },
                    widget_text,
                    layout = wibox.layout.stack
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },
            shape = beautiful.client_shape_rounded_xl,
            fg = colors.white,
            widget = wibox.container.background,
            forced_height = dpi(130),
            forced_width = dpi(120)
        },
        widget = wibox.container.margin,
        margins = dpi(5)
    },
    widget = wibox.container.background
}

return cpu_meter
