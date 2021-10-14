-- __                __ __         __
-- |  |_.---.-.-----.|  |__|.-----.|  |_
-- |   _|  _  |  _  ||  |  ||__ --||   _|
-- |____|___._|___  ||__|__||_____||____|
--            |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local tag_preview_box = require "layout.bottom-panel.widgets.tag-list.tag-preview"
tag_preview_box.enable {
    show_client_content = true,
    -- Whether or not to show the client content
    x = 10,
    -- The x-coord of the popup
    y = 10,
    -- The y-coord of the popup
    scale = 0.25,
    -- The scale of the previews compared to the screen
    honor_padding = false,
    -- Honor padding when creating widget size
    honor_workarea = false,
    -- Honor work area when creating widget size
    placement_fn = function(c)
        -- Place the widget using awful.placement (this overrides x & y)
        awful.placement.bottom_left(c, {margins = {bottom = 40, left = 30}})
    end
}

-- ########################################################################
-- ########################################################################
-- ########################################################################
local get_taglist = function(s)
    -- Taglist buttons
    local taglist_buttons =
        gears.table.join(
        awful.button(
            {},
            1,
            function(t)
                t:view_only()
            end
        ),
        awful.button(
            {modkey},
            1,
            function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end
        ),
        awful.button({}, 3, awful.tag.viewtoggle),
        awful.button(
            {modkey},
            3,
            function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end
        )
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Function to update the tags

    local taglist =
        awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = wibox.layout.fixed.horizontal,
        widget_template = {
            {
                
                    {
                        id = "text_role",
                        widget = wibox.widget.textbox,

       
                        placement = awful.placement.centered(c),
                },

                forced_height = 36,
                forced_width = 36,
                widget = clickable_container,
                shape = beautiful.btn_xs_shape,
                placement = awful.placement.centered(c),
                border_width = dpi(1),
                border_color = beautiful.xcolor19 .. "ee"
            },
            id = "background_role",
            forced_height = 36,
            forced_width = 36,
            border_width = dpi(2),
            border_color = beautiful.xcolor7 .. "cc",
            shape = beautiful.btn_xs_shape,
            widget = wibox.container.background,
            create_callback = function(self, c3, index, objects)
                self:connect_signal(
                    "mouse::enter",
                    function()
                        if #c3:clients() > 0 then
                            awesome.emit_signal("tag_preview::update", c3)
                            awesome.emit_signal("tag_preview::visibility", s, true)
                        end
                        if self.bg ~= beautiful.xcolor7 .. "cc" then
                            self.backup = self.bg
                            self.has_backup = true

                        end
                     
                    end
                )
                self:connect_signal(
                    "mouse::leave",
                    function()
                        awesome.emit_signal("tag_preview::visibility", s, false)
                        if self.has_backup then
                            self.bg = beautiful.xcolor0 .. "cc"
                        end
                    end
                )
            end
        },
        buttons = taglist_buttons
    }
    return taglist
end
return get_taglist
