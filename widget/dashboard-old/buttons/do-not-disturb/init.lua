--  _____  _______ _____
-- |     \|    |  |     \
-- |  --  |       |  --  |
-- |_____/|__|____|_____/
-- ------------------------------------------------- --

local template = require('widget.dashboard.buttons.template')
local widget = template('airplane-mode')

_G.dnd_status = false

widget:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                if _G.dnd_status == true then
                    _G.dnd_status = false
                    widget.bg = beautiful.bg_focus
                elseif _G.dnd_status == false then
                    _G.dnd_status = true
                    widget.bg = beautiful.accent
                end
            end
        )
    )
)

return widget
