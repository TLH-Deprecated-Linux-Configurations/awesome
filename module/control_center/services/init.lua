--                          __
-- .-----.-----.----.--.--.|__|.----.-----.-----.
-- |__ --|  -__|   _|  |  ||  ||  __|  -__|__ --|
-- |_____|_____|__|  \___/ |__||____|_____|_____|
--  __           __   __
-- |  |--.--.--.|  |_|  |_.-----.-----.-----.
-- |  _  |  |  ||   _|   _|  _  |     |__ --|
-- |_____|_____||____|____|_____|__|__|_____|
-- ------------------------------------------------- --

local wifi = require("module.control_center.services.wifi")
local bluetooth = require("module.control_center.services.bluetooth")
local dnd = require("module.control_center.services.Dnd")

-- extras

local mic = require("module.control_center.services.mic")
-- TODO add other buttons (restart awesome button, screen recorder button, etc)
-- ------------------------------------------------- --
-- ------------------ extras setup ----------------- --
local control_center_extra_conrols =
    wibox.widget {
    mic,
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(22),
    visible = false
}

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
    "control_center::extras",
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
