--  ___ ___ ______ _____  ______
-- |   |   |   __ \     \|   __ \
-- |-     -|      <  --  |   __ <
-- |___|___|___|__|_____/|______/

--  _______ __
-- |_     _|  |--.-----.--------.-----.
--   |   | |     |  -__|        |  -__|
--   |___| |__|__|_____|__|__|__|_____|

-- ------------------------------------------------- --
-- obviously, to actually use this, you would need to make
-- a bunch of adjustments using a search and replace tool.
-- but its here to give you a start and an idea of how to
-- theme this configuration if you choose
-- ------------------------------------------------- --
local xrdb = xresources.get_current_theme()

--  TIP: tailwind shades website is great for finding shades of color, or color space
return {
    -- Colors
    color1 = xrdb.color1,
    color2 = xrdb.color2,
    color3 = xrdb.color3,
    color4 = xrdb.color4,
    color5 = xrdb.color5,
    color6 = xrdb.color6,
    color7 = xrdb.color7,
    color8 = xrdb.color8,
    color9 = xrdb.color9,
    color10 = xrdb.color10,
    color11 = xrdb.color11,
    color12 = xrdb.color12,
    color13 = xrdb.color13,
    color14 = xrdb.color14,
    color15 = xrdb.color15,
    -- ------------------------------------------------- --

    white = xrdb.foreground,
    black = xrdb.background,
    icons = xrdb.foreground,
    alpha = function(color, alpha)
        return color .. alpha
    end
}
