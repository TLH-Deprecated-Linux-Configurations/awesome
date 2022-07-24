--  ______ __ __               __
-- |      |  |__|.-----.-----.|  |_
-- |   ---|  |  ||  -__|     ||   _|
-- |______|__|__||_____|__|__||____|
--  ______         __   __
-- |   __ \.--.--.|  |_|  |_.-----.-----.-----.
-- |   __ <|  |  ||   _|   _|  _  |     |__ --|
-- |______/|_____||____|____|_____|__|__|_____|
-- ------------------------------------------------- --
-- ------------------- Libraries ------------------- --
local awful = require('awful')
local modkey = require('configuration.root.keys.mod').modKey
-- ------------------------------------------------- --
-- ------------------- Assignment ------------------ --
local clientbuttons =
    awful.util.table.join(
    -- ------------------------------------------------- --
    awful.button(
        {},
        1,
        function(c)
            c:emit_signal('request::activate', 'mouse_click', {raise = true})
        end
    ),
    -- ------------------------------------------------- --
    awful.button(
        {modkey},
        1,
        function(c)
            c:emit_signal('request::activate', 'mouse_click', {raise = true})
            awful.mouse.client.move(c)
        end
    ),
    -- ------------------------------------------------- --
    awful.button(
        {modkey},
        3,
        function(c)
            c:emit_signal('request::activate', 'mouse_click', {raise = true})
            awful.mouse.client.resize(c)
        end
    ),
    -- ------------------------------------------------- --
    -- Deliberately Not the Scroll Wheel
    awful.button(
        {modkey},
        8,
        function()
            awful.layout.inc(1)
        end
    ),
    -- ------------------------------------------------- --
    awful.button(
        {modkey},
        9,
        function()
            awful.layout.inc(-1)
        end
    )
)

return clientbuttons
