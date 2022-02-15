--  _____                            __
-- |     |_.---.-.--.--.-----.--.--.|  |_
-- |       |  _  |  |  |  _  |  |  ||   _|
-- |_______|___._|___  |_____|_____||____|
--               |_____|
--  ______
-- |   __ \.-----.--.--.
-- |   __ <|  _  |_   _|
-- |______/|_____|__.__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local clickable_container = require("module.clickable-container")
local mod_key = require("configuration.keys.mod")
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local ll =
    awful.widget.layoutlist {
    spacing = dpi(84),
    base_layout = wibox.widget {
        spacing = dpi(72),
        forced_num_cols = 3,
        layout = wibox.layout.grid.vertical
    },
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    widget_template = {
        {
            {
                id = "icon_role",
                forced_height = dpi(84),
                forced_width = dpi(84),
                widget = wibox.widget.imagebox
            },
            margins = dpi(15),
            widget = wibox.container.margin
        },
        id = "background_role",
        forced_width = dpi(84),
        forced_height = dpi(84),
        shape = gears.shape.rounded_rect,
        widget = wibox.container.background
    }
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local layout_popup =
    awful.popup {
    widget = wibox.widget {
        ll,
        margins = dpi(36),
        screen = mouse.screen,
        widget = wibox.container.margin
    },
    border_width = dpi(3),
    screen = mouse.screen,
    placement = awful.placement.centered,
    ontop = true,
    visible = false
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
layout_popup.timer = gears.timer {timeout = 2}
layout_popup.timer:connect_signal(
    "timeout",
    function()
        layout_popup.visible = false
        layout_popup.screen = mouse.screen
    end
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
function gears.table.iterate_value(t, value, step_size, filter, start_at)
    local k = gears.table.hasitem(t, value, true, start_at)
    if not k then
        return
    end
    step_size = 1
    local new_key = gears.math.cycle(#t, k + step_size)
    if filter and not filter(t[new_key]) then
        for i = 1, #t do
            local k2 = gears.math.cycle(#t, new_key + i)
            if filter(t[k2]) then
                return t[k2], k2
            end
        end
        return
    end
    return t[new_key], new_key
end
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
awful.keygrabber {
    start_callback = function()
        layout_popup.visible = true
        layout_popup.screen = mouse.screen
    end,
    stop_callback = function()
        layout_popup.timer:start()
    end,
    export_keybindings = true,
    stop_event = "release",
    stop_key = {"Escape", "Super_L", "Super_R", "Mod4"},
    keybindings = {
        {
            {"Mod4", "Shift"},
            " ",
            function()
                awful.layout.inc(-1)
                layout_popup.timer:start()
                layout_popup.visible = true
            end
        },
        {
            {"Mod4"},
            " ",
            function()
                awful.layout.inc(1)
                layout_popup.timer:start()
                layout_popup.visible = true
            end
        }
    }
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local layout_box = function(s)
    local layoutbox =
        wibox.widget {
        {
            awful.widget.layoutbox(s),
            margins = dpi(7),
            widget = wibox.container.margin
        },
        widget = clickable_container
    }
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    layoutbox:buttons(
        awful.util.table.join(
            awful.button(
                {},
                1,
                function()
                    awful.layout.inc(1)
                    layout_popup.timer:start()
                    layout_popup.visible = true
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.layout.inc(-1)
                    layout_popup.timer:start()
                    layout_popup.visible = true
                end
            ),
            awful.button(
                {},
                8,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                9,
                function()
                    awful.layout.inc(-1)
                end
            )
        )
    )
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    return layoutbox
end
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
return layout_box
