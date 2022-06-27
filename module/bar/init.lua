--  ______
-- |   __ \.---.-.----.
-- |   __ <|  _  |   _|
-- |______/|___._|__|
-- ------------------------------------------------- --
-- declare widget
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
            width = s.geometry.width - dpi(300),
            stretch = false,
            visible = false,
            bg = beautiful.bg_normal,
            fg = colors.white
        }
    )
    awful.placement.top(s.panel, {margins = beautiful.useless_gap * 4})

    -- ------------------------------------------------- --
    --  provide spacing

    -- ------------------------------------------------- --
    --  toggle function to make it disappear
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
    --  left portion of the panel
    local leftBar = {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(12)
    }
    -- ------------------------------------------------- --
    --  center portion of the panel, used for spacing purposes
    local centerBar = {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(12)
    }
    -- ------------------------------------------------- --
    --  right portion of the panel, used for widgets
    local rightBar = {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(12)
    }
    -- ------------------------------------------------- --
    --  inserting widgets as tables on the left portion
    table.insert(leftBar, require('widget.bar.menu')({color = colors[beautiful.bg_button]}, 0, 0, 0, 0))
    table.insert(leftBar, require('widget.bar.layoutbox')({color = colors[beautiful.bg_button]}))

    -- ------------------------------------------------- --
    -- center insertions

    table.insert(centerBar, require('widget.bar.tags')(s))
    -- ------------------------------------------------- --
    --  right widget insertions
    table.insert(rightBar, require('widget.bar.battery')({color = colors[beautiful.bg_button]}, 0, 0))
    table.insert(rightBar, require('widget.bar.network')({color = colors[beautiful.bg_button]}, 0, 0))
    table.insert(rightBar, require('widget.bar.clock')({color = colors[beautiful.bg_button]}, 0, 0))

    table.insert(rightBar, require('widget.bar.end-session')({color = colors[beautiful.bg_button]}, 0, 0))

    -- ------------------------------------------------- --
    -- panel template
    s.panel:setup {
        layout = wibox.layout.fixed.horizontal,
        expand = 'none',
        spacing = dpi(12),
        {
            leftBar,
            left = dpi(4),
            top = dpi(4),
            bottom = dpi(4),
            widget = wibox.container.margin
        },
        {
            centerBar,
            top = dpi(6),
            bottom = dpi(6),
            widget = wibox.container.margin
        },
        {
            rightBar,
            right = dpi(4),
            top = dpi(2),
            bottom = dpi(2),
            widget = wibox.container.margin
        }
    }

    -- ------------------------------------------------- --
    -- ------------------- animation ------------------- --
    -- when the bar is hidden, where it is located
    local hidden_y = awful.screen.focused().geometry.y - (s.panel.height)
    -- ------------------------------------------------- --
    --setting its height
    local visible_y = awful.screen.focused().geometry.y
    -- ------------------------------------------------- --
    -- defining the anotation
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

    -- timer to close the bar
    s.detect =
        gears.timer {
        timeout = 5,
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
    -- holds the bar open
    s.enable_wibox = function()
        s.panel.visible = true
        s.activation_zone.visible = false
        animation.target = visible_y
        awesome.emit_signal('bar:true')

        if not s.detect.started then
            s.detect:start()
        end
    end
    -- ------------------------------------------------- --
    -- if the bar is not present, this is
    s.activation_zone =
        wibox(
        {
            x = s.geometry.x,
            y = s.geometry.y,
            position = 'top',
            opacity = 0.0,
            width = s.panel.width - dpi(400),
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
    --  when mouse moves to this bar, the other opens
    s.activation_zone:connect_signal(
        'mouse::enter',
        function()
            s.enable_wibox()
        end
    )
    -- ------------------------------------------------- --
    -- this keeps the bar open so long is the mouse is within its boundaries so the other can be hidden
    s.panel:connect_signal(
        'mouse:enter',
        function()
            s.enable_wibox()
        end
    )
    -- ------------------------------------------------- --
    -- this keeps the bar open so long is the mouse is within its boundaries so the other can be hidden
    s.panel:connect_signal(
        'button:press',
        function()
            s.enable_wibox()
        end
    )
    -- ------------------------------------------------- --
    -- this keeps the bar open so long is the mouse is within its boundaries so the other can be hidden
    s.panel:connect_signal(
        'button:release',
        function()
            s.enable_wibox()
        end
    )
    -- ------------------------------------------------- --
    -- signals to begin timer when mouse leaves
    s.panel:connect_signal(
        'mouse:leave',
        function()
            s.detect()
        end
    )

    return s.panel
end

-- ------------------------------------------------- --
--  connect signal for the bar toggle to run the function
awesome.connect_signal(
    'bar:toggle',
    function()
        bar_toggle()
    end
)

-- ------------------------------------------------- --
return bar
