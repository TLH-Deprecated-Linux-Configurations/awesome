--  ______               __               __
-- |   __ \.-----.-----.|  |_.---.-.----.|  |_
-- |      <|  -__|__ --||   _|  _  |   _||   _|
-- |___|__||_____|_____||____|___._|__|  |____|

--  _______
-- |   _   |.--.--.--.-----.-----.-----.--------.-----.
-- |       ||  |  |  |  -__|__ --|  _  |        |  -__|
-- |___|___||________|_____|_____|_____|__|__|__|_____|

-- ------------------------------------------------- --

local template = require('widget.dashboard.buttons.template')
local widget = template('restart')
-- ------------------------------------------------- --
widget:connect_signal(
    'mouse::enter',
    function()
        widget.bg = beautiful.accent
    end
)
-- ------------------------------------------------- --
widget:connect_signal(
    'mouse::leave',
    function()
        widget.bg = beautiful.bg_focus
    end
)
-- ------------------------------------------------- --
widget:buttons(gears.table.join(awful.button({}, 1, nil, awesome.restart)))

return widget
