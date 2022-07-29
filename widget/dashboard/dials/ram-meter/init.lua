--  ______
-- |   __ \.---.-.--------.
-- |      <|  _  |        |
-- |___|__||___._|__|__|__|
--  _______         __
-- |   |   |.-----.|  |_.-----.----.
-- |       ||  -__||   _|  -__|   _|
-- |__|_|__||_____||____|_____|__|
-- ------------------------------------------------- --
local active_color = {
    type = 'linear',
    from = {0, 0},
    to = {200, 50},
    stops = {{0, colors.color7}, {0.75, colors.color23}}
}
-- ------------------------------------------------- --
local image = wibox.widget {
    {
        widget = wibox.widget.imagebox,
        image = icons.ram,
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
local widget_text = wibox.widget {
    font = beautiful.font .. ' 18',
    text = 'RAM',
    valign = 'center',
    align = 'center',
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
local ram_bar = wibox.widget {
    max_value = 100,
    bg = colors.black,
    thickness = dpi(12),
    start_angle = 4.3,
    rounded_edge = true,
    colors = {active_color},
    widget = wibox.container.arcchart
}
-- ------------------------------------------------- --
awesome.connect_signal('signal::ram', function(used, total)
    local r_average = math.floor((used / total) * 100)
    -- the below will render used gigabytes if that is preferred, switch the widget_text variable from r_average to r_used in the tostring function
    -- local r_used = string.format("%.1f", used / 1000) .. "G"

    ram_bar.value = r_average
    widget_text.markup = tostring(r_average) .. '%'
end)
-- ------------------------------------------------- --
local ram_text = wibox.widget {
    {layout = wibox.layout.fixed.vertical, image, widget_text},
    widget = wibox.container.place,
    align = 'center',
    valign = 'center',
    layout = wibox.layout.fixed.vertical
}
-- ------------------------------------------------- --
local ram_meter = wibox.widget {
    {
        {
            {
                {
                    {
                        ram_bar,
                        direction = 'east',
                        widget = wibox.container.rotate
                    },
                    {
                        ram_text,
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
    bg = colors.alpha(colors.colorD, '33'),
    shape = beautiful.client_shape_rounded_xl
}

return ram_meter
