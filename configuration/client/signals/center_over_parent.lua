--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|

--  _______
-- |       |.--.--.-----.----.
-- |   -   ||  |  |  -__|   _|
-- |_______| \___/|_____|__|

--  ______                          __
-- |   __ \.---.-.----.-----.-----.|  |_
-- |    __/|  _  |   _|  -__|     ||   _|
-- |___|   |___._|__| |_____|__|__||____|

-- ------------------------------------------------- --
-- NOTE: inspired by the work of Jeff M. Hubbard
-- jeffmhubbard@gmail.com
-- ------------------------------------------------- --
-- NOTE: centers popup windows over the center of their parent. Necessary for GIMP
-- ------------------------------------------------- --
--- Center over parent signal
----
local _M = function(c)
    if c.transient_for and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.centered(
            c,
            {
                parent = c.transient_for,
                honor_workarea = true,
                honor_padding = true
            }
        )
        awful.placement.no_offscreen(c)
    else
        awful.placement.no_offscreen(c)
    end
end

return _M
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
