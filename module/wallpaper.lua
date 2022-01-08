--  ________         __ __
-- |  |  |  |.---.-.|  |  |.-----.---.-.-----.-----.----.
-- |  |  |  ||  _  ||  |  ||  _  |  _  |  _  |  -__|   _|
-- |________||___._||__|__||   __|___._|   __|_____|__|
--                         |__|        |__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- essentially just the default wallpaper setting function, explained
-- well by the original comments left in place.
local wallpaper = {}
screen.connect_signal(
    'request::wallpaper',
    function(s)
        -- If wallpaper is a function, call it with the screen
        --
        if beautiful.wallpaper then
            if type(beautiful.wallpaper) == 'string' then
                -- Check if beautiful.wallpaper is color/image
                --
                if beautiful.wallpaper:sub(1, #'#') == '#' then
                    -- If beautiful.wallpaper is color
                    --
                    gears.wallpaper.set(beautiful.wallpaper)
                elseif beautiful.wallpaper:sub(1, #'/') == '/' then
                    -- If beautiful.wallpaper is path/image
                    --
                    gears.wallpaper.maximized(beautiful.wallpaper, s)
                end
            else
                beautiful.wallpaper(s)
            end
        end
    end
)
return wallpaper
