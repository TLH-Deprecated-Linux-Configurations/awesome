--  _______
-- |     __|.----.----.-----.-----.-----.
-- |__     ||  __|   _|  -__|  -__|     |
-- |_______||____|__| |_____|_____|__|__|
--  ______               __
-- |      |.---.-.-----.|  |_.--.--.----.-----.
-- |   ---||  _  |  _  ||   _|  |  |   _|  -__|
-- |______||___._|   __||____|_____|__| |_____|
--               |__|
-- ------------------------------------------------- --

local template = require('widget.dashboard.buttons.template')
local widget = template('recorder-off')
widget:connect_signal(
    'mouse::enter',
    function()
        widget.bg = beautiful.accent
    end
)

widget:connect_signal(
    'mouse::leave',
    function()
        widget.bg = beautiful.bg_focus
    end
)

widget:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn.with_shell(gfs .. 'bin/snapshot.sh full')
            end
        )
    )
)

return widget
