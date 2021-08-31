--  __                __ __         __
-- |  |_.---.-.-----.|  |__|.-----.|  |_
-- |   _|  _  |  _  ||  |  ||__ --||   _|
-- |____|___._|___  ||__|__||_____||____|
--            |_____|
local awful = require('awful')
local gears = require('gears')
local gfs = gears.filesystem
local wibox = require('wibox')
local beautiful = require('beautiful')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local tag_preview_box = require('layout.bottom-panel.widgets.tag-list.tag-preview')
tag_preview_box.enable {
    show_client_content = true, -- Whether or not to show the client content
    x = 10, -- The x-coord of the popup
    y = 10, -- The y-coord of the popup
    scale = 0.25, -- The scale of the previews compared to the screen
    honor_padding = false, -- Honor padding when creating widget size
    honor_workarea = false, -- Honor work area when creating widget size
    placement_fn = function(c) -- Place the widget using awful.placement (this overrides x & y)
        awful.placement.bottom_left(
            c,
            {
                margins = {
                    bottom = 40,
                    left = 30
                }
            }
        )
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
    -- The actual png icons
    -- I do have the svgs, but inkscape does a better job of scaling
    local ghost = gears.surface.load_uncached(gfs.get_configuration_dir() .. 'theme/icons/ghosts/ghost.png')
    local ghost_icon = gears.color.recolor_image(ghost, beautiful.xcolor4)
    local dot = gears.surface.load_uncached(gfs.get_configuration_dir() .. 'theme/icons/ghosts/dot.png')
    local dot_icon = gears.color.recolor_image(dot, beautiful.xcolor7)
    local pacman = gears.surface.load_uncached(gfs.get_configuration_dir() .. 'theme/icons/ghosts/pacman.png')
    local pacman_icon = gears.color.recolor_image(pacman, beautiful.xcolor3)
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Function to update the tags
    local update_tags = function(self, c3)
        local imgbox = self:get_children_by_id('icon_role')[1]

        if c3.selected then
            imgbox.image = pacman_icon
        elseif #c3:clients() == 0 then
            imgbox.image = dot_icon
        else
            imgbox.image = ghost_icon
        end
    end

    local pac_taglist =
        awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {spacing = 0, layout = wibox.layout.fixed.horizontal},
        widget_template = {
            {
                {id = 'icon_role', widget = wibox.widget.imagebox},
                id = 'margin_role',
                top = dpi(12),
                bottom = dpi(12),
                left = dpi(22),
                right = dpi(22),
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            create_callback = function(self, c3, index, objects)
                update_tags(self, c3)
                self:connect_signal(
                    'mouse::enter',
                    function()
                        if #c3:clients() > 0 then
                            awesome.emit_signal('tag_preview::update', c3)
                            awesome.emit_signal('tag_preview::visibility', s, true)
                        end
                        if self.bg ~= beautiful.xcolor0 .. '88' then
                            self.backup = self.bg
                            self.has_backup = true
                        end
                        self.bg = beautiful.xcolor0 .. '88'
                    end
                )
                self:connect_signal(
                    'mouse::leave',
                    function()
                        awesome.emit_signal('tag_preview::visibility', s, false)
                        if self.has_backup then
                            self.bg = beautiful.xcolor0 .. '88'
                        end
                    end
                )
            end,
            update_callback = function(self, c3, index, objects)
                update_tags(self, c3)
            end
        },
        buttons = taglist_buttons
    }

    return pac_taglist
end

return get_taglist
