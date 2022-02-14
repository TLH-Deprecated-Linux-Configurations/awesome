--  _______
-- |_     _|.---.-.-----.-----.
--   |   |  |  _  |  _  |__ --|
--   |___|  |___._|___  |_____|
--                |_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- because of the order at which the files are called, I can't rely on the
-- global_variables to call libraries for this file. I know, lame.
--
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local tag = tag
local dpi = beautiful.xresources.apply_dpi
-- ------------------------------------------------- --
-- These are only called here, so they are retained in this file
-- instead of configuration.settings.global_var
--
local empathy = require("configuration.tags.layouts.empathy")
local stack = require("configuration.tags.layouts.stack")
local centermaster = require("configuration.tags.layouts.centermaster")
local thrizen = require("configuration.tags.layouts.thrizen")

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- define the default layouts, incliding the custom ones called above
--
tag.connect_signal(
    "request::default_layouts",
    function(s)
        awful.layout.append_default_layouts(
            {
                stack,
                empathy,
                centermaster,
                thrizen,
                awful.layout.suit.max,
                awful.layout.suit.spiral.dwindle
                -- awful.layout.suit.corner.ne,
                -- awful.layout.suit.fair
                --awful.layout.suit.floating, -- <-- Don't need when I have floating mode for windows as needed
                --awful.layout.suit.tile,
                --awful.layout.suit.magnifier,
                --awful.layout.suit.fair.horizontal
                --awful.layout.suit.tile.left,
                --awful.layout.suit.tile.bottom,
                --awful.layout.suit.tile.top,
                --awful.layout.suit.fair,
                --awful.layout.suit.fair.horizontal,
                --awful.layout.suit.max.fullscreen,
                --awful.layout.suit.corner.nw
                --awful.layout.suit.corner.sw,
                --awful.layout.suit.corner.se,
            }
        )
    end
)

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
awful.screen.connect_for_each_screen(
    function(s)
        -- Each screen has its own tag table, which I have styled using
        -- the name of the window manager. Still not as lame as using sway.
        -- Only using 7 tags per screen because the extra "WM" makes the
        -- taglist too long for the wibar
        --
        local tag_names = {"A", "W", "E", "S", "O", "M", "E"}
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
                    selected = selected,
                    border_color = beautiful.border_color,
                    border_width = dpi(2)
                }
            )
        end
        -- ------------------------------------------------- --
        -- assign properties to the taglist
        --
        local tags =
            awful.widget.taglist {
            screen = s,
            filter = awful.widget.taglist.filter.all
        }
        return tags
    end
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- gaps determined by layout type
--
tag.connect_signal(
    "property::layout",
    function(t)
        local currentLayout = awful.tag.getproperty(t, "layout")
        if (currentLayout == awful.layout.suit.max) then
            t.gap = dpi(4)
        else
            t.gap = dpi(8)
        end
        t.master_count = 1
    end
)
