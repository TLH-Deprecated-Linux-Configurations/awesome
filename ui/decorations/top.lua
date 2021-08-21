local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi
local helpers = require('helpers')

local titlebar

local function create_title_button(c, color_focus, color_unfocus, shp)
    local tb =
        wibox.widget {
        forced_width = dpi(16),
        forced_height = dpi(16),
        bg = color_focus .. 80,
        shape = shp,
        widget = wibox.container.background
    }

    local function update()
        if client.focus == c then
            tb.bg = color_focus
        else
            tb.bg = color_unfocus
        end
    end
    update()

    c:connect_signal('focus', update)
    c:connect_signal('unfocus', update)

    tb:connect_signal(
        'mouse::enter',
        function()
            tb.bg = color_focus
        end
    )
    tb:connect_signal(
        'mouse::leave',
        function()
            tb.bg = color_focus
        end
    )

    tb.visible = true
    return tb
end

local get_titlebar = function(c, height, color)
    local buttons =
        gears.table.join(
        awful.button(
            {},
            1,
            function()
                client.focus = c
                c:raise()
                awful.mouse.client.move(c)
            end
        ),
        awful.button(
            {},
            3,
            function()
                client.focus = c
                c:raise()
                awful.mouse.client.resize(c)
            end
        )
    )

    local tri = function(width, height)
        return function(cr)
            gears.shape.isosceles_triangle(cr, width, height)
        end
    end

    local ci = function(width, height)
        return function(cr)
            gears.shape.circle(cr, width, height)
        end
    end

    local cross = function(width, height)
        return function(cr)
            gears.shape.cross(cr, width, height)
        end
    end

    local po = function(width, height, depth)
        return function(cr)
            gears.shape.powerline(cr, width, height, depth)
        end
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local close =
        create_title_button(
        c,
        beautiful.xcolor1,
        beautiful.xcolor7,
        gears.shape.transform(cross(12, 12)):rotate_at(6, 6, math.pi / 4)
    )
    close:connect_signal(
        'button::press',
        function()
            c:kill()
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local min =
        create_title_button(
        c,
        beautiful.xcolor12,
        beautiful.xcolor7,
        gears.shape.transform(po(12, 12)):rotate_at(6, 6, math.pi / 2)
    )

    min:connect_signal(
        'button::press',
        function()
            c.minimized = true
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Maximize button
    local max =
        create_title_button(
        c,
        beautiful.xcolor4,
        beautiful.xcolor7,
        gears.shape.transform(po(12, 12)):rotate_at(6, 6, math.pi / -2)
    )
    max:connect_signal(
        'button::press',
        function()
            c.maximized = not c.maximized
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Below are alternative buttons you can generate for the titlebar that are all squircle.
    -- local close = create_title_button(c, beautiful.xcolor1, beautiful.xcolor7, gears.shape.squircle)
    -- close:connect_signal(
    --     'button::press',
    --     function()
    --         c:kill()
    --     end
    -- )

    -- local min = create_title_button(c, beautiful.xcolor3, beautiful.xcolor7, gears.shape.squircle)

    -- min:connect_signal(
    --     'button::press',
    --     function()
    --         c.minimized = true
    --     end
    -- )

    -- local max = create_title_button(c, beautiful.xcolor4, beautiful.xcolor7, gears.shape.squircle)

    -- max:connect_signal(
    --     'button::press',
    --     function()
    --         c.maximized = not c.maximized
    --     end
    -- ) --
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    awful.titlebar(
        c,
        {
            size = beautiful.border_width,
            bg = color,
            position = 'left'
        }
    )
    awful.titlebar(
        c,
        {
            size = beautiful.border_width,
            bg = color,
            position = 'right'
        }
    )
    awful.titlebar(
        c,
        {
            size = beautiful.border_width,
            bg = color,
            position = 'bottom'
        }
    )
    awful.titlebar(c, {size = height, position = 'top'}):setup {
        {
            {
                awful.widget.clienticon(c),
                top = dpi(6),
                bottom = dpi(6),
                left = dpi(14),
                widget = wibox.container.margin
            },
            {
                {
                    -- Title
                    align = 'center',
                    valign = 'center',
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout = wibox.layout.flex.horizontal
            },
            {
                {
                    min,
                    max,
                    close,
                    spacing = dpi(10),
                    layout = wibox.layout.flex.horizontal
                },
                top = dpi(10),
                left = dpi(7.5),
                right = dpi(7.5),
                bottom = dpi(6),
                widget = wibox.container.margin
            },
            expand = 'none',
            layout = wibox.layout.align.horizontal
        },
        bg = color,
        shape = helpers.prrect(0, true, true, false, false),
        widget = wibox.container.background
    }
end

local top = function(c)
    local color = beautiful.titlebar_bg_normal

    local titlebar_height = beautiful.titlebar_size
    get_titlebar(c, titlebar_height, color)
end

return top
