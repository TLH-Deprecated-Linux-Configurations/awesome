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
local update_mute = function(volume)
    awful.spawn.easy_async_with_shell(
        [["pamixer --get-mute"]],
        function(stdout)
            if stdout ~= nil then
                local status = string.match(stdout, "%a+")
                if stdout == "true" then
                    awesome.emit_signal("signal::volume", volume, 1)
                elseif status == "false" then
                    awesome.emit_signal("signal::volume", volume, 0)
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
                awesome.emit_signal("signal::volume:update", volume)
                update_mute(volume)
            end
        end
    )
end
update_volume()

-- ------------------------------------------------- --
local volume_script =
    [[
    bash -c "
    LANG=C pactl subscribe 2> /dev/null | grep --line-buffered \"Event 'change' on sink #\"
    "]]

-- Kill old pactl subscribe processes
awful.spawn.easy_async(
    {
        "pkill",
        "--full",
        "--uid",
        os.getenv("USER"),
        "^pactl subscribe"
    },
    function()
        awful.spawn.with_line_callback(
            volume_script,
            {
                stdout = function(line)
                    update_volume()
                end
            }
        )
    end
)

awesome.connect_signal(
    "signal::volume:update",
    function(percentage)
        local volume = tonumber(percentage)
        awesome.emit_signal("signal::volume", volume, 0)
    end
)
