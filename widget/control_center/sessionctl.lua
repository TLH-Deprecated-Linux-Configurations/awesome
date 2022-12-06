-- session buttons
-- ~~~~~~~~~~~~~~~

-- widgets
-- ~~~~~~~

-- lockscreen button
local lock_button =
    wibox.widget {
    {
        widget = wibox.widget.textbox,
        text = '',
        font = 'FontAwesome Regular 28',
        align = 'center',
        valign = 'center'
    },
    widget = wibox.container.margin,
    margins = dpi(8)
}

-- screenshot button
local screenshot_button =
    wibox.widget {
    {
        widget = wibox.widget.imagebox,
        image = icons.image_crop,
        halign = 'center',
        forced_height = dpi(36),
        forced_width = dpi(36),
        valign = 'center'
    },
    widget = wibox.container.margin,
    margins = dpi(8)
}
-- exitscreen button
local power_button =
    wibox.widget {
    {
        widget = wibox.widget.imagebox,
        image = icons.power,
        forced_height = dpi(36),
        forced_width = dpi(36),
        align = 'center',
        valign = 'center'
    },
    widget = wibox.container.margin,
    margins = dpi(8)
}

-- add function to them
-- ~~~~~~~~~~~~~~~~~~~~
power_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                awesome.emit_signal('module::exit_screen:show')
            end
        )
    )
)

lock_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                if control_c.visible then
                    cc_toggle()
                end

                awful.spawn(settings.default_programs.lock)
            end
        )
    )
)
screenshot_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                if control_c.visible then
                    cc_toggle()
                end
                local screen = awful.screen.focused()
                sc_toggle()
            end
        )
    )
)
--~~~~~~~~~~~~~~~~~~~
--~~~~~~~~~~~~~~~~~~~
return wibox.widget {
    nil,
    {
        {
            clickable_container(screenshot_button),
            clickable_container(lock_button),
            clickable_container(power_button),
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(5)
        },
        layout = wibox.layout.fixed.vertical
    },
    layout = wibox.layout.flex.horizontal,
    expand = 'none'
}
