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
    to = {200, 50},
    stops = {{0, colors.color15}, {0.75, colors.color3}}
}
-- ------------------------------------------------- --

local widget_text =
    wibox.widget {
    font = beautiful.font .. '  16',
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
    color = active_color,
    thickness = dpi(10),
    start_angle = 0,
    rounded_edge = true,
    colors = {active_color},
    widget = wibox.container.arcchart
}
-- ------------------------------------------------- --
local cpu_icon =
    wibox.widget {
    image = icons.cpu,
    widget = wibox.widget.imagebox,
    halign = 'center',
    valign = 'center',
    forced_height = dpi(18),
    forced_width = dpi(18)
}
-- ------------------------------------------------- --
awesome.connect_signal(
    'signal::cpu',
    function(value)
        cpu_bar.value = value
        widget_text:set_text(value .. '%\n')
    end
)
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
                        widget = wibox.container.rotate,
                        maximum_height = dpi(50),
                        maximum_width = dpi(50)
                    },
                    {
                        nil,
                        cpu_icon,
                        widget_text,
                        layout = wibox.layout.align.vertical,
                        expand = 'outside',
                        spacing = dpi(0)
                    },
                    layout = wibox.layout.stack
                },
                margins = dpi(2),
                widget = wibox.container.margin
            },
            shape = beautiful.client_shape_rounded_xl,
            fg = colors.white,
            widget = wibox.container.background,
            bg = beautiful.bg_button
        },
        widget = wibox.container.margin,
        margins = dpi(2)
    },
    widget = wibox.container.background,
    bg = colors.black,
    shape = beautiful.client_shape_rounded_xl
}
-- ------------------------------------------------- --
return cpu_meter
