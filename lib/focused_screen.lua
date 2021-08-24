local awful = require 'awful'

local function focused_screen()
    if mouse ~= nil and mouse.screen ~= nil then
        return mouse.screen
    end
    return awful.screen.focused() or screen[1]
end
