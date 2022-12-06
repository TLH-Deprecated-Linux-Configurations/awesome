--  ______ __              __
-- |      |  |.-----.----.|  |--.
-- |   ---|  ||  _  |  __||    <
-- |______|__||_____|____||__|__|
-- ------------------------------------------------- --
local time = '%H:%M'
local date = '%d.%b.%Y'
-- ------------------------------------------------- --

local widget_button_clock =
    wibox.widget {
    format = time,
    refresh = 1,
    widget = wibox.widget.textclock,
    font = beautiful.font .. ' 15'
}
-- ------------------------------------------------- --
local widget_button =
    wibox.widget {
    {
        {
            {
                widget_button_clock,
                layout = wibox.layout.flex.horizontal
            },
            top = dpi(4),
            bottom = dpi(4),
            left = dpi(25),
            right = dpi(25),
            widget = wibox.container.margin
        },
        shape = gears.shape.rounded_bar,
        fg = colors.white,
        widget = wibox.container.background
    },
    widget = clickable_container
}
-- ------------------------------------------------- --
widget_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                if widget_button_clock.format == time then
                    widget_button_clock.font = beautiful.font .. ' 11'
                    widget_button_clock:set_format(date)
                elseif widget_button_clock.format == date then
                    widget_button_clock.font = beautiful.font .. ' 15'
                    widget_button_clock:set_format(time)
                end
            end
        )
    )
)

return widget_button
