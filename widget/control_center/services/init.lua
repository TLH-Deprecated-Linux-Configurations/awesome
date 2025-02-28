--                          __
-- .-----.-----.----.--.--.|__|.----.-----.-----.
-- |__ --|  -__|   _|  |  ||  ||  __|  -__|__ --|
-- |_____|_____|__|  \___/ |__||____|_____|_____|
--  __           __   __
-- |  |--.--.--.|  |_|  |_.-----.-----.-----.
-- |  _  |  |  ||   _|   _|  _  |     |__ --|
-- |_____|_____||____|____|_____|__|__|_____|
-- ------------------------------------------------- --

local wifi = require('widget.control_center.services.network')
local bluetooth = require('widget.control_center.services.bluetooth')
local dnd = require('widget.control_center.services.notifications')

-- extras
local stats = require('widget.control_center.services.stats')

-- ------------------------------------------------- --
-- ------------------ extras setup ----------------- --
local control_center_extra_conrols =
    wibox.widget {
    stats,
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
    spacing = dpi(22),
    layout = wibox.layout.fixed.vertical
}

awesome.connect_signal(
    'control_center::extras',
    function(value)
        control_center_extra_conrols.visible = value or false
        if not value then
            returner.spacing = dpi(22)
        else
            returner.spacing = dpi(22)
        end
    end
)

return returner
