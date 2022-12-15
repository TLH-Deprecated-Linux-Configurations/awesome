--  _______ __                              __
-- |    ___|  |.-----.--------.-----.-----.|  |_.-----.
-- |    ___|  ||  -__|        |  -__|     ||   _|__ --|
-- |_______|__||_____|__|__|__|_____|__|__||____|_____|
-- ------------------------------------------------- --
local elements = {}

elements.create = function(name, macAddress, pairStatus, connectStatus)
    local box = {}

    local pairIcon =
        wibox.widget {
        layout = wibox.layout.align.vertical,
        expand = 'none',
        nil,
        {
            id = 'icon',
            image = icons.chain,
            resize = true,
            widget = wibox.widget.imagebox
        },
        nil
    }

    local pair =
        wibox.widget {
        {
            {
                {
                    pairIcon,
                    layout = wibox.layout.fixed.horizontal
                },
                margins = dpi(6),
                widget = wibox.container.margin
            },
            forced_height = dpi(30),
            forced_width = dpi(30),
            widget = clickable_container
        },
        widget = wibox.container.background
    }

    pair:connect_signal(
        'mouse::enter',
        function()
            pair.bg = colors.alpha(colors.colorY, 'cc')
        end
    )

    pair:connect_signal(
        'mouse::leave',
        function()
            pair.bg = colors.black
        end
    )

    local unpairIcon =
        wibox.widget {
        layout = wibox.layout.align.vertical,
        expand = 'none',
        nil,
        {
            id = 'icon',
            image = icons.chain_broken,
            resize = true,
            widget = wibox.widget.imagebox
        },
        nil
    }

    local unpair =
        wibox.widget {
        {
            {
                {
                    pairIcon,
                    layout = wibox.layout.fixed.horizontal
                },
                margins = dpi(6),
                widget = wibox.container.margin
            },
            forced_height = dpi(30),
            forced_width = dpi(30),
            widget = clickable_container
        },
        shape = beautiful.client_shape_rounded,
        bg = colors.alpha(colors.colorA, 'cc'),
        widget = wibox.container.background
    }

    unpair:connect_signal(
        'mouse::enter',
        function()
            unpair.bg = colors.white
        end
    )

    unpair:connect_signal(
        'mouse::leave',
        function()
            unpair.bg = colors.alpha(colors.colorA, 'cc')
        end
    )

    local connectIcon =
        wibox.widget {
        layout = wibox.layout.align.vertical,
        expand = 'none',
        nil,
        {
            id = 'icon',
            image = icons.bluetooth,
            resize = true,
            widget = wibox.widget.imagebox
        },
        nil
    }

    local connect =
        wibox.widget {
        {
            {
                {
                    connectIcon,
                    layout = wibox.layout.fixed.horizontal
                },
                margins = dpi(3),
                widget = wibox.container.margin
            },
            forced_height = dpi(30),
            forced_width = dpi(30),
            widget = clickable_container
        },
        shape = beautiful.client_shape_rounded,
        bg = colors.alpha(colors.colorA, 'cc'),
        widget = wibox.container.background
    }

    connect:connect_signal(
        'mouse::enter',
        function()
            connect.bg = colors.alpha(colors.colorY, 'cc')
        end
    )

    connect:connect_signal(
        'mouse::leave',
        function()
            connect.bg = colors.alpha(colors.colorA, 'cc')
        end
    )

    local disconnectIcon =
        wibox.widget {
        layout = wibox.layout.align.vertical,
        expand = 'none',
        nil,
        {
            id = 'icon',
            image = icons.bluetooth,
            resize = true,
            widget = wibox.widget.imagebox
        },
        nil
    }

    local disconnect =
        wibox.widget {
        {
            {
                {
                    disconnectIcon,
                    layout = wibox.layout.fixed.horizontal
                },
                margins = dpi(3),
                widget = wibox.container.margin
            },
            forced_height = dpi(30),
            forced_width = dpi(30),
            widget = clickable_container
        },
        shape = beautiful.client_shape_rounded,
        bg = colors.alpha(colors.colorA, 'cc'),
        widget = wibox.container.background
    }

    disconnect:connect_signal(
        'mouse::enter',
        function()
            disconnect.bg = colors.alpha(colors.colorY, 'cc')
        end
    )

    disconnect:connect_signal(
        'mouse::leave',
        function()
            disconnect.bg = colors.alpha(colors.colorA, 'cc')
        end
    )

    pair:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                nil,
                function()
                    awful.spawn.with_shell("echo -e 'pair " .. macAddress .. "' | bluetoothctl")
                end
            )
        )
    )

    unpair:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                nil,
                function()
                    awful.spawn.with_shell("echo -e 'remove '" .. macAddress .. "' | bluetoothctl")
                end
            )
        )
    )

    connect:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                nil,
                function()
                    awful.spawn.with_shell(" echo -e 'connect " .. macAddress .. "' | bluetoothctl")
                end
            )
        )
    )

    disconnect:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                nil,
                function()
                    awful.spawn.with_shell("echo -e 'disconnect " .. macAddress .. "' | bluetoothctl")
                end
            )
        )
    )

    local bluetoothIcon =
        wibox.widget {
        {
            {
                {
                    layout = wibox.layout.align.vertical,
                    expand = 'none',
                    nil,
                    {
                        image = icons.bluetooth,
                        widget = wibox.widget.imagebox
                    },
                    nil
                },
                margins = dpi(7),
                widget = wibox.container.margin
            },
            shape = gears.shape.rect,
            bg = colors.color8,
            widget = wibox.container.background
        },
        forced_width = 40,
        forced_height = 40,
        widget = clickable_container
    }

    local content =
        wibox.widget {
        {
            {
                {
                    text = name,
                    font = beautiful.font .. ' 10',
                    widget = wibox.widget.textbox
                },
                {
                    text = macAddress,
                    font = beautiful.font .. '  8',
                    widget = wibox.widget.textbox
                },
                layout = wibox.layout.align.vertical
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        shape = beautiful.client_shape_rounded,
        bg = colors.alpha(colors.colorB, 'cc'),
        widget = wibox.container.background
    }

    local buttons = {}

    if pairStatus and connectStatus == 'yes' then
        buttons = {
            layout = wibox.layout.align.horizontal,
            spacing = dpi(15),
            unpair,
            disconnect
        }
    elseif pairStatus and connectStatus == 'no' then
        buttons = {
            layout = wibox.layout.align.horizontal,
            spacing = dpi(15),
            unpair,
            connect
        }
    else
        buttons = {
            layout = wibox.layout.align.horizontal,
            pair
        }
    end

    box =
        wibox.widget {
        {
            bluetoothIcon,
            content,
            buttons,
            layout = wibox.layout.align.horizontal
        },
        shape = beautiful.client_shape_rounded,
        fg = colors.white,
        border_width = dpi(2),
        border_color = colors.alpha(colors.colorA, '88'),
        widget = wibox.container.background
    }

    return box
end

return elements
