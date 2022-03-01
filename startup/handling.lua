--  _______ __               __
-- |     __|  |_.---.-.----.|  |_.--.--.-----.
-- |__     |   _|  _  |   _||   _|  |  |  _  |
-- |_______|____|___._|__|  |____|_____|   __|
--                                     |__|
--  _______
-- |    ___|.----.----.-----.----.
-- |    ___||   _|   _|  _  |   _|
-- |_______||__| |__| |_____|__|

--  _______                 __ __ __
-- |   |   |.---.-.-----.--|  |  |__|.-----.-----.
-- |       ||  _  |     |  _  |  |  ||     |  _  |
-- |___|___||___._|__|__|_____|__|__||__|__|___  |
--                                         |_____|
-- ------------------------------------------------- --
local naughty = require("naughty")

if awesome.startup_errors then
    naughty.notify(
        {
            preset = naughty.config.presets.critical,
            title = "Oops, there were errors during startup!",
            text = awesome.startup_errors
        }
    )
end
-- ------------------------------------------------- --
-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal(
        "debug::error",
        function(err)
            -- ------------------------------------------------- --
            -- Make sure we don't go into an endless error loop
            if in_error then
                return
            end
            in_error = true

            naughty.notify(
                {
                    preset = naughty.config.presets.critical,
                    title = "Oops, an error happened!",
                    text = tostring(err)
                }
            )
            in_error = false
        end
    )
end
-- ------------------------------------------------- --
