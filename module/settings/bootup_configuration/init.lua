--  ______               __
-- |   __ \.-----.-----.|  |_.--.--.-----.
-- |   __ <|  _  |  _  ||   _|  |  |  _  |
-- |______/|_____|_____||____|_____|   __|
--                                 |__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(
    function(s)
        -- If wallpaper is a function, call it with the screen
        if beautiful.wallpaper then
            if type(beautiful.wallpaper) == "string" then
                if beautiful.wallpaper:sub(1, #"#") == "#" then
                    gears.wallpaper.set(beautiful.wallpaper)
                elseif beautiful.wallpaper:sub(1, #"/") == "/" then
                    gears.wallpaper.maximized(beautiful.wallpaper, s)
                    print("Setting wallpaper: " .. beautiful.wallpaper)
                end
            else
                beautiful.wallpaper(s)
            end
        end
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Signal function to execute when a new client appears.
_G.client.connect_signal(
    "manage",
    function(c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        if not _G.awesome.startup then
            awful.client.setslave(c)
        end

        if _G.awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
            awful.screen.preferred(c)
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
            awful.placement.no_overlap(c)
        end
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Enable sloppy focus, so that focus follows mouse.
_G.client.connect_signal(
    "mouse::enter",
    function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = true})
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
_G.client.connect_signal(
    "focus",
    function(c)
        c.border_color = beautiful.border_focus
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
_G.client.connect_signal(
    "unfocus",
    function(c)
        c.border_color = beautiful.border_normal
    end
)

-- ########################################################################
-- ########################################################################
-- ########################################################################

if awesome.startup_errors then
    naughty.notify(
        {
            preset = naughty.config.presets.critical,
            title = "Oops, there were errors during startup!",
            text = awesome.startup_errors
        }
    )
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal(
        "debug::error",
        function(err)
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
