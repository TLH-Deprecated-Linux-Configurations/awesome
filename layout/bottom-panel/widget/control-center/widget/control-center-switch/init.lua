--  ______               __               __
-- |      |.-----.-----.|  |_.----.-----.|  |
-- |   ---||  _  |     ||   _|   _|  _  ||  |
-- |______||_____|__|__||____|__| |_____||__|
--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|
--  _______            __ __         __
-- |     __|.--.--.--.|__|  |_.----.|  |--.
-- |__     ||  |  |  ||  |   _|  __||     |
-- |_______||________||__|____|____||__|__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local config_dir = gears.filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. 'widget/control-center-switch/icons/'
local icons = require('theme.icons')
local monitor_mode = false
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local return_button = function()
    local widget =
        wibox.widget {
        {
            id = 'icon',
            image = icons.memory,
            widget = wibox.widget.imagebox,
            resize = true
        },
        layout = wibox.layout.align.horizontal
    }
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    local widget_button =
        wibox.widget {
        {
            {
                widget,
                margins = dpi(5),
                widget = wibox.container.margin
            },
            widget = clickable_container
        },
        bg = beautiful.transparent,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 2)
        end,
        widget = wibox.container.background
    }
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    local control_center_switch_mode = function()
        local cc_widget = awful.screen.focused().control_center.widget
        if monitor_mode then
            widget.icon:set_image(icons.memory)
            cc_widget:get_children_by_id('main_control')[1].visible = true
            cc_widget:get_children_by_id('monitor_control')[1].visible = false
        else
            widget.icon:set_image(widget_icon_dir .. 'control-center.svg')
            cc_widget:get_children_by_id('main_control')[1].visible = false
            cc_widget:get_children_by_id('monitor_control')[1].visible = true
        end
        monitor_mode = not monitor_mode
    end
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    widget_button:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                nil,
                function()
                    control_center_switch_mode()
                end
            )
        )
    )
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    return widget_button
end
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
return return_button
