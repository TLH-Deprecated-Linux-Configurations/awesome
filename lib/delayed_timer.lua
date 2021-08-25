local gears = require('gears')

--- Async callback trigger, that starts after x seconds
-- @tparam number timeout How long to wait until we call the callback again
-- @tparam function callback The callback function to call when the timeout happened
-- @tparam number delay How long to wait until we start the async timer
-- @tparam[opt] bool only_delay By default we call the callback on creation, when true we don't call the callback
-- @staticfct delayed-timer
-- @usage -- lib.function.delayed-timer(1, function()
--      print("Callback")
-- end, 10, true)
return function(timeout, callback, delay, only_delay)
    local timer =
        gears.timer {
        timeout = timeout,
        call_now = true,
        callback = callback
    }

    gears.timer {
        timeout = delay,
        autostart = true,
        single_shot = true,
        callback = function()
            timer:start()
        end
    }

    -- run the callback when starting up
    -- this insures generated data
    if not only_delay then
        callback()
    end

    return timer
end
