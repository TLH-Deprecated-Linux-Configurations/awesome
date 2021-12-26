--  _______
-- |_     _|.---.-.-----.
--   |   |  |  _  |  _  |
--   |___|  |___._|___  |
--                |_____|
--  _____   __         __
-- |     |_|__|.-----.|  |_
-- |       |  ||__ --||   _|
-- |_______|__||_____||____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local tag_preview_box = require("layout.bottom-panel.widget.tag-list.tag-preview")
tag_preview_box.enable {
    show_client_content = true,
    -- Whether or not to show the client content
    -- The x-coord of the popup
    --
    x = 10,
    -- The y-coord of the popup
    --
    y = 10,
    -- The scale of the previews compared to the screen
    --
    scale = 0.25,
    -- Honor padding when creating widget size
    --
    honor_padding = false,
    -- Honor work area when creating widget size
    --
    honor_workarea = false,
    -- Place the widget using awful.placement (this overrides x & y)
    --
    placement_fn = function(c)
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
        spacing = dpi(12),
        filter = awful.widget.taglist.filter.all,
        layout = wibox.layout.fixed.horizontal,
        widget_template = {
            {
                {
                    {
                        -- NOTE: because this uses wibox.layout.align, the
                        -- two nil represent the right and left sections
                        -- of the layout, providing them on either side
                        -- of the text role means the text is centered
                        nil,
                        {
                            id = "text_role",
                            widget = wibox.widget.textbox
                        },
                        nil,
                        layout = wibox.layout.align.horizontal,
                        expand = "outside"
                    },
                    widget = clickable_container
                },
                widget = wibox.container.background,
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, 12)
                end,
                forced_width = dpi(36),
                border_width = dpi(0)
            },
            id = "background_role",
            top = dpi(2),
            bottom = dpi(2),
            border_width = dpi(0),
            widget = wibox.container.background,
            create_callback = function(self, c3, index, objects)
                self:connect_signal(
                    "mouse::enter",
                    function()
                        if #c3:clients() > 0 then
                            awesome.emit_signal("tag_preview::update", c3)
                            awesome.emit_signal("tag_preview::visibility", s, true)
                        end
                        if self.bg ~= "#f4f4f7cc" then
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
                            self.bg = beautiful.bg_focus
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
