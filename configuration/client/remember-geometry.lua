-- ########################################################################
--  ______                                 __
-- |   __ \.-----.--------.-----.--------.|  |--.-----.----.
-- |      <|  -__|        |  -__|        ||  _  |  -__|   _|
-- |___|__||_____|__|__|__|_____|__|__|__||_____|_____|__|
--  _______                              __
-- |     __|.-----.-----.--------.-----.|  |_.----.--.--.
-- |    |  ||  -__|  _  |        |  -__||   _|   _|  |  |
-- |_______||_____|_____|__|__|__|_____||____|__| |___  |
--                                                |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Remembers geometry when switching between floating and tiled, in case that
-- matters to anyone, I am not sure I care much but its is somewhat useful
-- from https://github.com/basaran/awesome-remember-geometry except uses
-- things like local for its variable scope, aka better syntax and is commented
--
local client = client
local tag = tag
local ipairs = ipairs
-- ########################################################################
-- ########################################################################
-- ########################################################################
--  Remember client size when switching between floating and tiling.
--
client.connect_signal(
    "maximize",
    function(c)
        -- max if
        -- both are false
        -- only one is true
        --
        local max_h = c.maximized_horizontal
        local max_v = c.maximized_vertical
        local max = (not max_h and not max_v) or not (max_h and max_v)
        c.remember_geometry.maximized_manual = max
        c.maximized_horizontal = max
        c.maximized_vertical = max
        c.maximized = max
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Function that collects the geometry from the client`
--
client.connect_signal(
    "manage",
    function(c)
        c.remember_geometry = {
            floating_geometry = c:geometry(),
            maximized_manual = false,
            maximized_horizontal = c.maximized_horizontal,
            maximized_vertical = c.maximized_vertical
        }
    end
)

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- If the window is closed, don't save its geometry anymore.
--
client.connect_signal(
    "unmanage",
    function(c)
        c.remember_geometry = nil
    end
)

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- If the client floats, then the window geometry should account for as much.
--
client.connect_signal(
    "property::floating",
    function(c)
        if c.floating and c.remember_geometry then
            c:geometry(c.remember_geometry.floating_geometry)
        end
    end
)

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- if the whole layout is floating on a screen, save that like the above
-- for its clients
--
tag.connect_signal(
    "property::layout",
    function(t)
        if t.layout == awful.layout.suit.floating then
            for c in ipairs(t:clients()) do
                c:geometry(c.remember_geometry.floating_geometry)
            end
        end
    end
)

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- If a client is being resized, remove the maximized properties, if present,
-- should be set to false unless the client has the fullscreen property applied.
client.connect_signal(
    "request::geometry",
    function(c, context)
        if context == "mouse.resize" and not c.fullscreen then
            c.maximized_horizontal = false
            c.maximized_vertical = false
        end
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Geometry as a property must be given some clear definition,
--
client.connect_signal(
    "property::geometry",
    function(c)
        -- If the client is floating or if the client is on the first tag AND (inclusive and here) the first tag is floating as the default.
        --
        local is_floating = c.floating or (c.first_tag and c.first_tag.layout == awful.layout.suit.floating)
        if c.remember_geometry and is_floating and not c.fullscreen and not c.minimized then
            -- variable assignment of client property to variables within the the rest of the function, not prefixed with local to stem issues with scope
            --.
            local cgeometry = c:geometry()
            local sgeometry = c.screen.workarea
            c.remember_geometry.floating_geometry = cgeometry
            -- if the client hasn't been assigned the horizontal maximization property (or is fullscreen) then proceed
            --
            if not c.maximized_horizontal then
                -- account for the workkarea (if honored in rules) and the client border_widths
                --
                local diffWidth = sgeometry.width - cgeometry.width - c.border_width
                local xpos = sgeometry.x - cgeometry.x
                -- assigns the horizontal maximization propety if not done and if it is, removes it. This really improve the reliability of said feature a lot and improves the smooth managementv
                if not c.remember_geometry.maximized_horizontal and diffWidth == 0 and xpos == 0 then
                    c.remember_geometry.maximized_horizontal = true
                    c.maximized_horizontal = true
                else
                    c.remember_geometry.maximized_horizontal = false
                end
            end
            if not c.maximized_vertical then
                local diffHeight = sgeometry.height - cgeometry.height - c.border_width
                local ypos = sgeometry.y - cgeometry.y
                if not c.remember_geometry.maximized_vertical and diffHeight == 0 and ypos == 0 then
                    c.remember_geometry.maximized_vertical = true
                    c.maximized_vertical = true
                else
                    c.remember_geometry.maximized_vertical = false
                end
            end
        end
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Defines the fullscreen property as having both maximization properties.
--
client.connect_signal(
    "property::fullscreen",
    function(c)
        if c.floating and not c.fullscreen then
            c:geometry(c.remember_geometry.floating_geometry)
            if c.remember_geometry.maximized_manual then
                c.maximized_horizontal = true
                c.maximized_vertical = true
            end
        end
    end
)
