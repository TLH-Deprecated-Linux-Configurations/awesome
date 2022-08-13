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
local widget_text =
    wibox.widget {
    font = beautiful.font .. ' 16',
    text = 'RAM',
    valign = 'center',
    align = 'center',
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
local ram_bar =
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
local ram_icon =
    wibox.widget {
    image = icons.ram,
    widget = wibox.widget.imagebox,
    halign = 'center',
    valign = 'center',
    forced_height = dpi(18),
    forced_width = dpi(18)
}
-- ------------------------------------------------- --
awesome.connect_signal(
    'signal::ram',
    function(used, total)
        local r_average = math.floor((used / total) * 100)
        -- the below will render used gigabytes if that is preferred, switch the widget_text variable from r_average to r_used in the tostring function
        -- local r_used = string.format("%.1f", used / 1000) .. "G"

        ram_bar.value = r_average
        widget_text.markup = tostring(r_average) .. '%\n'
    end
)
-- ------------------------------------------------- --
local ram_meter =
    wibox.widget {
    {
        {
            {
                {
                    {
                        ram_bar,
                        direction = 'east',
                        maximum_height = dpi(50),
                        maximum_width = dpi(50),
                        widget = wibox.container.rotate
                    },
                    {
                        nil,
                        ram_icon,
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
return ram_meter
