--  _______ __               __   __
-- |    ___|  |.-----.---.-.|  |_|__|.-----.-----.
-- |    ___|  ||  _  |  _  ||   _|  ||     |  _  |
-- |___|   |__||_____|___._||____|__||__|__|___  |
--                                         |_____|
--  ______                               __   __
-- |   __ \.----.-----.-----.-----.----.|  |_|__|.-----.-----.
-- |    __/|   _|  _  |  _  |  -__|   _||   _|  ||  -__|__ --|
-- |___|   |__| |_____|   __|_____|__|  |____|__||_____|_____|
--                    |__|
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
