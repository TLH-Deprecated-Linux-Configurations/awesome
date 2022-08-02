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
local _M = function(c)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating or c.floating then
        awful.client.property.set(c, "floating_geometry", c:geometry())
    end
    if c.floating then
        c.shape = beautiful.client_shape_rounded
    end
end

return _M
