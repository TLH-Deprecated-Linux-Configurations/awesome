--  _______ ______ _____
-- |   |   |   __ \     |_.-----.
-- |   |   |      <       |__ --|
-- |_______|___|__|_______|_____|
-- ------------------------------------------------- --
-- Website Links for the dashboard
-- ------------------------------------------------- --

-- ------------------------------------------------- --
-- ------------ Define URL Button Object ----------- --
-- ------------------------------------------------- --

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
    -- ------------------------------------------------- --
    -- Buttons
    url:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                function()
                    awful.spawn(settings.default_programs.browser .. path)
                    dashboard_hide()
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.spawn('luakit ' .. path)
                    dashboard_hide()
                end
            )
        )
    )

    return url
end
-- ------------------------------------------------- --
-- -------------- Implement the Object ------------- --
-- ------------------------------------------------- --
local urls =
    wibox.widget {
    {
        create_url('spotify', 'https://open.spotify.com'),
        create_url('instagram', 'https://instagram.com'),
        create_url('reddit', 'https://reddit.com'),
        spacing = dpi(15),
        layout = wibox.layout.fixed.horizontal
    },
    {
        layout = wibox.layout.fixed.horizontal,
        create_url('github', 'https://github.com/Thomashighbaugh'),
        create_url('mail', 'https://mail.zoho.com'),
        create_url('dribbble', 'https://instagram.com'),
        spacing = dpi(15)
    },
    spacing = dpi(15),
    layout = wibox.layout.fixed.vertical
}

return urls
