--  ______ __               __                __   __
-- |   __ \  |.--.--.-----.|  |_.-----.-----.|  |_|  |--.
-- |   __ <  ||  |  |  -__||   _|  _  |  _  ||   _|     |
-- |______/__||_____|_____||____|_____|_____||____|__|__|
--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|
-- ------------------------------------------------- --

awful.screen.connect_for_each_screen(
    function(s)
        -- ------------------------------------------------- --
        screenshot_menu =
            wibox(
            {
                type = 'dock',
                shape = beautiful.client_shape_rounded_xl,
                screen = s,
                width = dpi(560),
                height = dpi(320),
                bg = beautiful.bg_color,
                margins = dpi(20),
                ontop = true,
                visible = false
            }
        )
        -- ------------------------------------------------- --
        -- -------------------- widgets -------------------- --

        -- ------------------------------------------------- --

        local delay_sec = 0
        local snap_area = 'area'
        local take_screen_shot = function()
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
                command =
                    'maim -d ' .. delay_sec .. ' ' .. '-i $(xdotool getactivewindow) ' .. screen_shot_dir .. file_name
            end
            sleep = function(n)
                local t = os.clock()
                while os.clock() - t <= n do
                    -- nothing
                end
            end

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
                end
            )
        end

        local snap_area_button =
            clickable_container {
            {
                widget = wibox.widget.imagebox,
                image = icons.image_crop,
                forced_width = dpi(108),
                forced_height = dpi(108)
            },
            widget = wibox.container.margin,
            margins = dpi(22)
        }
        local snap_full_button =
            clickable_container {
            {
                widget = wibox.widget.imagebox,
                image = icons.computer,
                forced_width = dpi(108),
                forced_height = dpi(108)
            },
            widget = wibox.container.margin,
            margins = dpi(22)
        }
        local snap_window =
            clickable_container {
            {
                widget = wibox.widget.imagebox,
                image = icons.window,
                forced_width = dpi(108),
                forced_height = dpi(108)
            },
            widget = wibox.container.margin,
            margins = dpi(22)
        }
        snap_area_button.bg = beautiful.bg_button
        snap_full_button.bg = beautiful.bg_button
        snap_window.bg = beautiful.bg_button

        snap_area_button:connect_signal(
            'button::press',
            function(self, _, _, button)
                if button == 1 then
                    snap_area = 'area'
                    take_screen_shot()
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
                    take_screen_shot()
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
                    take_screen_shot()
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
        local screen_record_notify = function(title, message)
            naughty.notification {
                icon = beautiful.icon_recorder,
                app_name = 'Screen Recorder',
                title = title,
                message = message,
                timeout = 10
            }
        end
        local is_vedio_capturing = false
        button_video_capture:connect_signal(
            'button::press',
            function(self, _, _, button)
                if button == 1 then
                    local video_dir = '~/Documents/'
                    local file_name = os.date('%d-%m-%Y-%H:%M:%S') .. '.mp4'
                    local command =
                        'ffmpeg -video_size 1366x768 -framerate 30 -f x11grab -i :0.0+0,0 ' .. video_dir .. file_name
                    local btn_text_widget = self:get_children_by_id('buttontext')[1]
                    if not is_vedio_capturing then
                        awful.spawn.with_shell(command)
                        btn_text_widget:set_text('Stop Recording')
                        is_vedio_capturing = true
                        screen_record_notify('Screen Recording Started', '')
                    else
                        awful.spawn.with_shell('killall ffmpeg')
                        is_vedio_capturing = false
                        btn_text_widget:set_text('Start Recording')
                        screen_record_notify('Screen Recording Stoped', 'File saved to ' .. video_dir .. file_name)
                    end
                end
            end
        )

        local btn_delay_num = function()
            local btn_plus =
                clickable_container {
                {
                    image = icons.add,
                    resize = true,
                    forced_height = dpi(24),
                    forced_width = dpi(24),
                    widget = wibox.widget.imagebox
                },
                widget = wibox.container.margin,
                margins = dpi(6)
            }

            local btn_minus =
                clickable_container {
                {
                    image = icons.minus,
                    resize = true,
                    forced_height = dpi(24),
                    forced_width = dpi(24),
                    widget = wibox.widget.imagebox
                },
                widget = wibox.container.margin,
                margins = dpi(6)
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
                    bg = beautiful.bg_normal,
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
            widget = wibox.container.margin,
            margins = dpi(0),
            {
                image = icons.close,
                resize = true,
                forced_height = dpi(28),
                forced_width = dpi(28),
                widget = wibox.widget.imagebox
            }
        }

        btn_close:connect_signal(
            'button::press',
            function(_, _, _, button)
                if button == 1 then
                    sc_toggle()
                end
            end
        )

        local row_top =
            wibox.widget {
            {
                button_capture,
                button_video_capture,
                spacing = dpi(22),
                layout = wibox.layout.fixed.horizontal,
                btn_close
            },
            nil,
            layout = wibox.layout.flex.horizontal
        }

        local row_middle =
            wibox.widget {
            snap_area_button,
            snap_full_button,
            snap_window,
            spacing = dpi(22),
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
                spacing = dpi(20),
                layout = wibox.layout.fixed.vertical
            },
            margins = dpi(5),
            widget = wibox.container.margin
        }

        -- ------------------------------------------------- --
        -- ------------------- animations ------------------ --
        local slide_right =
            rubato.timed {
            pos = s.geometry.width,
            rate = 30,
            intro = 0.14,
            duration = 0.33,
            subscribed = function(pos)
                screenshot_menu.x = s.geometry.x + pos
            end
        }

        local slide_end =
            gears.timer(
            {
                single_shot = true,
                timeout = 0.33 + 0.08,
                callback = function()
                    screenshot_menu.visible = false
                end
            }
        )

        -- ------------------------------------------------- --
        --                   toggler script                  --
        -- ------------------------------------------------- --
        local screen_backup = 1

        sc_toggle = function(screen)
            -- NOTE set screen to default, if none were found
            if not screen then
                screen = awful.screen.focused()
            end

            -- NOTE control center x position
            screenshot_menu.x = screen.geometry.x + screen.geometry.width / 2
            screenshot_menu.y = screen.geometry.y + screen.geometry.height / 3
            -- NOTE  toggle visibility
            if screenshot_menu.visible then
                -- NOTE  check if screen is different or the same
                if screen_backup ~= screen.index then
                    screenshot_menu.visible = true
                else
                    slide_end:again()
                    awful.keygrabber.stop()
                    slide_right.target = s.geometry.height
                end
            elseif not screenshot_menu.visible then
                slide_right.target = s.geometry.height - (screenshot_menu.height + beautiful.useless_gap * 2)
                screenshot_menu.visible = true
                -- ------------------------------------------------- --
                -- ----------------- run keygrabber ---------------- --
                awful.keygrabber.run(
                    function(_, key, event)
                        if event == 'release' then
                            return
                        end
                        -- ------------------------------------------------- --
                        -- set keygrabber to grab Escape, q or x to close cc
                        if key == 'Escape' or key == 'q' or key == 'x' then
                            if screen_backup ~= screen.index then
                                control_c.visible = true
                            else
                                -- ------------------------------------------------- --
                                -- close animations with keygrabber stop command
                                slide_end:again()
                                slide_right.target = s.geometry.height
                                awful.keygrabber.stop()
                            end
                        end
                    end
                )
            end

            -- NOTE  set screen_backup to new screend
            screen_backup = screen.index
        end
        -- -------------------- Turn Off ------------------- --
        sc_off = function(screem)
            if screenshot_menu.visible then
                -- NOTE check if screen is different or the same
                slide_end:again()
                slide_right.target = s.geometry.height
            end
        end

        -- ------------------------------------------------- --
        --                   Initial setup                   --
        -- ------------------------------------------------- --
        screenshot_menu:setup {
            {
                {
                    container,
                    layout = wibox.layout.flex.vertical,
                    spacing = dpi(24)
                },
                widget = wibox.container.margin,
                margins = dpi(20)
            },
            layout = wibox.layout.fixed.vertical
        }
    end
)
