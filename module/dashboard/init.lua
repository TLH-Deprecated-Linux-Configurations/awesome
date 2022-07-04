--  _____               __     __                        __
-- |     \.---.-.-----.|  |--.|  |--.-----.---.-.----.--|  |
-- |  --  |  _  |__ --||     ||  _  |  _  |  _  |   _|  _  |
-- |_____/|___._|_____||__|__||_____|_____|___._|__| |_____|
-- ------------------------------------------------- --

-- Aesthetic Dashboard
-------------------------

local function centered_widget(widget)
    local w =
        wibox.widget(
        {
            nil,
            {
                nil,
                widget,
                expand = "none",
                layout = wibox.layout.align.vertical
            },
            expand = "none",
            layout = wibox.layout.align.horizontal
        }
    )

    return w
end

local function create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
    local box_container = wibox.container.background()
    box_container.bg = bg_color
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = beautiful.client_shape_rounded_large

    local boxed_widget =
        wibox.widget(
        {
            {
                -- Add margins
                {
                    -- Add background color
                    {
                        -- The actual widget goes here
                        widget_to_be_boxed,
                        top = dpi(12),
                        bottom = dpi(12),
                        left = dpi(10),
                        right = dpi(10),
                        widget = wibox.container.margin,
                        shape = beautiful.client_shape_rounded_xl
                    },
                    widget = box_container
                },
                margins = dpi(8),
                color = beautiful.bg_menu,
                widget = wibox.container.margin
            },
            widget = wibox.container.background,
            bg = beautiful.bg_button,
            shape = beautiful.client_shape_rounded_xl
        }
    )

    return boxed_widget
end

local time = require("widget.dashboard.time")

local date = require("widget.dashboard.date")
-- pfp
local profile_pic_img = {
    {
        image = icons.logo,
        halign = "center",
        valign = "center",
        widget = wibox.widget.imagebox
    },
    widget = wibox.container.background,
    bg = beautiful.bg_button
}

local profile_pic_container =
    wibox.widget(
    {
        forced_height = dpi(90),
        forced_width = dpi(90),
        widget = wibox.container.background,
        bg = beautiful.bg_focus,
        shape = beautiful.client_shape_rounded_xl
    }
)

local profile = {
    {
        {
            profile_pic_img,
            widget = profile_pic_container
        },
        margins = dpi(1),
        widget = wibox.container.margin
    },
    widget = wibox.container.background,
    bg = beautiful.bg_focus,
    shape = beautiful.client_shape_rounded_large
}

awful.screen.connect_for_each_screen(
    function(s)
        local dashboard_width = dpi(860)
        local dashboard_height = dpi(640)

        -- widgets
        local notifs = require("widget.dashboard.notifs")

        s.stats = require("widget.dashboard.dials")

        s.time_boxed = create_boxed_widget(centered_widget(time), dpi(260), dpi(90), beautiful.transparent)
        s.date_boxed = create_boxed_widget(date, dpi(260), dpi(110), beautiful.transparent)
        s.notifs = create_boxed_widget(notifs, dpi(420), dpi(640), beautiful.transparent)
        s.stats_boxed = create_boxed_widget(s.stats, dpi(260), dpi(360), beautiful.transparent)

        local dashboard_items =
            wibox.widget(
            {
                nil,
                {
                    s.time_boxed,
                    {
                        {
                            profile,
                            layout = wibox.layout.fixed.vertical
                        },
                        {
                            s.date_boxed,
                            layout = wibox.layout.fixed.vertical
                        },
                        layout = wibox.layout.fixed.horizontal
                    },
                    s.stats_boxed,
                    layout = wibox.layout.fixed.vertical
                },
                expand = "none",
                layout = wibox.layout.align.horizontal
            }
        )

        -- Dashboard and animations init
        dashboard =
            awful.popup(
            {
                type = "dock",
                screen = s,
                maximum_height = dashboard_height,
                minimum_width = dashboard_width,
                maximum_width = dashboard_width,
                -- center it on the screen assuming 1920x1080 resolution
                x = s.geometry.x + s.geometry.width / 2 - dpi(400),
                bg = beautiful.transparent,
                ontop = true,
                visible = false,
                widget = {
                    {
                        layout = wibox.layout.flex.horizontal,
                        spacing = dpi(10),
                        spacing_widget = wibox.widget.separator(
                            {
                                span_ratio = 0.50,
                                color = colors.alpha(colors.color1, "88")
                            }
                        ),
                        dashboard_items,
                        s.notifs
                    },
                    bg = beautiful.bg_menu,
                    shape = beautiful.client_shape_rounded_xl,
                    widget = wibox.container.background
                }
            }
        )

        local anim_length = 0.7
        -- Gears Timer so awestore_compat can go
        local slide_end =
            gears.timer(
            {
                single_shot = true,
                timeout = anim_length + 0.1, --so the panel doesnt disappear in the last bit
                callback = function()
                    dashboard.visible = not dashboard.opened
                end
            }
        )

        -- Rubato
        local slide =
            rubato.timed(
            {
                pos = -dashboard.height,
                rate = 60,
                duration = anim_length,
                intro = anim_length / 2,
                easing = rubato.linear,
                subscribed = function(pos)
                    dashboard.y = pos
                end
            }
        )

        -- Make toogle button
        local dashboard_show = function()
            dashboard.visible = true
            slide.target = dpi(60)
            dashboard:emit_signal("opened")
        end

        local dashboard_hide = function()
            slide_end:again()
            slide.target = -dashboard.height
            dashboard:emit_signal("closed")
        end

        function dashboard:toggle()
            self.opened = not self.opened
            if self.opened then
                dashboard_hide()
            else
                dashboard_show()
            end
        end
    end
)
