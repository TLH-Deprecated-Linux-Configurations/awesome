-- services buttons
-- ~~~~~~~~~~~~~~~~
-- each button has a fade animation when activated
-- requirements
-- ~~~~~~~~~~~~
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")

-- widgets
-- ~~~~~~~
local wifi = require("module.controlCenter.services.wifi")
local bluetooth = require("module.controlCenter.services.bluetooth")

-- extras
----------------------------------------------------------------

local dnd = require("module.controlCenter.services.Dnd")
local mic = require("module.controlCenter.services.mic")

-- extras setup
local control_center_extra_conrols =
    wibox.widget {
    mic,
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(22),
    visible = false
}
-- Eo extras
-----------------------------------------------

-- return
-- ~~~~~~
local returner =
    wibox.widget {
    {
        wifi,
        dnd,
        bluetooth,
        layout = wibox.layout.flex.horizontal,
        spacing = dpi(22)
    },
    control_center_extra_conrols,
    spacing = dpi(0),
    layout = wibox.layout.fixed.vertical
}

awesome.connect_signal(
    "controlCenter::extras",
    function(value)
        control_center_extra_conrols.visible = value or false
        if not value then
            returner.spacing = dpi(0)
        else
            returner.spacing = dpi(22)
        end
    end
)

return returner
