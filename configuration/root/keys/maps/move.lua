--  _______
-- |   |   |.-----.--.--.-----.
-- |       ||  _  |  |  |  -__|
-- |__|_|__||_____|\___/|_____|

-- ------------------------------------------------- --
-- NOTE: this keymap moves clients
-- ------------------------------------------------- --
local capi = {
    screen = screen,
    client = client
}

local movemap = {
    -- ------------------------------------------------- --
    {
        'Up',
        function(c)
            capi.client.focus:relative_move(0, dpi(-10), 0, 0)
        end,
        'Move Client Up'
    },
    -- ------------------------------------------------- --
    {
        'Down',
        function(c)
            capi.client.focus:relative_move(0, dpi(10), 0, 0)
        end,
        'Move Client Down'
    },
    -- ------------------------------------------------- --
    {
        'Left',
        function(c)
            capi.client.focus:relative_move(dpi(-10), 0, 0, 0)
        end,
        'Move Client Left'
    },
    -- ------------------------------------------------- --
    {
        'Right',
        function(c)
            capi.client.focus:relative_move(dpi(10), 0, 0, 0)
        end,
        'Move Client Right'
    },
    -- ------------------------------------------------- --
    {'separator', ' '}
}

return movemap
