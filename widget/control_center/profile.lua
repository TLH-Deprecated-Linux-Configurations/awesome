--                    ___ __ __
-- .-----.----.-----.'  _|__|  |.-----.
-- |  _  |   _|  _  |   _|  |  ||  -__|
-- |   __|__| |_____|__| |__|__||_____|
-- |__|
-- ------------------------------------------------- --
-- NOTE this is essentially just for the logo icon in the
-- dashboard
-- image
local profile_image =
    wibox.widget {
    {
        image = config_dir .. '/themes/icons/svg/logo.png',
        clip_shape = beautiful.client_shape_rounded_xl,
        widget = wibox.widget.imagebox
    },
    widget = wibox.container.background,
    bg = beautiful.bg_button,
    border_width = dpi(3),
    forced_width = dpi(84),
    forced_height = dpi(84),
    shape = beautiful.client_shape_rounded,
    border_color = colors.black
}

-- return
return wibox.widget {
    profile_image,
    {
        nil,
        {
            nil,
            layout = wibox.layout.fixed.vertical,
            spacing = dpi(2)
        },
        layout = wibox.layout.align.vertical,
        expand = 'none'
    },
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(15)
}
