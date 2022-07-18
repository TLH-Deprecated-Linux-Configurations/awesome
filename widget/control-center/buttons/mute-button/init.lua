--  _______         __
-- |   |   |.--.--.|  |_.-----.
-- |       ||  |  ||   _|  -__|
-- |__|_|__||_____||____|_____|
--  ______         __   __
-- |   __ \.--.--.|  |_|  |_.-----.-----.
-- |   __ <|  |  ||   _|   _|  _  |     |
-- |______/|_____||____|____|_____|__|__|
-- ------------------------------------------------- --
-- Creates a mute tiggle button
-- ------------------------------------------------- --
local template = require('widget.dashboard.buttons.template')
name = 'volume-high'
local widget = template(name)
-- ------------------------------------------------- --
local mute_toggle = function()
    awful.spawn.easy_async_with_shell(
        [[pulsemixer --get-mute]],
        function(stdout)
            local status = string.match(stdout, '%d')
            if status == '1' then
                awful.spawn('pulsemixer --unmute')

                name = 'volume-high'
                widget = template(name)

                widget.bg = beautiful.accent
            elseif status == '0' then
                awful.spawn('pulsemixer --m')
                name = 'volume-mute'
                widget = template(name)

                widget.bg = beautiful.bg_focus
            end
        end
    )
end
-- ------------------------------------------------- --
widget:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                mute_toggle()
            end
        )
    )
)
-- ------------------------------------------------- --
return widget
