--  _______                        __         __
-- |_     _|.-----.--------.-----.|  |.---.-.|  |_.-----.
--   |   |  |  -__|        |  _  ||  ||  _  ||   _|  -__|
--   |___|  |_____|__|__|__|   __||__||___._||____|_____|
--                         |__|
-- ------------------------------------------------- --
-- Common button template
return function(name)
    local button =
        wibox.widget {
        {
            {
                {
                    {
                        id = 'icon',
                        image = os.getenv('HOME') .. '/.config/awesome/themes/icons/svg/' .. name .. '.svg',
                        widget = wibox.widget.imagebox,
                        align = 'center',
                        forced_width = dpi(80),
                        forced_height = dpi(80),
                        valign = 'center'
                    },
                    widget = wibox.container.margin,
                    margins = dpi(7)
                },
                widget = clickable_container
            },
            widget = wibox.container.margin,
            margins = dpi(5)
        },
        widget = wibox.container.background,
        shape = beautiful.client_shape_rounded_lg,
        bg = beautiful.bg_focus
    }

    return button
end
