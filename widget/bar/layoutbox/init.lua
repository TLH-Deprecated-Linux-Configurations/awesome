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

local ll =
    awful.widget.layoutlist {
    spacing = dpi(64),
    base_layout = wibox.widget {
        spacing = dpi(64),
        forced_num_cols = 4,
        layout = wibox.layout.grid.vertical
    },
    -- ------------------------------------------------- --

    widget_template = {
        {
            {
                {
                    id = "icon_role",
                    forced_height = dpi(84),
                    forced_width = dpi(84),
                    widget = wibox.widget.imagebox,
                    shape = beautiful.client_shape_rounded_xl
                },
                margins = dpi(15),
                widget = wibox.container.margin,
                shape = beautiful.client_shape_rounded_xl
            },
            widget = clickable_container
        },
        id = "background_role",
        forced_width = dpi(96),
        forced_height = dpi(96),
        bg = beautiful.bg_button,
        shape = beautiful.client_shape_rounded_xl,
        widget = wibox.container.background
    }
}
-- ------------------------------------------------- --
local layout_popup =
    awful.popup {
    widget = wibox.widget {
        {
            ll,
            margins = dpi(24),
            screen = mouse.screen,
            widget = wibox.container.margin
        },
        widget = wibox.container.background
    },
    border_width = dpi(3),
    border_color = colors.alpha(colors.black, "88"),
    bg = colors.alpha(colors.colorA, "88"),
    shape = beautiful.client_shape_rounded_xl,
    screen = mouse.screen,
    placement = awful.placement.centered,
    ontop = true,
    visible = false
}
-- ------------------------------------------------- --
layout_popup.timer = gears.timer {timeout = 3}
layout_popup.timer:connect_signal(
    "timeout",
    function()
        layout_popup.visible = false
        layout_popup.screen = mouse.screen
    end
)
layout_popup.screen = mouse.current
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
local layout_box = function(s)
    local layoutbox =
        wibox.widget {
        {
            {
                {
                    awful.widget.layoutbox(s),
                    top = dpi(6),
                    bottom = dpi(6),
                    left = dpi(16),
                    right = dpi(16),
                    widget = wibox.container.margin
                },
                shape = beautiful.client_shape_rounded_xl,
                widget = wibox.container.background
            },
            widget = clickable_container
        },
        left = dpi(0),
        right = dpi(0),
        top = dpi(3),
        bottom = dpi(2),
        widget = wibox.container.margin
    }

    -- ------------------------------------------------- --
    layoutbox:buttons(
        awful.util.table.join(
            awful.button(
                {},
                1,
                function()
                    awesome.emit_signal("layout::changed:next")
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awesome.emit_signal("layout::changed:prev")
                end
            ),
            awful.button(
                {},
                8,
                function()
                    awesome.emit_signal("layout::changed:next")
                end
            ),
            awful.button(
                {},
                9,
                function()
                    awesome.emit_signal("layout::changed:prev")
                end
            )
        )
    )

    -- ------------------------------------------------- --
    return layoutbox
end
awesome.connect_signal(
    "layout::changed:next",
    function()
        awful.layout.inc(1)
        layout_popup.visible = true
        layout_popup.timer:start()
    end
)
awesome.connect_signal(
    "layout::changed:prev",
    function()
        awful.layout.inc(-1)
        layout_popup.visible = true
        layout_popup.timer:start()
    end
)
-- ----------------------------------------------f--- --
return layout_box
