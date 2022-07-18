--  ______
-- |   __ \.---.-.----.
-- |   __ <|  _  |   _|
-- |______/|___._|__|
--  ______         __   __
-- |   __ \.--.--.|  |_|  |_.-----.-----.
-- |   __ <|  |  ||   _|   _|  _  |     |
-- |______/|_____||____|____|_____|__|__|
-- ------------------------------------------------- --
local template = require('widget.dashboard.buttons.template')
local widget = template('awesome')

awesome.connect_signal(
    'bar:false',
    function()
        widget.bg = beautiful.accent
    end
)

awesome.connect_signal(
    'bar:true',
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
                awesome.emit_signal('bar:toggle')

                widget.bg = beautiful.bg_focus
            end
        )
    )
)

return widget
