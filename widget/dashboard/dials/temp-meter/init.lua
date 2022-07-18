--  _______
-- |_     _|.-----.--------.-----.
--   |   |  |  -__|        |  _  |
--   |___|  |_____|__|__|__|   __|
--                         |__|
--  _______         __
-- |   |   |.-----.|  |_.-----.----.
-- |       ||  -__||   _|  -__|   _|
-- |__|_|__||_____||____|_____|__|
-- ------------------------------------------------- --
local active_color = {
    type = 'linear',
    from = {0, 0},
    to = {200, 50}, -- replace with w,h later
    stops = {{0, colors.color6}, {0.75, colors.color15}}
}
-- ------------------------------------------------- --
local image =
    wibox.widget {
    {
        widget = wibox.widget.imagebox,
        image = icons.temp,
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
    text = '',
    valign = 'center',
    align = 'center',
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
local temp_bar =
    wibox.widget {
    max_value = 100,
    bg = colors.black,
    thickness = dpi(12),
    start_angle = 4.3,
    rounded_edge = true,
    colors = {active_color},
    widget = wibox.container.arcchart
}
-- ------------------------------------------------- --
awesome.connect_signal(
    'signal::temp',
    function(temp)
        if temp ~= nil then
            temp_bar.value = temp
            widget_text:set_text(math.floor(temp) .. '°')
        end
    end
)
local max_temp = 80
-- ------------------------------------------------- --
local temp_text =
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
local temp_meter =
    wibox.widget {
    {
        {
            {
                {
                    {
                        temp_bar,
                        direction = 'east',
                        widget = wibox.container.rotate
                    },
                    {
                        temp_text,
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
            forced_height = dpi(150),
            forced_width = dpi(150),
            widget = wibox.container.background
        },
        widget = wibox.container.margin,
        margins = dpi(5)
    },
    widget = wibox.container.background,
    bg = colors.alpha(colors.colorA, '88'),
    shape = beautiful.client_shape_rounded_lg
}
-- ------------------------------------------------- --
return temp_meter
