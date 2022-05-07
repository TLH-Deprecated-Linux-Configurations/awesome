--  _____               __     __
-- |     \.-----.--.--.|  |--.|  |.-----.
-- |  --  |  _  |  |  ||  _  ||  ||  -__|
-- |_____/|_____|_____||_____||__||_____|

--  ______                __
-- |   __ \.-----.----.--|  |.-----.----.
-- |   __ <|  _  |   _|  _  ||  -__|   _|
-- |______/|_____|__| |_____||_____|__|
-- ------------------------------------------------- --
client.connect_signal(
    "request::titlebars",
    function(c)
        -- buttons for the titlebar
        local thickness = dpi(1)
        local edge_color = "#2f303d66"

        beautiful.border_normal = edge_color
        beautiful.border_focus = edge_color

        awful.titlebar(c, {position = "right", size = thickness})
        awful.titlebar(c, {position = "left", size = thickness})
        awful.titlebar(c, {position = "bottom", size = thickness})
        awful.titlebar(c, {position = "top", size = thickness})
    end
)
