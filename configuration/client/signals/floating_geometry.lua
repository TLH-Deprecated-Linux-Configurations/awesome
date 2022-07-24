--  _______ __               __   __
-- |    ___|  |.-----.---.-.|  |_|__|.-----.-----.
-- |    ___|  ||  _  |  _  ||   _|  ||     |  _  |
-- |___|   |__||_____|___._||____|__||__|__|___  |
--                                         |_____|
--  _______                              __
-- |     __|.-----.-----.--------.-----.|  |_.----.--.--.
-- |    |  ||  -__|  _  |        |  -__||   _|   _|  |  |
-- |_______||_____|_____|__|__|__|_____||____|__| |___  |
--                                                |_____|
-- ------------------------------------------------- --
local _M = function(t)
    for c in ipairs(t:clients()) do
        if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
            local cgeo = awful.client.property.get(c, 'floating_geometry')
            if cgeo then
                c:geometry(awful.client.property.get(c, 'floating_geometry'))
            end
        end
    end
end

return _M
