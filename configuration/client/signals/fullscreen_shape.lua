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
-- inspired by the work of Jeff M. Hubbard &lt;jeffmhubbard@gmail.com&gt;
--
-- centers popup windows over the center of their parent. Necessary for GIMP
-- ------------------------------------------------- --
--- Center over parent signal
----

local _M = function(c)
    if c.maximized or c.fullscreen then
        c.shape = beautiful.client_shape_rectangle
    else
        c.shape = beautiful.client_shape_rounded
    end
end

return _M
