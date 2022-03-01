--  _______              __
-- |     __|.---.-.----.|  |--.---.-.-----.-----.
-- |    |  ||  _  |   _||  _  |  _  |  _  |  -__|
-- |_______||___._|__|  |_____|___._|___  |_____|
--                                  |_____|
--  ______         __ __              __
-- |      |.-----.|  |  |.-----.----.|  |_.-----.----.
-- |   ---||  _  ||  |  ||  -__|  __||   _|  _  |   _|
-- |______||_____||__|__||_____|____||____|_____|__|
-- ------------------------------------------------- --
--  this runs the garbage collector globally, so no need for tacking on the
--  collectgrabage function at the end of every watch function. Currently
--  set with settings that inhibit my laptop the least.
-- ------------------------------------------------- --
local gears = require("gears")
-- Run garbage collector regularly to prevent memory leaks
local _M = function()
    gears.timer {
        timeout = 30,
        autostart = true,
        callback = function()
            collectgarbage()
            collectgarbage("collect")
            collectgarbage("setstepmul", 400)

            collectgarbage("setpause", 160)
        end
    }
end
return _M

-- Alternative Values
-- collectgarbage("setpause", 110)
-- collectgarbage("setstepmul", 1000)
