--  _______
-- |_     _|.---.-.-----.-----.
--   |   |  |  _  |  _  |__ --|
--   |___|  |___._|___  |_____|
--                |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local awful = require("awful")
local empathy = require("configuration.tags.layouts.empathy")
local stack = require("configuration.tags.layouts.stack")
local centermaster = require("configuration.tags.layouts.centermaster")
-- ########################################################################
-- ########################################################################
-- ########################################################################
_G.tag.connect_signal(
    "request::default_layouts",
    function()
        awful.layout.append_default_layouts(
            {
                stack,
                empathy,
                centermaster,
                awful.layout.suit.max,
                awful.layout.suit.tile,
                awful.layout.suit.spiral.dwindle,
                awful.layout.suit.floating,
                awful.layout.suit.fair,
                awful.layout.suit.magnifier,
                awful.layout.suit.fair.horizontal
            }
        )
    end
)

-- ########################################################################
-- ########################################################################
-- ########################################################################
awful.screen.connect_for_each_screen(
    function(s)
        -- Each screen has its own tag table.

        local tag_names = {"A", "W", "E", "S", "O", "M", "E", "W", "M"}
        for idx, name in ipairs(tag_names) do
            local selected = false
            if idx == 1 then
                selected = true
            end

            awful.tag.add(
                name,
                {
                    screen = s,
                    layout = stack,
                    selected = selected
                }
            )
        end
        -- ########################################################################
        local tags =
            awful.widget.taglist {
            screen = s,
            filter = awful.widget.taglist.filter.all
        }
        return tags
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
_G.tag.connect_signal(
    "property::layout",
    function(t)
        local currentLayout = awful.tag.getproperty(t, "layout")
        if (currentLayout == awful.layout.suit.max) then
            t.gap = 12
        else
            t.gap = awful.tag.getproperty(t, "gap") or 8
        end
        t.master_count = 1
    end
)
