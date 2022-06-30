--  _____                            __
-- |     |_.---.-.--.--.-----.--.--.|  |_
-- |       |  _  |  |  |  _  |  |  ||   _|
-- |_______|___._|___  |_____|_____||____|
--               |_____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --

local layoutmap = {
    {
        "Right",
        function(c)
            awful.tag.incmwfact(0.05)
        end,
        "Increase Master Column Width"
    },
    -- ------------------------------------------------- --
    {
        "Left",
        function(c)
            awful.tag.incmwfact(-0.05)
        end,
        "Decrease Master Client Width"
    },
    -- ------------------------------------------------- --
    {
        "Up",
        function(c)
            awful.tag.incnmaster(1, nil, true)
        end,
        "Increase Number of Master Cluents"
    },
    -- ------------------------------------------------- --
    {
        "Down",
        function(c)
            awful.tag.incnmaster(-1, nil, true)
        end,
        "Decrease Number of Master Cluents"
    },
    -- ------------------------------------------------- --
    {
        "h",
        function(c)
            awful.tag.incncol(1, nil, true)
        end,
        "Increase Number of Columns"
    },
    -- ------------------------------------------------- --
    {
        "l",
        function(c)
            awful.tag.incncol(-1, nil, true)
        end,
        "Decrease Number of Columns"
    },
    -- ------------------------------------------------- --
    {"separator", " "}
}

return layoutmap
