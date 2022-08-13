--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|
--  _______
-- |   |   |.-----.--.--.-----.-----.
-- |       ||  _  |  |  |__ --|  -__|
-- |__|_|__||_____|_____|_____|_____|
-- .-----.-----.
-- |  _  |     |
-- |_____|__|__|
--  _______                                  __
-- |    ___|.-----.----.--.--.-----.-----.--|  |
-- |    ___||  _  |  __|  |  |__ --|  -__|  _  |
-- |___|    |_____|____|_____|_____|_____|_____|

--  ______ __ __               __
-- |      |  |__|.-----.-----.|  |_
-- |   ---|  |  ||  -__|     ||   _|
-- |______|__|__||_____|__|__||____|

-- ------------------------------------------------- --
-- NOTE: eliminates the three other alternatives I
-- have used to do this. More elegant and not specific
-- to floating
-- ------------------------------------------------- --
-- Always place clients on screen.
--
local _M = function(c)
    if mouse.object_under_pointer() ~= c then
        callback = function()
            local geometry = c:geometry()
            local x = geometry.x + geometry.width / 2
            local y = geometry.y + geometry.height / 2
            mouse.coords({x = x, y = y}, true)
        end
    end
end

return _M

-- vim: ft=lua:et:sw=4:ts=8:sts=4:tw=80:fdm=marker
