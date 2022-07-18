--  _______ __                              __
-- |    ___|  |.-----.--------.-----.-----.|  |_.-----.
-- |    ___|  ||  -__|        |  -__|     ||   _|__ --|
-- |_______|__||_____|__|__|__|_____|__|__||____|_____|
-- ------------------------------------------------- --
-- declare widget
local elements = {}

-- ------------------------------------------------- --
--  widget constructor
elements.create = function(title, message)
    -- ------------------------------------------------- --
    -- box element
    local box = {}

    -- ------------------------------------------------- --
    -- clear element
    local clear =
        wibox.widget {
        {
            {
                {
                    layout = wibox.layout.align.vertical,
                    expand = 'none',
                    nil,
                    {
                        image = icons.clearNotificationIndividual,
                        widget = wibox.widget.imagebox,
                        id = 'icon',
                        resize = true
                    },
                    nil
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },
            shape = beautiful.client_shape_rounded,
            widget = wibox.container.background,
            bg = beautiful.bg_button
        },
        forced_width = dpi(40),
        forced_height = dpi(30),
        widget = clickable_container
    }

    -- ------------------------------------------------- --
    -- clear button bindings
    clear:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                nil,
                function()
                    _G.removeElement(box)
                end
            )
        )
    )

    -- ------------------------------------------------- --
    -- notification content template
    local content =
        wibox.widget {
        {
            {
                {
                    text = title,
                    font = beautiful.font .. ' 10',
                    widget = wibox.widget.textbox
                },
                {
                    text = message,
                    font = beautiful.font .. ' Bold 8',
                    widget = wibox.widget.textbox
                },
                layout = wibox.layout.align.vertical
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        shape = beautiful.client_shape_rounded,
        widget = wibox.container.background
    }
    -- ------------------------------------------------- --
    -- box element template
    box =
        wibox.widget {
        {
            {
                nil,
                {
                    image = icons.new_notif,
                    widget = wibox.widget.imagebox,
                    forced_height = dpi(30),
                    id = 'icon',
                    resize = true
                },
                nil,
                halign = 'center',
                valign = 'center',
                forced_height = dpi(30),
                layout = wibox.layout.align.vertical
            },
            content,
            {
                {
                    nil,
                    clear,
                    nil,
                    halign = 'center',
                    valign = 'center',
                    forced_height = dpi(30),
                    layout = wibox.layout.align.vertical
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },
            expand = 'none',
            layout = wibox.layout.align.horizontal
        },
        shape = beautiful.client_shape_rounded,
        fg = colors.white,
        bg = colors.alpha(colors.black, '33'),
        border_width = dpi(1),
        border_color = colors.black,
        widget = wibox.container.background
    }

    return box
end

return elements
