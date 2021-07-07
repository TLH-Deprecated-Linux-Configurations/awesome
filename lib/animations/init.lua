---------------------------------------------------------------------------
-- Animate any lua object over a period of time
--
-- This api is generally designed for wiboxes, but it can be used for any lua table
--
-- In this example we will animate the wibox over 2 seconds, changing its width and height
--    local example = wibox {
--        ontop = true,
--        screen = screen,
--        width = 100,
--        height = 100,
--        x = 0,
--        y = 0,
--    }
--    -- usually you start animation when clicking on a button
--    -- In this example we use out cubic (see the tweening diagram below)
--    animate(2, example, { width=200, height=200 }, "outCubic")
--
-- Useful when you want to override user settings.
-- Such as in the settings app.
--
-- The possible tween values plotted:
--
-- ![Tween values plotted](../images/animations_tween.png)
--
-- @author Tom Meyers
-- @copyright 2020 Tom Meyers
-- @tdemod lib.animations
---------------------------------------------------------------------------

local gears = require("gears")
local hardware = require("module.hardware-check")
local tween = require("lib.animations.tween")

-- we refresh at display frequency or 24 the lowest one frequency (thus the highest delay)
local freq = math.max(1 / 24, 1 / hardware.getDisplayFrequency())

--- Create an animation out of a lua table
-- @tparam number duration How long should the animation take
-- @tparam wibox subject The subject to animate
-- @tparam table target A table of properties of the subject to tween (these will be animated)
-- @tparam string easing The easing function to use
-- @tparam[opt] function end_callback This function will be called when the animation finished
-- @tparam[opt] number delay How long to wait until we start the animation
-- @tparam[opt] wibox widget Alternative widget we use to hook animation properties on
-- @tparam[opt] function tween_callback A callback that happens on every animation trigger (every frame)
-- @staticfct createAnimObject
-- @usage -- This will create and start the animation that tweens the y property to 100 over 3 seconds using the outCubic calculation
-- lib.animations.createAnimObject(3, object, {y = 100}, "outCubic", function()
--    print("Done animating")
--  end)
local function createAnimObject(duration, subject, target, easing, end_callback, delay, widget, tween_callback)
    assert(type(duration) == "number", "The duration should be specified in seconds")
    assert(duration >= 0, "your duration can't be lower than 0 seconds")

    -- if the duration is 0 then we should 'teleport' to the end state
    if duration == 0 then
        print("Animation is zero")
        -- iterate over all key value pairs and assign them to the subject
        for key, value in pairs(target) do
            subject[key] = value
        end
        if end_callback then
            end_callback()
        end
        return
    end

    widget = widget and widget or subject
    -- check if animation is running
    if widget.anim then
        widget:emit_signal("interrupt", widget)
    end
    -- create timer at display freq
    widget.timer = gears.timer({timeout = freq})
    -- create self-destructing animation-stop callback function
    widget.cback = function(callback_widget)
        if callback_widget.timer and callback_widget.timer.started then
            callback_widget.timer:stop()
        end
        callback_widget:disconnect_signal("interrupt", callback_widget.cback)
    end
    -- create tween
    local twob = tween.new(duration, subject, target, easing)
    -- create timeout signal
    widget.timer:connect_signal(
        "timeout",
        function()
            local complete = twob:update(freq)
            if tween_callback == nil then
                widget:emit_signal("widget::redraw_needed")
            else
                tween_callback()
            end
            if complete then
                widget.timer:stop()
                widget.cback(widget)
                widget.anim = false
                if end_callback then
                    end_callback()
                end
            end
        end
    )
    -- start animation
    widget:connect_signal("interrupt", widget.cback)
    widget.anim = true
    if delay ~= nil then
        gears.timer {
            autostart = true,
            single_shot = true,
            timeout = delay,
            callback = function()
                widget.timer:start()
            end
        }
    else
        widget.timer:start()
    end
end

return {
    createAnimObject = createAnimObject
}
