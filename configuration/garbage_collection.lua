--  _______              __                           ______         __ __              __   __
-- |     __|.---.-.----.|  |--.---.-.-----.-----.    |      |.-----.|  |  |.-----.----.|  |_|__|.-----.-----.
-- |    |  ||  _  |   _||  _  |  _  |  _  |  -__|    |   ---||  _  ||  |  ||  -__|  __||   _|  ||  _  |     |
-- |_______||___._|__|  |_____|___._|___  |_____|    |______||_____||__|__||_____|____||____|__||_____|__|__|
--                                  |_____|

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- No this doesn't contain the whole of AwesomeWM in one file, its for the
-- least annoying feature of Lua, a garbage collector that runs to save
-- memory (at the expense of compute power).Which is run on a timer here
--

local gears = require('gears')
-- Run garbage collector regularly to prevent memory leaks
--
local _M = function()
    collectgarbage('setpause', 110)
    collectgarbage('setstepmul', 1000)
    gears.timer {
        timeout = 30,
        autostart = true,
        callback = function()
            collectgarbage('collect')

        end
    }
end
return _M
