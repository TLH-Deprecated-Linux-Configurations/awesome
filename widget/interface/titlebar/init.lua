--  __   __ __   __         __
-- |  |_|__|  |_|  |.-----.|  |--.---.-.----.-----.
-- |   _|  |   _|  ||  -__||  _  |  _  |   _|__ --|
-- |____|__|____|__||_____||_____|___._|__| |_____|
-- ########################################################################
-- Note: No included icons because otherwise there are issues with how the
-- theme is determined, which until I figure out how to mitigate, I will
-- leave in the theme directory.
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- External Library Handling
local awful = require('awful')
local gears = require('gears')

-- Widget and layout library
local wibox = require('wibox')

-- Theme handling library
local beautiful = require('beautiful')
local dpi = require('beautiful.xresources').apply_dpi
-- ########################################################################
-- ########################################################################
-- ########################################################################
local prrect = function(radius, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
    end
end

-- ########################################################################
-- ########################################################################
-- ########################################################################
client.connect_signal(
    'manage',
    function(c)
        awful.titlebar.show(c)
    end
)

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal(
    'request::titlebars',
    function(c)
        -- buttons for the titlebar
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        local buttons =
            gears.table.join(
            awful.button(
                {},
                1,
                function()
                    c:emit_signal(
                        'request::activate',
                        'titlebar',
                        {
                            raise = true
                        }
                    )
                    if c.maximized == true then
                        c.maximized = false
                    end
                    awful.mouse.client.move(c)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    c:emit_signal(
                        'request::activate',
                        'titlebar',
                        {
                            raise = true
                        }
                    )
                    awful.mouse.client.resize(c)
                end
            ),
            awful.button(
                {},
                2,
                function()
                    c = mouse.object_under_pointer()
                    c:kill()
                end
            ), -- Side button up - toggle floating
            awful.button(
                {},
                9,
                function()
                    c = mouse.object_under_pointer()
                    client.focus = c
                    -- awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
                    c.floating = not c.floating
                end
            ), -- Side button down - toggle ontop
            awful.button(
                {},
                8,
                function()
                    c = mouse.object_under_pointer()
                    client.focus = c
                    c.ontop = not c.ontop
                end
            )
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        local l_reverse_corner =
            wibox.widget {
            bg = beautiful.xcolor0,
            shape = prrect(6, false, false, true, false),
            widget = wibox.container.background
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        local r_reverse_corner =
            wibox.widget {
            bg = beautiful.xcolor0,
            shape = prrect(6, false, false, false, true),
            widget = wibox.container.background
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        local function update()
            if client.focus == c then
                -- Changed This
                l_reverse_corner.bg = beautiful.xbackground .. 'cc'
                r_reverse_corner.bg = beautiful.xbackground .. 'cc'
            else
                l_reverse_corner.bg = beautiful.xbackground .. 'aa'
                r_reverse_corner.bg = beautiful.xbackground .. 'aa'
            end
        end
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        update()
        c:connect_signal('focus', update)
        c:connect_signal('unfocus', update)

        awful.titlebar(
            c,
            {
                position = 'top',
                size = beautiful.titlebar_size,
                bg = beautiful.xbackground .. '99'
            }
        ):setup {
            {
                {
                    awful.titlebar.widget.iconwidget(c),
                    -- awful.titlebar.widget.floatingbutton(c),

                    buttons = buttons,
                    layout = wibox.layout.flex.horizontal
                },
                margins = dpi(4),
                left = dpi(20),
                right = dpi(12),
                widget = wibox.container.margin
            },
            {
                -- Middle
                --

                {
                    -- Title
                    align = 'center',
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout = wibox.layout.flex.horizontal
            },
            {
                {
                    {
                        l_reverse_corner,
                        shape = gears.rectangle,
                        widget = wibox.container.background
                    },
                    width = 0,
                    height = 0,
                    strategy = 'exact',
                    layout = wibox.layout.constraint
                },
                {
                    {
                        {
                            {
                                awful.titlebar.widget.minimizebutton(c),
                                awful.titlebar.widget.maximizedbutton(c),
                                --  awful.titlebar.widget.stickybutton(c),
                                --   awful.titlebar.widget.ontopbutton(c),
                                awful.titlebar.widget.closebutton(c),
                                layout = wibox.layout.flex.horizontal,
                                margins = dpi(0),
                                spacing = dpi(0)
                            },
                            widget = wibox.container.margin
                        },
                        shape = prrect(beautiful.border_radius, true, true, false, false),
                        widget = wibox.container.background
                    },
                    top = dpi(0),
                    bottom = dpi(0),
                    right = dpi(4),
                    spacing = dpi(0),
                    widget = wibox.container.margin
                },
                {
                    {
                        r_reverse_corner,
                        bg = beautiful.xbackground,
                        shape = gears.rectangle,
                        widget = wibox.container.background
                    },
                    width = 0,
                    height = 0,
                    strategy = 'exact',
                    layout = wibox.layout.constraint
                },
                top = dpi(2),
                right = dpi(2),
                -- widget = wibox.container.margin
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.align.horizontal,
            bg = beautiful.xbackground .. 'cc'
        }
    end
)

-- EOF ------------------------------------------------------------------------
