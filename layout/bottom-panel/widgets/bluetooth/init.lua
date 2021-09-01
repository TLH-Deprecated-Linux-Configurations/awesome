--  ______ __               __                __   __
-- |   __ \  |.--.--.-----.|  |_.-----.-----.|  |_|  |--.
-- |   __ <  ||  |  |  -__||   _|  _  |  _  ||   _|     |
-- |______/__||_____|_____||____|_____|_____||____|__|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local config = require('module.functions')
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- acpi sample outputs
-- Battery 0: Discharging, 75%, 01:51:38 remaining
-- Battery 0: Charging, 53%, 00:57:43 until charged

local checker

local widget =
    wibox.widget {
    {
        id = 'icon',
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local widget_button = clickable_container(wibox.container.margin(widget, dpi(8), dpi(8), dpi(8), dpi(8)))
widget_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                print('Opening blueman-manager')
                awful.spawn('blueman-manager')
            end
        )
    )
)

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Alternative to naughty.notify - tooltip. You can compare both and choose the preferred one
awful.tooltip(
    {
        objects = {widget_button},
        mode = 'outside',
        align = 'right',
        timer_function = function()
            if checker ~= nil then
                return ('Bluetooth is on')
            else
                return ('Bluetooth is off')
            end
        end,
        preferred_positions = {'right', 'left', 'top', 'bottom'}
    }
)

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- To use colors from beautiful theme put
-- following lines in rc.lua before require("battery"):
beautiful.tooltip_fg = beautiful.fg_normal
beautiful.tooltip_bg = beautiful.bg_normal
-- ########################################################################
-- ########################################################################
-- ########################################################################
delayed_timer(
    config.bluetooth_poll,
    function()
        awful.spawn.easy_async_with_shell(
            'bluetoothctl --monitor list',
            function(stdout)
                -- Check if there  bluetooth
                checker = stdout:match('Controller') -- If 'Controller' string is detected on stdout
                local widgetIconName

                local status = (checker ~= nil)
                signals.emit_bluetooth_status(status)

                if status then
                    widgetIconName = 'bluetooth'
                else
                    widgetIconName = 'bluetooth-off'
                end
                widget.icon:set_image(icons[widgetIconName])
                print('Polling bluetooth status')
            end
        )
    end,
    0
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
return widget_button
