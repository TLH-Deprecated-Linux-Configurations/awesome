--  _______         __                  __   __
-- |   _   |.-----.|__|.--------.---.-.|  |_|__|.-----.-----.-----.
-- |       ||     ||  ||        |  _  ||   _|  ||  _  |     |__ --|
-- |___|___||__|__||__||__|__|__|___._||____|__||_____|__|__|_____|

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Animate any lua object over a period of time
--    animate(2, example, { width=200, height=200 }, "outCubic")

local gears = require("gears")
local hardware = require("module.hardware.hardware-check")
local tween = require("module.interface.animations.tween")
require("module.interface.animations.awestore")
require("module.interface.animations.rubato")
-- we refresh at display frequency or 24 the lowest one frequency (thus the highest delay)
local freq = math.max(1 / 24, 1 / hardware.getDisplayFrequency())
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function createAnimObject(duration, subject, target, easing, end_callback, delay, widget, tween_callback)
    assert(type(duration) == "number", "The duration should be specified in seconds")
    assert(duration >= 0, "your duration can't be lower than 0 seconds")
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
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
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    widget = widget and widget or subject
    -- check if animation is running
    if widget.anim then
        widget:emit_signal("interrupt", widget)
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- create timer at display freq
    widget.timer = gears.timer({timeout = freq})
    -- create self-destructing animation-stop callback function
    widget.cback = function(callback_widget)
        if callback_widget.timer and callback_widget.timer.started then
            callback_widget.timer:stop()
        end
        callback_widget:disconnect_signal("interrupt", callback_widget.cback)
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- create tween
    local twob = tween.new(duration, subject, target, easing)
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
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
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- start animation
    widget:connect_signal("interrupt", widget.cback)
    widget.anim = true
    if delay ~= nil then
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
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
-- ########################################################################
-- ########################################################################
-- ########################################################################
return {
    createAnimObject = createAnimObject
}
