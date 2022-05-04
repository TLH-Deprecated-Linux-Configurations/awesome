-- URLs
local apps = require('config.root.apps')

local function create_url(name, path)
    local url =
        wibox.widget {
        {
            {
                {
                    {
                        image = os.getenv('HOME') .. '/.config/awesome/themes/icons/svg/' .. name .. '.svg',
                        widget = wibox.widget.imagebox,
                        align = 'center',
                        forced_width = dpi(110),
                        forced_height = dpi(110),
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

    -- Buttons
    url:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                function()
                    awful.spawn(settings.default_programs.browser .. path)
                    control_center_hide()
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.spawn('luakit ' .. path)
                    control_center_hide()
                end
            )
        )
    )

    return url
end

local urls =
    wibox.widget {
    {
        create_url('spotify', 'https://open.spotify.com'),
        create_url('instagram', 'https://instagram.com'),
        create_url('reddit', 'https://reddit.com'),
        spacing = dpi(45),
        layout = wibox.layout.fixed.horizontal
    },
    {
        layout = wibox.layout.fixed.horizontal,
        create_url('github', 'https://github.com/Thomashighbaugh'),
        create_url('mail', 'https://mail.zoho.com'),
        create_url('dribbble', 'https://instagram.com'),
        spacing = dpi(45)
    },
    spacing = dpi(45),
    layout = wibox.layout.fixed.vertical
}

return urls
