--  _______               __
-- |_     _|.---.-.-----.|  |--.
--   |   |  |  _  |__ --||    <
--   |___|  |___._|_____||__|__|

--  _____   __         __
-- |     |_|__|.-----.|  |_
-- |       |  ||__ --||   _|
-- |_______|__||_____||____|
-- ------------------------------------------------- --
--- Common method to create buttons.
--

-- ------------------------------------------------- --
local tasklist_buttons =
    awful.util.table.join(
    awful.button(
        {},
        1,
        function(c)
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end
                -- This will also un-minimize
                -- the client, if needed
                c:emit_signal("request::activate")
                c:raise()
            end
        end
    ),
    awful.button(
        {},
        2,
        function(c)
            c:kill()
        end
    ),
    -- Using the mouse wheel for this is
    -- insanely frustrating, so the scroll
    -- buttons are used instead
    --
    awful.button(
        {},
        8,
        function()
            awful.client.focus.byidx(1)
        end
    ),
    awful.button(
        {},
        9,
        function()
            awful.client.focus.byidx(-1)
        end
    )
)
-- ------------------------------------------------- --
local task_list = function(s)
    return awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            shape_border_width = 1,
            shape_border_color = colors.alpha(colors.black, "88"),
            shape = beautiful.client_shape_rounded_small
        },
        layout = {
            spacing = 5,
            spacing_widget = {
                {
                    forced_width = 5,
                    shape = gears.shape.circle,
                    widget = wibox.widget.separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place
            },
            layout = wibox.layout.flex.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                {
                    {
                        {
                            id = "icon_role",
                            widget = wibox.widget.imagebox
                        },
                        margins = dpi(2),
                        widget = wibox.container.margin
                    },
                    {
                        id = "text_role",
                        widget = wibox.widget.textbox
                    },
                    layout = wibox.layout.fixed.horizontal,
                    bg = beautiful.bg_button
                },
                left = dpi(5),
                right = dpi(5),
                widget = wibox.container.margin
            },
            id = "background_role",
            forced_width = dpi(120),
            widget = clickable_container
        }
    }
end

--[[  return awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            spacing_widget = {
                {
                    forced_width = dpi(15),
                    forced_height = dpi(36),
                    thickness = dpi(15),
                    color = colors.alpha(colors.colorA, "88"),
                    widget = wibox.widget.separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place
            },
            spacing = dpi(8),
            layout = wibox.layout.fixed.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                {
                    {
                        {
                            id = "clienticon",
                            forced_width = dpi(28),
                            forced_height = dpi(28),
                            widget = awful.widget.clienticon
                        },
                        margins = dpi(1),
                        widget = wibox.container.margin
                    },
                    valign = "center",
                    halign = "center",
                    widget = wibox.container.place
                },
                widget = clickable_container,
                forced_width = dpi(48),
                forced_height = dpi(48)
            },
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id("clienticon")[1].client = c
            end,
            layout = wibox.layout.flex.horizontal
        }
    }
end
 ]]
return task_list
