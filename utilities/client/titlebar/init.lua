--  __   __ __   __         __
-- |  |_|__|  |_|  |.-----.|  |--.---.-.----.-----.
-- |   _|  |   _|  ||  -__||  _  |  _  |   _|__ --|
-- |____|__|____|__||_____||_____|___._|__| |_____|
-- ------------------------------------------------- --
-- because I like titlebars.  The icons originate from
-- my GTK theme, Dhumavati. They are the artifact of making
-- the theme fit gnome and xfce, so why not also use them here?
-- ------------------------------------------------- --
-- External Library Handling
local awful = require('awful')
local gears = require('gears')

-- Widget and layout library
local wibox = require('wibox')

-- Theme handling library
local beautiful = require('beautiful')
local dpi = require('beautiful.xresources').apply_dpi
-- ------------------------------------------------- --
local prrect = function(radius, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
    end
end

-- ------------------------------------------------- --
_G.client.connect_signal(
    'manage',
    function(c)
        awful.titlebar.show(c)
    end
)

-- ------------------------------------------------- --
-- Add a titlebar if titlebars_enabled is set to true in the rules.
--
_G.client.connect_signal(
    'request::titlebars',
    function(c)
        -- mouse button handling for the titlebar
        -- ------------------------------------------------- --
        local buttons =
            gears.table.join(
            -- ------------------------------------------------- --
            -- raise if clicking titlebar
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

                    awful.mouse.client.move(c)
                end
            ),
            -- ------------------------------------------------- --
            --  resize with right click to titlebar
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
            -- ------------------------------------------------- --
            -- kill window with middle mosue click to titlebar
            awful.button(
                {},
                2,
                function()
                    c = mouse.object_under_pointer()
                    c:kill()
                end
            ),
            -- ------------------------------------------------- --
            -- Side button up - toggle floating
            awful.button(
                {},
                9,
                function()
                    c = mouse.object_under_pointer()
                    _G.client.focus = c
                    -- awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
                    c.floating = not c.floating
                end
            ),
            -- ------------------------------------------------- --
            -- Side button down - toggle ontop
            awful.button(
                {},
                8,
                function()
                    c = mouse.object_under_pointer()
                    _G.client.focus = c
                    c.ontop = not c.ontop
                end
            )
        )
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        -- Handle corner radius
        local l_reverse_corner =
            wibox.widget {
            shape = beautiful.client_shape_rounded_xl,
            widget = wibox.container.background
        }
        -- ------------------------------------------------- --

        local r_reverse_corner =
            wibox.widget {
            shape = beautiful.client_shape_rounded_xl,
            widget = wibox.container.background
        }

        -- ------------------------------------------------- --
        -- ------------------------------------------------- --
        -- ------------------------------------------------- --

        awful.titlebar(
            c,
            {
                position = 'top',
                size = beautiful.titlebar_size
            }
        ):setup {
            {
                {
                    -- awful.titlebar.widget.iconwidget(c),
                    awful.titlebar.widget.floatingbutton(c),
                    -- awful.titlebar.widget.stickybutton(c),
                    awful.titlebar.widget.ontopbutton(c),
                    buttons = buttons,
                    layout = wibox.layout.align.horizontal
                },
                margins = dpi(0),
                left = dpi(4),
                right = dpi(12),
                widget = wibox.container.margin
            },
            {
                -- Middle
                --

                {
                    -- Title
                    align = 'center',
                    widget = awful.titlebar.widget.titlewidget(c),
                    fg = colors.white,
                    font = beautiful.font .. ' 12'
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
                    layout = wibox.container.constraint
                },
                {
                    {
                        {
                            {
                                awful.titlebar.widget.minimizebutton(c),
                                awful.titlebar.widget.maximizedbutton(c),
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
                        shape = gears.rectangle,
                        widget = wibox.container.background
                    },
                    width = 0,
                    height = 0,
                    strategy = 'exact',
                    layout = wibox.container.constraint
                },
                top = dpi(2),
                right = dpi(2),
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.align.horizontal
        }
    end
)

-- EOF ------------------------------------------------------------------------
