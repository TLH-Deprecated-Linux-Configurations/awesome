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
-- NOTE: The focus follows the cursor's movement, like
-- any tiling window manager by default. Critically, in
-- this particular case, this will not raise the windows
-- preventing the greatest annoyances caused by this
-- means of switching focus.
-- ------------------------------------------------- --
local _M = function(c)
    c:activate {
        context = 'mouse_enter',
        raise = false
    }
end

return _M
