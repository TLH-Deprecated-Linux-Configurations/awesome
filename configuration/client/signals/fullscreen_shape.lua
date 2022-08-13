--   ___         __ __
-- .'  _|.--.--.|  |  |.-----.----.----.-----.-----.-----.
-- |   _||  |  ||  |  ||__ --|  __|   _|  -__|  -__|     |
-- |__|  |_____||__|__||_____|____|__| |_____|_____|__|__|

--         __
-- .-----.|  |--.---.-.-----.-----.
-- |__ --||     |  _  |  _  |  -__|
-- |_____||__|__|___._|   __|_____|
--                    |__|
-- ------------------------------------------------- --
-- NOTE: inspired by the work of Jeff M. Hubbard
-- jeffmhubbard@gmail.com&gt;
--
-- NOTE: Provides the client with its shape, which if
-- fullscreen or maximized, does not need to round the
-- corners for obvious reasons
-- ------------------------------------------------- --
----

local _M = function(c)
    if c.maximized or c.fullscreen then
        c.shape = beautiful.client_shape_rectangle
    else
        c.shape = beautiful.client_shape_rounded_xl
    end
end

return _M
