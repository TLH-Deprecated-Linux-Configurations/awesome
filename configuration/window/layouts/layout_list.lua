local awful = require('awful')
local gears = require('gears')
local gfs = gears.filesystem
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = require('beautiful.xresources').apply_dpi
local helpers = require('helpers')
local awestore = require('awestore')
local bling = require('module.bling')

-- ########################################################################
-- ########################################################################
-- ########################################################################
local layout_list = {}
-- Layout List Widget Creates a menu that  displays the layouts and indicatest the present layout and shifts towards it.
-- List
local ll =
    awful.widget.layoutlist {
    source = awful.widget.layoutlist.source.default_layouts, -- DOC_HIDE
    spacing = dpi(24),
    base_layout = wibox.widget {
        spacing = dpi(24),
        forced_num_cols = 3,
        layout = wibox.layout.grid.vertical
    },
    widget_template = {
        {
            {
                id = 'icon_role',
                forced_height = dpi(84),
                forced_width = dpi(84),
                widget = wibox.widget.imagebox
            },
            margins = dpi(24),
            widget = wibox.container.margin
        },
        id = 'background_role',
        forced_width = dpi(84),
        forced_height = dpi(84),
        widget = wibox.container.background
    }
}

-- Popup
local layout_popup =
    awful.popup {
    widget = wibox.widget {
        {ll, margins = dpi(24), widget = wibox.container.margin},
        bg = beautiful.xbackground .. '99',
        shape = helpers.rrect(beautiful.border_radius),
        border_color = beautiful.widget_border_color .. '33',
        border_width = beautiful.widget_border_width,
        widget = wibox.container.background
    },
    placement = awful.placement.centered,
    ontop = true,
    visible = false,
    bg = beautiful.bg_normal .. '00'
}

-- Key Bindings for Widget ----------------------------------------------------

function gears.table.iterate_value(t, value, step_size, filter, start_at)
    local k = gears.table.hasitem(t, value, true, start_at)
    if not k then
        return
    end

    step_size = step_size or 1
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

awful.keygrabber {
    start_callback = function()
        layout_popup.visible = true
    end,
    stop_callback = function()
        layout_popup.visible = false
    end,
    export_keybindings = true,
    stop_event = 'release',
    stop_key = {'Escape', 'Super_L', 'Super_R', 'Mod4'},
    keybindings = {
        {
            {modkey, 'Shift'},
            ' ',
            function()
                awful.layout.set(gears.table.iterate_value(ll.layouts, ll.current_layout, -1), nil)
            end
        },
        {
            {modkey},
            ' ',
            function()
                awful.layout.set(gears.table.iterate_value(ll.layouts, ll.current_layout, 1), nil)
            end
        }
    }
}
return layout_list
