--  _______              __                           ______         __ __              __   __
-- |     __|.---.-.----.|  |--.---.-.-----.-----.    |      |.-----.|  |  |.-----.----.|  |_|__|.-----.-----.
-- |    |  ||  _  |   _||  _  |  _  |  _  |  -__|    |   ---||  _  ||  |  ||  -__|  __||   _|  ||  _  |     |
-- |_______||___._|__|  |_____|___._|___  |_____|    |______||_____||__|__||_____|____||____|__||_____|__|__|
--                                  |_____|

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
--  this runs the garbage collector globally, so no need for tacking on the
--  collectgrabage function at the end of every watch function. Currently
--  set with settings that inhibit my laptop the least.
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local gears = require('gears')
-- Run garbage collector regularly to prevent memory leaks
local _M = function()
    gears.timer {
        timeout = 30,
        autostart = true,
        callback = function()
            collectgarbage()
            collectgarbage('collect')
            collectgarbage('setstepmul', 400)

            collectgarbage('setpause', 110)
        end
    }
end
return _M
