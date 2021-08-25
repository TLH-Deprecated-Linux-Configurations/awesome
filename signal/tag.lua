-- Screen Padding and Tags
screen.connect_signal(
    'request::desktop_decoration',
    function(s)
        -- Screen padding
        screen[s].padding = {left = 0, right = 0, top = 0, bottom = 0}
        -- Each screen has its own tag table.
        awful.tag({'1', '2', '3', '4', '5'}, s, awful.layout.layouts[1])
    end
)
