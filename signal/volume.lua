--  ___ ___         __
-- |   |   |.-----.|  |.--.--.--------.-----.
-- |   |   ||  _  ||  ||  |  |        |  -__|
--  \_____/ |_____||__||_____|__|__|__|_____|
-- ------------------------------------------------- --
-- Provides:
-- signal::volume
--      percentage (integer)
--      muted (boolean)
local awful = require("awful")

-- ------------------------------------------------- --
local update_mute = function()
    awful.spawn.easy_async_with_shell(
        "pamixer --get-mute",
        function(stdout)
            if stdout ~= nil then
                local status = string.match(stdout, "%a+")
                if stdout == "true" then
                    awesome.emit_signal("signal::volume:mute")
                elseif status == "false" then
                    awesome.emit_signal("signal::volume:unmute")
                end
            end
        end
    )
end
-- ------------------------------------------------- --
local update_volume = function()
    awful.spawn.easy_async_with_shell(
        "pamixer --get-volume",
        function(stdout)
            if stdout ~= nil then
                local volume = tonumber(stdout)
                awesome.emit_signal("signal::volume", volume)

                update_mute()
            end
        end
    )
end
update_volume()

awesome.connect_signal(
    "signal::volume:update",
    function(percentage)
        if percentage ~= nil then
            update_volume()
            collectgarbage("collect")
        end
    end
)
