function small(icon_path)
    local button_image =
        wibox.widget {
        id = 'icon',
        image = icon_path,
        resize = true,
        forced_width = dpi(22),
        forced_height = dpi(22),
        widget = wibox.widget.imagebox
    }

    local button =
        wibox.widget {
        {
            button_image,
            margins = dpi(8),
            widget = wibox.container.margin
        },
        bg = beautiful.bg_button,
        shape = gears.shape.circle,
        widget = wibox.container.background
    }

    local old_cursor,
        old_wibox

    button:connect_signal(
        'mouse::enter',
        function(c)
            local wb = mouse.current_wibox
            old_cursor,
                old_wibox = wb.cursor, wb
            wb.cursor = 'hand1'
        end
    )
    button:connect_signal(
        'mouse::leave',
        function(c)
            if old_wibox then
                old_wibox.cursor = old_cursor
                old_wibox = nil
            end
        end
    )

    return button
end

--- Creates big size circle button
--- @param icon_path string
function circle_big(icon_path)
    local button_with_label =
        wibox.widget {
        {
            {
                {
                    {
                        {
                            id = 'icon',
                            image = icon_path,
                            resize = true,
                            forced_width = dpi(18),
                            forced_height = dpi(18),
                            widget = wibox.widget.imagebox
                        },
                        widget = wibox.container.place
                    },
                    margins = dpi(10),
                    widget = wibox.container.margin
                },
                id = 'background',
                bg = beautiful.bg_button,
                shape = gears.shape.circle,
                widget = wibox.container.background
            },
            {
                {
                    id = 'label',
                    text = 'Off',
                    font = 'Ubuntu 8',
                    widget = wibox.widget.textbox
                },
                forced_width = dpi(50),
                widget = wibox.container.place
            },
            spacing = dpi(6),
            layout = wibox.layout.fixed.vertical
        },
        widget = clickable_container
    }

    return button_with_label
end

function button_with_label(name, icon)
    local button_label =
        wibox.widget {
        text = name,
        font = beautiful.font .. ' Bold 10',
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }

    local button =
        wibox.widget {
        {
            {
                {
                    {
                        image = icon,
                        resize = true,
                        forced_height = dpi(24),
                        forced_width = dpi(24),
                        widget = wibox.widget.imagebox
                    },
                    widget = wibox.container.place
                },
                button_label,
                spacing = beautiful.widget_margin,
                widget = wibox.layout.fixed.vertical
            },
            margins = dpi(16),
            widget = wibox.container.margin
        },
        bg = beautiful.bg_button,
        shape = beautiful.client_shape_rectangle_xl,
        widget = wibox.container.background,
        forced_width = dpi(95)
    }

    local old_cursor,
        old_wibox

    button:connect_signal(
        'mouse::enter',
        function(c)
            local wb = mouse.current_wibox
            old_cursor,
                old_wibox = wb.cursor, wb
            wb.cursor = 'hand1'
        end
    )
    button:connect_signal(
        'mouse::leave',
        function(c)
            if old_wibox then
                old_wibox.cursor = old_cursor
                old_wibox = nil
            end
        end
    )

    return button
end

