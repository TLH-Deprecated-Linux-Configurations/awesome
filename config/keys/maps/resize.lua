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
    {"separator", "Increase Client Size"},
    {
        "h",
        function(c)
            capi.client.focus:relative_move(0, dpi(10), 0, dpi(0))
        end,
        "Increase Size Vertically by 10"
    },
    -- ------------------------------------------------- --
    {
        "l",
        function(c)
            capi.client.focus:relative_move(0, 0, 0, dpi(10))
        end,
        "Increase floating size by 10 vertically"
    },
    -- ------------------------------------------------- --
    {
        "j",
        function(c)
            capi.client.focus:relative_move(dpi(10), 0, dpi(), 0)
        end,
        "Increase Size Horizontally by 10"
    },
    -- ------------------------------------------------- --
    {
        "k",
        function(c)
            capi.client.focus:relative_move(0, 0, dpi(10), 0)
        end,
        "Increase Size Horizontally by 10"
    },
    -- ------------------------------------------------- --
    {"separator", "Decrease Client Size"},
    -- ------------------------------------------------- --
    {
        "Up",
        function(c)
            if capi.client.focus.height > 10 then
                capi.client.focus:relative_move(0, 0, 0, dpi(-10))
            end
        end,
        "Decrease floating size by 10"
    },
    -- ------------------------------------------------- --
    {
        "Down",
        function(c)
            capi.client.focus:relative_move(0, 0, 0, dpi(-10))
            if capi.client.focus.height > 10 then
                capi.client.focus:relative_move(0, dpi(10), 0, 0)
            end
        end,
        "Decrease Size Vertically by 10"
    },
    -- ------------------------------------------------- --
    {
        "Left",
        function(c)
            if capi.client.focus.width > 10 then
                capi.client.focus:relative_move(0, 0, dpi(-10), 0)
            end
        end,
        "Decrease Size Horizontally by 10"
    },
    -- ------------------------------------------------- --
    {
        "Right",
        function(c)
            capi.client.focus:relative_move(0, 0, dpi(-10), 0)
            if capi.client.focus.width > 10 then
                capi.client.focus:relative_move(dpi(10), 0, 0, 0)
            end
        end,
        "Decrease Size Horizontally 10"
    },
    {"separator", " "}
}

return resizemap
