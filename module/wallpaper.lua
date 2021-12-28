screen.connect_signal(
    'request::wallpaper',
    function(s)
        -- If wallpaper is a function, call it with the screen
        if beautiful.wallpaper then
            if type(beautiful.wallpaper) == 'string' then
                -- Check if beautiful.wallpaper is color/image
                if beautiful.wallpaper:sub(1, #'#') == '#' then
                    -- If beautiful.wallpaper is color
                    gears.wallpaper.set(beautiful.wallpaper)
                elseif beautiful.wallpaper:sub(1, #'/') == '/' then
                    -- If beautiful.wallpaper is path/image
                    gears.wallpaper.maximized(beautiful.wallpaper, s)
                end
            else
                beautiful.wallpaper(s)
            end
        end
    end
)
