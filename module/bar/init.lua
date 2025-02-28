--  ______
-- |   __ \.---.-.----.
-- |   __ <|  _  |   _|
-- |______/|___._|__|
-- ------------------------------------------------- --
-- NOTE  this refers to the top dropdown bar, activated by hovering
-- the mouse in the center of the screen at the topmost edge.

-- ------------------------------------------------- --
-- ----------------- declare widget ---------------- --
--
local bar = function(s)
    s.panel =
        wibox(
        {
            ontop = true,
            honor_workarea = false,
            honor_padding = false,
            screen = s,
            type = 'floating',
            height = dpi(54),
            width = dpi(800),
            stretch = false,
            visible = false,
            bg = beautiful.bg_normal,
            fg = colors.white,
            shape = beautiful.client_shape_rounded_lg
        }
    )
    awful.placement.top(s.panel, {margins = beautiful.useless_gap * 4})

    -- ------------------------------------------------- --
    -- ---------------- provide spacing ---------------- --
    -- NOTE  toggle function to make it disappear
    --
    function bar_toggle()
        if s.panel.visible == false then
            awful.screen.connect_for_each_screen(
                function(s)
                    s.panel.visible = true
                    s.panel.status = true
                end
            )
        elseif s.panel.visible == true then
            awful.screen.connect_for_each_screen(
                function(s)
                    s.panel.visible = false
                    s.panel.status = false
                end
            )
        end
    end

    -- ------------------------------------------------- --
    -- NOTE   center portion of the panel, used for spacing purposes
    --
    local centerBar = {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(12)
    }
    -- ------------------------------------------------- --
    --   NOTE Center bar insertions
    --
    table.insert(centerBar, require('widget.bar.menu')({color = colors[beautiful.bg_button]}, 0, 0))
    table.insert(centerBar, require('widget.bar.tags')(s))
    table.insert(centerBar, require('widget.bar.layoutbox')({color = colors[beautiful.bg_button]}))

    -- ------------------------------------------------- --
    -- NOTE  panel template
    --
    s.panel:setup {
        layout = wibox.layout.align.horizontal,
        expand = 'none',
        spacing = dpi(12),
        left = dpi(4),
        centerBar,
        top = dpi(2),
        bottom = dpi(2),
        widget = wibox.container.margin,
        right = dpi(8)
    }

    -- ------------------------------------------------- --
    -- ------------------- animation ------------------- --
    -- NOTE  when the bar is hidden, where it is located
    --
    local hidden_y = awful.screen.focused().geometry.y - (s.panel.height)
    -- ------------------------------------------------- --
    -- NOTE  setting its height
    --
    local visible_y = awful.screen.focused().geometry.y
    -- ------------------------------------------------- --
    -- NOTE defining the anotation
    local animation =
        rubato.timed(
        {
            intro = 0.1,
            outro = 0.1,
            duration = 0.2,
            pos = hidden_y,
            rate = 80,
            easing = rubato.quadratic,
            subscribed = function(pos)
                s.panel.y = pos
            end
        }
    )

    -- ------------------------------------------------- --
    -- ------------ auto hide functionality ------------ --
    --  NOTE  timer to close the bar
    --
    s.detect =
        gears.timer {
        timeout = 3,
        callback = function()
            animation.target = hidden_y
            s.panel.visible = false
            s.activation_zone.visible = true
            s.detect:stop()
            awesome.emit_signal('bar:false')
            animation.target = hidden_y
        end
    }

    -- ------------------------------------------------- --
    --  NOTE  shows the bar open
    --
    s.enable_wibox = function()
        s.panel.visible = true
        s.activation_zone.visible = false
        animation.target = visible_y
        awesome.emit_signal('bar:true')
        s.detect:start()
    end
    -- ------------------------------------------------- --
    --  NOTE  if the bar is not present, this is
    --
    s.activation_zone =
        wibox(
        {
            x = s.panel.x,
            y = s.geometry.y,
            position = 'top',
            opacity = 0.0,
            width = s.panel.width,
            height = dpi(1),
            screen = s,
            input_passthrough = false,
            visible = true,
            ontop = true,
            type = 'popup'
        }
    )
    s.activation_zone:struts {left = 0, right = 0, bottom = 0, top = 0}

    -- ------------------------------------------------- --
    --  NOTE  when mouse moves to this bar, the other opens
    --
    s.activation_zone:connect_signal(
        'mouse::enter',
        function()
            s.enable_wibox()
        end
    )
    -- ------------------------------------------------- --
    --  NOTE this keeps the bar open so long is the mouse is within its boundaries so the other can be hidden
    --
    s.panel:connect_signal(
        'mouse::enter',
        function()
            s.detect:stop()
        end
    )
    -- ------------------------------------------------- --
    --  NOTE this keeps the bar open so long is the mouse is within its boundaries so the other can be hidden
    --
    s.panel:connect_signal(
        'button::press',
        function()
            s.enable_wibox()
        end
    )
    -- ------------------------------------------------- --
    --  NOTE this keeps the bar open so long is the mouse is within its boundaries so the other can be hidden
    --
    s.panel:connect_signal(
        'button::release',
        function()
            s.enable_wibox()
        end
    )
    -- ------------------------------------------------- --
    --  NOTE signals to begin timer when mouse leaves
    --
    s.panel:connect_signal(
        'mouse::leave',
        function()
            s.detect:start()
        end
    )

    return s.panel
end

-- ------------------------------------------------- --
--  NOTE  connect signal for the bar toggle to run the function
--
awesome.connect_signal(
    'bar::toggle',
    function()
        bar_toggle()
        s.enable_wibox()
    end
)

-- ------------------------------------------------- --
return bar
