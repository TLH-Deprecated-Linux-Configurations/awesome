local gears = require("gears")
-- Run garbage collector regularly to prevent memory leaks
gears.timer {
    timeout = 30,
    autostart = true,
    callback = function()
        collectgarbage()
        collectgarbage("setpause", 100)
        collectgarbage("setstepmul", 400)
    end
}
