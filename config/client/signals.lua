--  ______ __ __               __
-- |      |  |__|.-----.-----.|  |_
-- |   ---|  |  ||  -__|     ||   _|
-- |______|__|__||_____|__|__||____|

--  _______ __                     __
-- |     __|__|.-----.-----.---.-.|  |
-- |__     |  ||  _  |     |  _  ||  |
-- |_______|__||___  |__|__|___._||__|
--             |_____|
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
-- Set the window as a slave (put it at the end of others instead of setting it as master)
client.connect_signal(
    'manage',
    function(c)
        if not awesome.startup then
            awful.client.setslave(c)
        end
    end
)
-- ------------------------------------------------- --
-- center the mouse on newly opened clients
client.connect_signal(
    'manage',
    function(c)
        gears.timer.delayed_call(
            function()
                awful.placement.centered(mouse, {parent = c})
            end
        )
    end
)
-- ------------------------------------------------- --
-- Prevent clients from being unreachable after screen count changes.
client.connect_signal(
    'manage',
    function(c)
        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_offscreen(c)
            awful.placement.no_overlap(c)
        end
    end
)

-- ------------------------------------------------- --
-- --------------------- Focus --------------------- --
-- Refocus parent window after transient window closes
local last_focus
client.connect_signal(
    'unfocus',
    function(c)
        last_focus = c
    end
)
client.connect_signal(
    'focus',
    function(_)
        last_focus = nil
    end
)
client.connect_signal(
    'unmanage',
    function(c)
        if last_focus == c and c.transient_for then
            client.focus = c.transient_for
            c.transient_for:raise()
        end
    end
)
-- ------------------------------------------------- --
-- when focus changes, move mouse to the client focused on
client.connect_signal(
    'focus',
    function(c)
        gears.timer.delayed_call(
            function()
                awful.placement.centered(mouse, {parent = c})
            end
        )
    end
)

-- ------------------------------------------------- --
-- Change focused screen when client is switched
client.connect_signal(
    'focus',
    function(c)
        if awful.screen.focused() ~= c.screen then
            awful.screen.focus(c.screen)
        end
    end
)

-- ------------------------------------------------- --
-- Raise urgent clients
client.connect_signal(
    'request::urgent',
    function(c)
        c:raise()
    end
)
-- ------------------------------------------------- --
-- Enable sloppy focus, so that focus follows mouse. BUT don't raise the window, Lord help me that is annoying when trying to access a popup window within another window
client.connect_signal(
    'mouse::enter',
    function(c)
        c:emit_signal('request::activate', 'mouse_enter', {raise = false})
    end
)
-- ------------------------------------------------- --
-- --------------------- Shape --------------------- --
-- Manipulate client shape on floating
client.connect_signal(
    'property::floating',
    function(c)
        if c.floating then
            c.shape = beautiful.client_shape_rounded
            awful.placement.no_offscreen(c)
            awful.placement.centered(c)
            c.screen = awful.screen.focused(c)
        end
    end
)
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
-- Manipulate client shape on fullscreen/non-fullscreen
client.connect_signal(
    'property::maximized',
    function(c)
        if c.maximized then
            c.shape = beautiful.client_shape_rectangle
        else
            update_client(c)
        end
    end
)
-- ------------------------------------------------- --
-- -------------------- Pointer -------------------- --
-- ------------------------------------------------- --
-- Set mouse resize mode (live or after)
awful.mouse.resize.set_mode('live')
-- ------------------------------------------------- --
-- -------------------- Geometry ------------------- --
-- ------------------------------------------------- --
-- Restore geometry for floating clients
-- (for example after swapping from tiling mode to floating mode)

tag.connect_signal(
    'property::layout',
    function(t)
        for k, c in ipairs(t:clients()) do
            if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
                local cgeo = awful.client.property.get(c, 'floating_geometry')
                if cgeo then
                    c:geometry(awful.client.property.get(c, 'floating_geometry'))
                end
            end
        end
    end
)

client.connect_signal(
    'manage',
    function(c)
        if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
            awful.client.property.set(c, 'floating_geometry', c:geometry())
        end
    end
)

client.connect_signal(
    'property::geometry',
    function(c)
        if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
            awful.client.property.set(c, 'floating_geometry', c:geometry())
        end
    end
)
-- ------------------------------------------------- --
