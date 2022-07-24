--  ______               __
-- |   __ \.-----.-----.|__|.-----.-----.
-- |      <|  -__|__ --||  ||-- __|  -__|
-- |___|__||_____|_____||__||_____|_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
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
            if capi.client.focus.height > 10 then
                capi.client.focus:relative_move(0, 0, 0, dpi(-10))
            end
        end,
        'Decrease floating size by 10'
    },
    -- ------------------------------------------------- --
    {
        'Down',
        function()
            if capi.client.focus.height > 10 then
                capi.client.focus:relative_move(0, dpi(-10), 0, 0)
            end
        end,
        'Decrease Size Vertically by 10'
    },
    -- ------------------------------------------------- --
    {
        'Left',
        function()
            if capi.client.focus.width > 10 then
                capi.client.focus:relative_move(0, 0, dpi(-10), 0)
            end
        end,
        'Decrease Size Horizontally by 10'
    },
    -- ------------------------------------------------- --
    {
        'Right',
        function()
            if capi.client.focus.width > 10 then
                capi.client.focus:relative_move(dpi(-10), 0, 0, 0)
            end
        end,
        'Decrease Size Horizontally 10'
    },
    {'separator', ' '}
}

return resizemap
