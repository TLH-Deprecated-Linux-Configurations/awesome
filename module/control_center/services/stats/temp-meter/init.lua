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
    stops = {{0, colors.color6}, {0.75, colors.color4}}
}
-- ------------------------------------------------- --
local widget_text =
    wibox.widget {
    font = beautiful.font .. '  16',
    text = 'TEMP',
    valign = 'center',
    align = 'center',
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
local temp_bar =
    wibox.widget {
    max_value = 100,
    bg = colors.black,
    thickness = dpi(10),
    start_angle = 0,
    rounded_edge = true,
    colors = {active_color},
    widget = wibox.container.arcchart
}
-- ------------------------------------------------- --
local temp_icon =
    wibox.widget {
    image = icons.temp,
    widget = wibox.widget.imagebox,
    halign = 'center',
    valign = 'center',
    forced_height = dpi(18),
    forced_width = dpi(18)
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
local temp_meter =
    wibox.widget {
    {
        {
            {
                {
                    {
                        temp_bar,
                        direction = 'east',
                        widget = wibox.container.rotate,
                        maximum_height = dpi(50),
                        maximum_width = dpi(50)
                    },
                    {
                        nil,
                        temp_icon,
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
            bg = beautiful.bg_button,
            widget = wibox.container.background
        },
        widget = wibox.container.margin,
        margins = dpi(2)
    },
    widget = wibox.container.background,
    bg = colors.black,
    shape = beautiful.client_shape_rounded_xl
}
-- ------------------------------------------------- --
return temp_meter
