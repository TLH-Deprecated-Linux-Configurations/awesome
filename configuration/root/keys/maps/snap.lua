--  _______
-- |     __|.-----.---.-.-----.
-- |__     ||     |  _  |  _  |
-- |_______||__|__|___._|   __|
--                      |__|
-- ------------------------------------------------- --
-- NOTE: this keymap enables the snapping of clients to
-- corners or sides of a window
-- ------------------------------------------------- --
local capi = {
    screen = screen,
    client = client
}

-- ------------------------------------------------- --
local snapmap = {
    -- ------------------------------------------------- --
    {'separator', 'Snapping by Side'},
    -- ------------------------------------------------- --
    {
        'Down',
        function(c)
            snap_edge(capi.client.focus, 'bottom')
        end,
        'Snap to Bottom'
    },
    -- ------------------------------------------------- --
    {
        'Left',
        function(c)
            snap_edge(capi.client.focus, 'left')
        end,
        'Snap to Left'
    },
    -- ------------------------------------------------- --
    {
        'Right',
        function(c)
            snap_edge(capi.client.focus, 'right')
        end,
        'Snap to Right'
    },
    -- ------------------------------------------------- --
    {
        'Up',
        function(c)
            snap_edge(capi.client.focus, 'top')
        end,
        'Snap to Top'
    },
    -- ------------------------------------------------- --
    {'separator', 'Corner Snapping'},
    -- ------------------------------------------------- --
    {
        'j',
        function(c)
            snap_edge(capi.client.focus, 'bottomright')
        end,
        'Snap to Bottom Right'
    },
    -- ------------------------------------------------- --
    {
        'k',
        function(c)
            snap_edge(capi.client.focus, 'bottomleft')
        end,
        'Snap to Bottom Left'
    },
    -- ------------------------------------------------- --
    {
        'l',
        function(c)
            snap_edge(capi.client.focus, 'topright')
        end,
        'Snap to Top Right'
    },
    -- ------------------------------------------------- --
    {
        'h',
        function(c)
            snap_edge(capi.client.focus, 'topleft')
        end,
        'Snap to Top Left'
    },
    {'separator', ' '}
}

return snapmap

-- -- Snap to edge/corner - Use numpad
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[1], function (c) snap_edge(c, 'bottomleft') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[2], function (c) snap_edge(c, 'bottom') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[3], function (c) snap_edge(c, 'bottomright') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[4], function (c) snap_edge(c, 'left') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[5], function (c) snap_edge(c, 'center') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[6], function (c) snap_edge(c, 'right') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[7], function (c) snap_edge(c, 'topleft') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[8], function (c) snap_edge(c, 'top') end),
-- awful.key({ modkey, "Shift" }, "#" .. numpad_map[9], function (c) snap_edge(c, 'topright') end),
