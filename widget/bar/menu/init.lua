local return_button = function(color, lspace, rspace, tspace, bspace)
    local widget_button =
        wibox.widget {
        {
            {
                {
                    {
                        image = icons.menu,
                        widget = wibox.widget.imagebox
                    },
                    top = dpi(4),
                    bottom = dpi(4),
                    left = dpi(12),
                    right = dpi(12),
                    widget = wibox.container.margin
                },
                shape = beautiful.client_shape_rounded,
                bg = color.color,
                widget = wibox.container.background
            },
            widget = clickable_container
        },
        left = dpi(lspace),
        right = dpi(rspace),
        top = dpi(3),
        bottom = dpi(3),
        widget = wibox.container.margin
    }
    local icon_size = dpi(108)

    -- create a table that contains the .desktop information for every program
    local programs_list = {}
    awful.spawn.with_line_callback(
        [[bash -c 'find /usr/share/applications -type f -name "*.desktop"']],
        {
            stdout = function(line)
                table.insert(programs_list, menubar.utils.parse_desktop_file(line))
            end
        }
    )
    local app_drawer =
        awful.popup {
        ontop = true,
        placement = awful.placement.centered,
        maximum_height = mouse.screen.geometry.height,
        maximum_width = mouse.screen.geometry.width,
        minimum_width = mouse.screen.geometry.width,
        visible = false,
        shape = beautiful.client_shape_rounded_xl,
        border_width = 0,
        bg = colors.alpha(colors.black, 'cc'),
        layout = overflow.vertical(),
        widget = clickable_container
    }
    local function generate_drawer()
        local row = {layout = overflow.horizontal()}
        local rows = {layout = overflow.vertical()}
        local width_count = 0

        for _, program in pairs(programs_list) do
            local icon_widget =
                wibox.widget {
                {
                    {
                        layout = overflow.vertical(),
                        {
                            image = program.icon_path,
                            forced_height = icon_size,
                            forced_width = icon_size,
                            widget = wibox.widget.imagebox
                        },
                        {
                            text = string.sub(program.Name, 1, 6) .. '...',
                            font = beautiful.font .. ' 9',
                            widget = wibox.widget.textbox
                        }
                    },
                    margins = 8,
                    layout = wibox.container.margin
                },
                bg = beautiful.bg_button,
                shape = beautiful.client_shape_rounded,
                widget = wibox.container.background
            }

            local icon_container =
                wibox.widget {
                icon_widget,
                bg = beautiful.bg_button,
                margins = dpi(15),
                layout = wibox.container.margin
            }

            icon_widget:connect_signal(
                'mouse::enter',
                function(c)
                    c:set_bg(beautiful.accent)
                end
            )
            icon_widget:connect_signal(
                'mouse::leave',
                function(c)
                    c:set_bg(beautiful.bg_button)
                end
            )

            icon_widget:buttons(
                awful.util.table.join(
                    awful.button(
                        {},
                        1,
                        function()
                            awful.spawn(program.cmdline)
                            app_drawer.visible = not app_drawer.visible
                        end
                    )
                )
            )

            table.insert(row, icon_container)

            width_count = width_count + 1
            if width_count == 10 then
                width_count = 0
                table.insert(rows, row)
                row = {layout = overflow.horizontal()}
            end
        end

        table.insert(rows, row)

        app_drawer:setup(rows)
    end
    generate_drawer()
    app_drawer:connect_signal(
        'mouse::leave',
        function()
            gears.timer {
                timeout = 5,
                autostart = true,
                callback = function()
                    if app_drawer.visible then
                        app_drawer.visible = false
                    end
                end
            }
        end
    )
    app_drawer:connect_signal(
        'button::pressed',
        function()
            if app_drawer.visible then
                app_drawer.visible = false
            end
        end
    )
    app_drawer:connect_signal(
        'mouse::enter',
        function()
            app_drawer.visible = true
        end
    )

    widget_button:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                nil,
                function()
                    if app_drawer.visible then
                        app_drawer.visible = not app_drawer.visible
                    else
                        generate_drawer()
                        app_drawer.visible = true
                        app_drawer:move_next_to(mouse.screen)
                    end
                end
            ),
            awful.button(
                {},
                3,
                nil,
                function()
                    awesome.emit_signal('cc:toggle')
                end
            )
        )
    )

    return widget_button
end

return return_button
