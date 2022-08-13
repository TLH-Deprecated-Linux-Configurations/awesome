--  ______               __
-- |   __ \.-----.-----.|__|.-----.-----.
-- |      <|  -__|__ --||  ||-- __|  -__|
-- |___|__||_____|_____||__||_____|_____|
-- ------------------------------------------------- --
-- NOTE: This keymap resies floating clients
-- ------------------------------------------------- --
local capi = {
    screen = screen,
    client = client
}

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local resizemap = {
    -- ------------------------------------------------- --
    {
        'Up',
        function()
            capi.client.focus:relative_move(0, 0, 0, dpi(10))
        end,
        'Increase Size Vertically Upwards by 10'
    },
    -- ------------------------------------------------- --
    {
        'Down',
        function()
            capi.client.focus:relative_move(0, dpi(10), 0, 0)
        end,
        'Increase Size Vertically Downwards by 10'
    },
    -- ------------------------------------------------- --
    {
        'Left',
        function()
            capi.client.focus:relative_move(0, 0, dpi(10), 0)
        end,
        'Increase Size Horizontally Leftwards by 10'
    },
    -- ------------------------------------------------- --
    {
        'Right',
        function()
            capi.client.focus:relative_move(dpi(10), 0, 0, 0)
        end,
        'Increase Size Horizontally Rightwards by 10'
    },
    {'separator', ' '}
}

return resizemap
