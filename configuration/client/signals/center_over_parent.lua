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
-- inspired by the work of Jeff M. Hubbard &lt;jeffmhubbard@gmail.com&gt;
--
-- centers popup windows over the center of their parent. Necessary for GIMP
-- ------------------------------------------------- --
--- Center over parent signal
----
local _M = function(c)
    if c.transient_for then
        awful.placement.centered(c, {parent = c.transient_for})
        awful.placement.no_offscreen(c)
    end
end

return _M
