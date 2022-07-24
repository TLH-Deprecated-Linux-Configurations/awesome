--  ______               __ __   __
-- |   __ \.-----.-----.|__|  |_|__|.-----.-----.
-- |    __/|  _  |__ --||  |   _|  ||  _  |     |
-- |___|   |_____|_____||__|____|__||_____|__|__|

--                   _______
-- .-----.-----.    |     __|.----.----.-----.-----.-----.
-- |  _  |     |    |__     ||  __|   _|  -__|  -__|     |
-- |_____|__|__|    |_______||____|__| |_____|_____|__|__|
-- ------------------------------------------------- --

local _M = function(c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.no_offscreen(
            c,
            {
                honor_workarea = true,
                honor_padding = true
            }
        )
    else
        awful.client.setslave(c)
        -- awful.placement.centered(c, {parent = c.transient_for})
        awful.placement.no_offscreen(
            c,
            {
                honor_workarea = true,
                honor_padding = true,
                parent = c.transient_for
            }
        )
    end
end

return _M

-- vim: ft=lua:et:sw=4:ts=8:sts=4:tw=80:fdm=marker
