--  _______ __
-- |     __|  |.-----.-----.-----.--.--.
-- |__     |  ||  _  |  _  |  _  |  |  |
-- |_______|__||_____|   __|   __|___  |
--                   |__|  |__|  |_____|
--  _______
-- |    ___|.-----.----.--.--.-----.
-- |    ___||  _  |  __|  |  |__ --|
-- |___|    |_____|____|_____|_____|
-- ------------------------------------------------- --
local _M = function(c)
    c:activate {
        context = 'mouse_enter',
        -- all the magic is right here, this makes it tolerable to use.
        --Set it to true and begin the hair pulling, but left false and focus following the mouse is actually really good
        --
        raise = false
    }
end

return _M
