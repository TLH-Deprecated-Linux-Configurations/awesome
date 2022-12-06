--         __ __     __
-- .-----.|  |__|.--|  |.-----.----.
-- |__ --||  |  ||  _  ||  -__|   _|
-- |_____||__|__||_____||_____|__|
-- ------------------------------------------------- --
local sliders =
    wibox.widget {
    {
        {
            layout = wibox.layout.flex.horizontal,
            format_item(
                {
                    layout = wibox.layout.flex.vertical,
                    spacing = dpi(15),
                    {
                        {
                            {
                                require('widget.control_center.sliders.volume-slider'),
                                forced_height = dpi(85),
                                widget = wibox.container.background
                            },
                            widget = wibox.container.margin,
                            margins = dpi(3)
                        },
                        widget = wibox.container.background,
                        bg = colors.alpha(colors.black, 'cc'),
                        shape = beautiful.client_shape_rounded_xl
                    },
                    {
                        {
                            {
                                require('widget.control_center.sliders.brightness-slider'),
                                forced_height = dpi(85),
                                widget = wibox.container.background
                            },
                            widget = wibox.container.margin,
                            margins = dpi(3)
                        },
                        widget = wibox.container.background,
                        bg = colors.alpha(colors.black, 'cc'),
                        shape = beautiful.client_shape_rounded_xl
                    }
                }
            )
        },
        margins = dpi(0),
        widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded_xl,
    widget = wibox.container.background
}
-- ------------------------------------------------- --
return sliders
