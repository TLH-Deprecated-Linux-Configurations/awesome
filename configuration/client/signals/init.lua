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
-- NOTE: this is the central point that calls the
-- various signals' associated functions when the
-- signal fires due to a client meetings its specified
-- condition
-- ------------------------------------------------- --
client.connect_signal(
    'manage',
    function(c)
        require('configuration.client.signals.position')(c)
        require('configuration.client.signals.floating_properties')(c)
    end
)
-- ------------------------------------------------- --
-- --------------------- Focus --------------------- --
-- Enable sloppy focus, so that focus follows mouse. BUT don't raise the window, Lord help me that is annoying when trying to access a popup window within another window
client.connect_signal(
    'mouse::enter',
    function(c)
        require('configuration.client.signals.focus')(c)
    end
)
-- ------------------------------------------------- --
client.connect_signal(
    'focus',
    function(c)
        c.border_color = beautiful.border_focus
    end
)
-- ------------------------------------------------- --
client.connect_signal(
    'unfocus',
    function(c)
        c.border_color = beautiful.border_normal
    end
)
-- ------------------------------------------------- --
-- ------------------- Properties ------------------ --
-- ------------------------------------------------- --
-- Manipulate client shape on floating
client.connect_signal(
    'property::floating',
    function(c)
        require('configuration.client.signals.floating_properties')(c)
    end
)
-- ------------------------------------------------- --
-- Manipulate client shape on fullscreen/non-fullscreen
client.connect_signal(
    'property::fullscreen',
    function(c)
        require('configuration.client.signals.fullscreen_shape')(c)
    end
)
-- ------------------------------------------------- --
-- Manipulate client shape on fullscreen/non-fullscreen
client.connect_signal(
    'property::maximized',
    function(c)
        require('configuration.client.signals.fullscreen_shape')(c)
    end
)
-- ------------------------------------------------- --
-- geometry
tag.connect_signal(
    'property::layout',
    function(t)
        require('configuration.client.signals.floating_geometry')(t)
    end
)

client.connect_signal(
    'property::geometry',
    function(c)
        require('configuration.client.signals.floating_properties')(c)
    end
)

-- ------------------------------------------------- --
-- -------------------- Pointer -------------------- --
-- NOTE: Set mouse resize mode (live or after)
awful.mouse.resize.set_mode('live')
