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
    to = {200, 200}, -- replace with w,h later
    stops = {{0, colors.color3}, {0.75, colors.color15}}
}
-- ------------------------------------------------- --
local image =
    wibox.widget {
    {
        widget = wibox.widget.imagebox,
        image = icons.cpu,
        valign = 'center',
        forced_height = dpi(48),
        forced_width = dpi(48),
        align = 'center'
    },
    widget = wibox.container.background,
    layout = wibox.container.place,
    valign = 'center',
    align = 'center'
}
-- ------------------------------------------------- --
local widget_text =
    wibox.widget {
    font = beautiful.font .. '  18',
    text = 'CPU',
    valign = 'center',
    align = 'center',
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
local cpu_bar =
    wibox.widget {
    max_value = 100,
    bg = colors.black,
    color = {active_color},
    thickness = dpi(12),
    start_angle = 4.3,
    rounded_edge = true,
    colors = {active_color},
    widget = wibox.container.arcchart
}
-- ------------------------------------------------- --
awesome.connect_signal(
    'signal::cpu',
    function(value)
        cpu_bar.value = value
        widget_text:set_text(value .. '%')
    end
)
-- ------------------------------------------------- --
local cpu_text =
    wibox.widget {
    {
        layout = wibox.layout.fixed.vertical,
        image,
        widget_text
    },
    widget = wibox.container.place,
    align = 'center',
    valign = 'center',
    layout = wibox.layout.fixed.vertical
}
-- ------------------------------------------------- --
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
                    {
                        cpu_text,
                        valign = 'center',
                        align = 'center',
                        layout = wibox.container.place
                    },
                    layout = wibox.layout.stack
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },
            shape = beautiful.client_shape_rounded_xl,
            fg = colors.white,
            widget = wibox.container.background,
            forced_height = dpi(150),
            forced_width = dpi(150)
        },
        widget = wibox.container.margin,
        margins = dpi(5)
    },
    widget = wibox.container.background,
    bg = colors.alpha(colors.colorA, '88'),
    shape = beautiful.client_shape_rounded_xl
}

return cpu_meter
