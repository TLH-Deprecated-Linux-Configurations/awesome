--  ______        __         __     __
-- |   __ \.----.|__|.-----.|  |--.|  |_.-----.-----.-----.-----.
-- |   __ <|   _||  ||  _  ||     ||   _|     |  -__|__ --|__ --|
-- |______/|__|  |__||___  ||__|__||____|__|__|_____|_____|_____|
--                   |_____|
-- ------------------------------------------------- --
local awful = require("awful")

local percentage_old = 100
-- Subscribe to backlight changes
-- Requires inotify-tools
local brightness_subscribe_script =
    [[

   while (inotifywait -e modify /sys/class/backlight/?**/brightness -qq) do echo; done
]]

local brightness_script = [[

   light -G
]]

local brightness_max = [[

   light -M 
]]

local emit_brightness_info = function()
    awful.spawn.with_line_callback(
        brightness_script,
        {
            stdout = function(value)
                awful.spawn.with_line_callback(
                    brightness_max,
                    {
                        function(max)
                            local percentage = tonumber(value) / tonumber(max) * 100
                            -- if percentage ~= percentage_old then
                            awesome.emit_signal("signal::brightness", percentage)
                            -- percentage_old = percentage
                            -- end
                        end
                    }
                )
            end
        }
    )
end

-- Run once to initialize widgets
emit_brightness_info()

-- Kill old inotifywait process
awful.spawn.easy_async_with_shell(
    -- [[ps x | grep "inotifywait -e modify /sys/class/backlight" | grep -v grep | awk \'{print $1}\' | xargs kill]],
    function()
        -- Update brightness status with each line printed
        awful.spawn.with_line_callback(
            brightness_subscribe_script,
            {
                stdout = function()
                    emit_brightness_info()
                end
            },
            collectgarbage("collect")
        )
    end
)
