--  _______ __                     __
-- |     __|__|.-----.-----.---.-.|  |.-----.
-- |__     |  ||  _  |     |  _  ||  ||__ --|
-- |_______|__||___  |__|__|___._||__||_____|
--             |_____|

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local update_client = function(c)
    -- Set client's shape based on its tag's layout and status (floating, maximized, etc.)
    --
    if c.fullscreen then
        c.shape = beautiful.client_shape_rectangle
    else
        c.shape = beautiful.client_shape_rounded
    end
end
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Signal function to execute when a new client appears.
client.connect_signal(
    'manage',
    function(c)
        -- Focus, raise and activate
        --
        c:emit_signal('request::activate', 'mouse_enter')
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        -- Set the windows at the slave,
        -- i.e. put it at the end of others
        --
        if not awesome.startup then
            awful.client.setslave(c)
        end
        -- ------------------------------------------------- --
        if awesome.startup then
            if not c.size_hints.user_position and not c.size_hints.program_position then
                -- Prevent clients from being unreachable after screen count changes.
                --
                awful.placement.no_offscreen(c)
                awful.placement.no_overlap(c)
            end
        end
        -- ------------------------------------------------- --
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_offscreen(
                c,
                {
                    honor_workarea = true,
                    honor_padding = true
                }
            )
        end
        -- ------------------------------------------------- --
        if c.transient_for then
            awful.placement.centered(c, {parent = c.transient_for})
            awful.placement.no_offscreen(c)
        end
        -- Update client shape
        update_client(c)
    end
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Enable sloppy focus, so that focus follows mouse then raises it.
-- modified using the pull request for awesome by blue-eyed
-- https://github.com/awesomeWM/awesome/pull/183
local sloppyfocus_last = {c = nil}
client.connect_signal(
    'mouse::enter',
    function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier and awful.client.focus.filter(c) then
            -- Skip focusing the client if the mouse wasn't moved.
            if c ~= sloppyfocus_last.c then
                client.focus = c
                sloppyfocus_last.c = c
            end
        end
    end
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- manipulate client upon focus
-- raise is set to false due to the specific firefox extensions I use not
--  cooperaitng well with such a setting
client.connect_signal(
    'focus',
    function(c)
        c.border_color = beautiful.border_focus
        c.raise = false
    end
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
client.connect_signal(
    'unfocus',
    function(c)
        c.border_color = beautiful.border_normal
    end
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Manipulate client shape on fullscreen/non-fullscreen
client.connect_signal(
    'property::fullscreen',
    function(c)
        if c.fullscreen then
            c.shape = beautiful.client_shape_rectangle
        else
            update_client(c)
        end
    end
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Manipulate client shape on floating
client.connect_signal(
    'property::floating',
    function(c)
        if c.floating then
            c.shape = beautiful.client_shape_rounded
            awful.placement.no_offscreen(c)
            awful.placement.centered(c)
        end
    end
)
