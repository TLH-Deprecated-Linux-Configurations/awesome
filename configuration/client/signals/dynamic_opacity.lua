--  _____                              __
-- |     \.--.--.-----.---.-.--------.|__|.----.
-- |  --  |  |  |     |  _  |        ||  ||  __|
-- |_____/|___  |__|__|___._|__|__|__||__||____|
--        |_____|
--  _______                    __ __
-- |       |.-----.---.-.----.|__|  |_.--.--.
-- |   -   ||  _  |  _  |  __||  |   _|  |  |
-- |_______||   __|___._|____||__|____|___  |
--          |__|                      |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Doesn't matter if picom-ibhagwan isn't on void and requires building from the source
-- because this can be replicated by awesome itself. No need for wayland and its still
-- compositing, with Lua friend all is possible!
-- ########################################################################
-- ########################################################################
-- ########################################################################
local opacity = _G.conf.vars.dynamic_opacity

local _M = {}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Set opacity of focused client.
--
_M.focus = function(c)
    if c.fullscreen or c.exclude_opacity then
        return
    end
    c.opacity = opacity.focus or 1
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Set opacity of unfocused clients.
--
_M.unfocus = function(c)
    if c.fullscreen or c.exclude_opacity then
        return
    end
    c.opacity = opacity.unfocus or 0.9
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return _M
