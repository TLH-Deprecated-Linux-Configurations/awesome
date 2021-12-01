--  ______               __
-- |   __ \.-----.-----.|  |_.--.--.-----.
-- |   __ <|  _  |  _  ||   _|  |  |  _  |
-- |______/|_____|_____||____|_____|   __|
--                                 |__|
-- ########################################################################
-- ########################################################################
-- ########################################################################

local naughty = require("naughty")

-- Load the wallpaper if set it on each screen
--
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
--
_G.client.connect_signal(
    "manage",
    function(c)
        -- Set the windows as the "slave", their word and I agree it is a little tasteless
        --
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
-- Raise causes issues when a normal client is over a maximized client,
-- so it was commented out.
-- Without raise, this is actually a desirable setting even if the
-- configuration is complex, not sure what the dev's were thinking when
-- they included a setting rendering sloppy focus useless...
--
_G.client.connect_signal(
    "mouse::enter",
    function(c)
        c:emit_signal(
            "request::activate",
            "mouse_enter" -- , {raise = true}
        )
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- set the client border for focused client
--
_G.client.connect_signal(
    "focus",
    function(c)
        c.border_color = beautiful.border_focus
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- set the client border color
--
_G.client.connect_signal(
    "unfocus",
    function(c)
        c.border_color = beautiful.border_normal
    end
)

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- startup errors, which there is not way to make the logging information
-- something easily comprehended at a glance due to the underlying program
-- as far as I know, so same goobldygook as always.
--
if awesome.startup_errors then
    naughty.notify(
        {
            preset = naughty.config.presets.critical,
            title = "Oops, there were errors during startup!",
            text = awesome.startup_errors
        }
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Handle runtime errors after startup
--
do
    local in_error = false
    awesome.connect_signal(
        "debug::error",
        function(err)
            -- Make sure we don't go into an endless error loop, they suck
            --
            if in_error then
                return
            end
            in_error = true

            naughty.notify(
                {
                    preset = naughty.config.presets.critical,
                    title = "Well Shucks, I am Broken Again!",
                    text = tostring(err)
                }
            )
            in_error = false
        end
    )
end
