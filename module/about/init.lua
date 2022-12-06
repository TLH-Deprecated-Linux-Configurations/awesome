--  _______ __                 __
-- |   _   |  |--.-----.--.--.|  |_
-- |       |  _  |  _  |  |  ||   _|
-- |___|___|_____|_____|_____||____|
-- ------------------------------------------------- --
-- a popup window displaying program info that is ultimately
-- just because it looks nice in screen recordings
local function about_popup()
    awful.spawn.easy_async(
        'awesome -v',
        function(stdout, _, _, _)
            local ver_info = stdout:gsub('\n[^\n]*$', '')
            awful.popup {
                screen = awful.screen.focused(),
                type = 'splash',
                visible = true,
                ontop = true,
                hide_on_right_click = true,
                placement = awful.placement.centered,
                shape = beautiful.client_shape_rounded_xl,
                widget = {
                    {
                        {
                            {
                                {
                                    {
                                        image = icons.awesome,
                                        forced_height = dpi(150),
                                        forced_width = dpi(150),
                                        clip_shape = beautiful.client_shape_rounded,
                                        resize = true,
                                        widget = wibox.widget.imagebox
                                    },
                                    widget = wibox.container.margin,
                                    margins = dpi(28)
                                },
                                widget = clickable_container,
                                bg = beautiful.bg_button,
                                shape = beautiful.client_shape_rounded_xl
                            },
                            widget = wibox.container.margin,
                            margins = dpi(8)
                        },
                        widget = wibox.container.background,
                        bg = beautiful.bg_normal
                    },
                    {
                        {
                            markup = ver_info,
                            widget = wibox.widget.textbox
                        },
                        widget = wibox.container.margin,
                        margins = dpi(12)
                    },
                    layout = wibox.layout.fixed.horizontal,
                    widget = wibox.container.background,
                    bg = beautiful.bg_menu
                }
            }
        end
    )
end

return about_popup