screenshot_menu = function(s)
    local delay_sec = 0
    local snap_area = 'area'

    local snap_area_button = clickable_container(icons.compress)
    local snap_full_button = clickable_container(icons.devices)
    local snap_window = clickable_container(icons.terminal)
    snap_area_button.bg = beautiful.bg_button
    snap_full_button.bg = beautiful.bg_button
    snap_window.bg = beautiful.bg_button

    snap_area_button:connect_signal(
        'button::press',
        function(self, _, _, button)
            if button == 1 then
                snap_area = 'area'
                self.bg = beautiful.bg_button
                snap_full_button.bg = beautiful.bg_panel
                snap_window.bg = beautiful.bg_panel
            end
        end
    )

    snap_full_button:connect_signal(
        'button::press',
        function(self, _, _, button)
            if button == 1 then
                snap_area = 'screen'
                self.bg = beautiful.bg_button
                snap_area_button.bg = beautiful.bg_panel
                snap_window.bg = beautiful.bg_panel
            end
        end
    )

    snap_window:connect_signal(
        'button::press',
        function(self, _, _, button)
            if button == 1 then
                snap_area = 'window'
                self.bg = beautiful.bg_button
                snap_area_button.bg = beautiful.bg_panel
                snap_full_button.bg = beautiful.bg_panel
            end
        end
    )
    local button_capture =
        wibox.widget {
        widget = clickable_container,
        {
            widget = wibox.container.background,
            bg = beautiful.bg_normal,
            border_width = dpi(1),
            border_color = colors.black,
            shape = beautiful.client_shape_rounded,
            {
                widget = wibox.container.margin,
                left = dpi(10),
                right = dpi(10),
                top = dpi(6),
                bottom = dpi(6),
                {
                    widget = wibox.widget.textbox,
                    text = 'Take Screenshot'
                }
            }
        }
    }

    local button_video_capture =
        wibox.widget {
        widget = clickable_container,
        {
            widget = wibox.container.background,
            bg = beautiful.bg_button,
            border_width = dpi(1),
            border_color = colors.black,
            shape = beautiful.client_shape_rounded,
            {
                widget = wibox.container.margin,
                left = dpi(10),
                right = dpi(10),
                top = dpi(6),
                bottom = dpi(6),
                {
                    widget = wibox.widget.textbox,
                    id = 'buttontext',
                    text = 'Start Recording'
                }
            }
        }
    }

    local btn_delay_num = function()
        local btn_plus =
            wibox.widget {
            {
                image = icons.right_arrow,
                resize = true,
                forced_height = dpi(12),
                forced_width = dpi(12),
                widget = wibox.widget.imagebox
            },
            widget = clickable_container
        }

        local btn_minus =
            wibox.widget {
            {
                image = icons.left_arrow,
                resize = true,
                forced_height = dpi(12),
                forced_width = dpi(12),
                widget = wibox.widget.imagebox
            },
            widget = clickable_container
        }

        local value_text =
            wibox.widget {
            text = delay_sec,
            widget = wibox.widget.textbox
        }
        local btn_delay =
            wibox.widget {
            widget = clickable_container,
            {
                widget = wibox.container.background,
                bg = beautiful.bg_button,
                shape = beautiful.client_shape_rounded,
                {
                    widget = wibox.container.margin,
                    left = dpi(8),
                    right = dpi(8),
                    top = dpi(5),
                    bottom = dpi(5),
                    {
                        btn_minus,
                        value_text,
                        btn_plus,
                        spacing = dpi(15),
                        layout = wibox.layout.fixed.horizontal
                    }
                }
            }
        }

        btn_plus:connect_signal(
            'button::press',
            function(_, _, _, button)
                if button == 1 then
                    delay_sec = delay_sec + 1
                    value_text:set_text(delay_sec)
                end
            end
        )

        btn_minus:connect_signal(
            'button::press',
            function(_, _, _, button)
                if button == 1 then
                    if delay_sec < 1 then
                        return
                    end
                    delay_sec = delay_sec - 1
                    value_text:set_text(delay_sec)
                end
            end
        )

        return btn_delay
    end

    local btn_close =
        wibox.widget {
        {
            widget = wibox.container.background,
            bg = beautiful.bg_button,
            border_width = dpi(1),
            border_color = colors.black,
            shape = gears.shape.circle,
            {
                widget = wibox.container.margin,
                margins = dpi(3),
                {
                    image = icons.close,
                    resize = true,
                    forced_height = dpi(18),
                    forced_width = dpi(18),
                    widget = wibox.widget.imagebox
                }
            }
        },
        widget = clickable_container
    }

    local row_top =
        wibox.widget {
        {
            button_capture,
            button_video_capture,
            spacing = dpi(4),
            layout = wibox.layout.fixed.horizontal
        },
        nil,
        btn_close,
        layout = wibox.layout.align.horizontal
    }

    local row_middle =
        wibox.widget {
        snap_area_button,
        snap_full_button,
        snap_window,
        spacing = beautiful.widget_margin,
        widget = wibox.layout.fixed.horizontal
    }

    local row_bottom =
        wibox.widget {
        widget = wibox.container.background,
        bg = beautiful.bg_panel,
        shape = beautiful.client_shape_rectangle_xl,
        {
            {
                {
                    text = 'Delay in Seconds',
                    widget = wibox.widget.textbox
                },
                nil,
                {
                    btn_delay_num(),
                    spacing = beautiful.widget_margin,
                    layout = wibox.layout.fixed.horizontal
                },
                layout = wibox.layout.align.horizontal
            },
            margins = dpi(10),
            widget = wibox.container.margin
        }
    }

    local container =
        wibox.widget {
        {
            row_top,
            row_middle,
            row_bottom,
            spacing = dpi(10),
            layout = wibox.layout.fixed.vertical
        },
        margins = dpi(16),
        widget = wibox.container.margin
    }

    local maim_popup =
        awful.popup {
        widget = {
            widget = wibox.container.background,
            shape = beautiful.client_shape_rectangle_xl,
            bg = beautiful.bg_normal,
            container
        },
        ontop = true,
        visible = false,
        bg = '#00000000',
        screen = awful.screen.focused,
        placement = awful.placement.centered
    }

    local hide_maim_popup = function()
        maim_popup.visible = not maim_popup.visible
    end

    local show_maim_popup = function()
        maim_popup.visible = true
    end

    local display_popup = function()
        if maim_popup.visible then
            hide_maim_popup()
        else
            show_maim_popup()
        end
    end

    local take_screen_shot = function()
        awesome.emit_signal('control-center::hide')
        sleep(.2)

        local screen_shot_dir = '~/Pictures/Screenshots/'

        if not filesystem.dir_readable(screen_shot_dir) then
            awful.spawn.with_shell('mkdir -p ' .. screen_shot_dir)
        end

        local file_name = os.date('%d-%m-%Y-%H:%M:%S') .. '.png'
        local command = ''
        if snap_area == 'area' then
            command = 'maim -s -d ' .. delay_sec .. ' ' .. screen_shot_dir .. file_name
        elseif snap_area == 'screen' then
            command = 'maim -d ' .. delay_sec .. ' ' .. screen_shot_dir .. file_name
        elseif snap_area == 'window' then
            command = 'maim -d ' .. delay_sec .. ' ' .. '-i $(xdotool getactivewindow) ' .. screen_shot_dir .. file_name
        end

        hide_maim_popup()
        sleep(delay_sec + 0.2)

        local open_file =
            naughty.action {
            name = 'Open',
            icon_only = false
        }

        local open_dir =
            naughty.action {
            name = 'Open Folder',
            icon_only = false
        }

        local delete_file =
            naughty.action {
            name = 'Delete',
            icon_only = false
        }

        open_file:connect_signal(
            'invoked',
            function()
                awful.spawn.with_shell('xdg-open ' .. screen_shot_dir .. file_name, false)
            end
        )

        open_dir:connect_signal(
            'invoked',
            function()
                awful.spawn.with_shell('xdg-open ' .. screen_shot_dir, false)
            end
        )

        delete_file:connect_signal(
            'invoked',
            function()
                awful.spawn.with_shell('gio trash ' .. screen_shot_dir .. file_name, false)
            end
        )

        awful.spawn.easy_async_with_shell(
            command,
            function(_, _)
                naughty.notification(
                    {
                        app_name = 'Screenshot Tool',
                        icon = beautiful.icon_screenhost_taken,
                        timeout = 10,
                        title = '<b>Screenshot taken</b>',
                        message = 'Screenshot saved to ' .. screen_shot_dir .. file_name,
                        actions = {open_file, open_dir, delete_file}
                    }
                )

                show_maim_popup()
            end
        )
    end

    button_capture:connect_signal(
        'button::press',
        function(_, _, _, button)
            if button == 1 then
                take_screen_shot()
            end
        end
    )

    local screen_record_notify = function(title, message)
        naughty.notification {
            icon = beautiful.icon_recorder,
            app_name = 'Screen Recorder',
            title = title,
            message = message,
            timeout = 10
        }
    end

    local is_video_capturing = false
    button_video_capture:connect_signal(
        'button::press',
        function(self, _, _, button)
            if button == 1 then
                local video_dir = '~/Documents/'
                local file_name = os.date('%d-%m-%Y-%H:%M:%S') .. '.mp4'
                local command =
                    'ffmpeg -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0+0,0 ' .. video_dir .. file_name
                local btn_text_widget = self:get_children_by_id('buttontext')[1]
                if not is_video_capturing then
                    awful.spawn.with_shell(command)
                    btn_text_widget:set_text('Stop Recording')
                    is_video_capturing = true
                    screen_record_notify('Screen Recording Started', '')
                else
                    awful.spawn.with_shell('killall ffmpeg')
                    is_video_capturing = false
                    btn_text_widget:set_text('Start Recording')
                    screen_record_notify('Screen Recording Stoped', 'File saved to ' .. video_dir .. file_name)
                end
            end
        end
    )

    btn_close:connect_signal(
        'button::press',
        function(_, _, _, button)
            if button == 1 then
                hide_maim_popup()
            end
        end
    )

    local screen_shot_button = circle_big(icons.camera)
    local label = screen_shot_button:get_children_by_id('label')[1]
    label:set_text('Take Shot')
    screen_shot_button:connect_signal(
        'button::press',
        function(self, _, _, button)
            if button == 1 then
                display_popup()
            end
        end
    )

    return screen_shot_button
end

return screenshot_menu
