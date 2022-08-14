--  ______
-- |   __ \.-----.--.--.--.-----.----.
-- |    __/|  _  |  |  |  |  -__|   _|
-- |___|   |_____|________|_____|__|

--  ______         __   __
-- |   __ \.--.--.|  |_|  |_.-----.-----.
-- |   __ <|  |  ||   _|   _|  _  |     |
-- |______/|_____||____|____|_____|__|__|
-- ------------------------------------------------- --

local widget_icon =
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

local widget =
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
        widget = wibox.container.background
    },
    forced_width = dpi(40),
    forced_height = dpi(40),
    widget = clickable_container,
    bg = colors.color8
}

local power_status = true

awesome.connect_signal(
    'bluetooth::power:toggle',
    function()
        if power_status == false then
            power_status = true
            awful.spawn.with_shell("echo -e 'power on' | bluetoothctl")
            widget_icon.icon:set_image(icons.bluetooth)
            widget.bg = colors.color8
        elseif power_status == true then
            power_status = false
            awful.spawn.with_shell("echo -e 'power off' | bluetoothctl")
            widget_icon.icon:set_image(icons.bluetooth_off)
            widget.bg = colors.colorA
        end
    end
)

awesome.connect_signal(
    'bluetooth::power:refresh',
    function()
        awful.spawn.easy_async_with_shell(
            [[echo -e 'show' | bluetoothctl  | sed -n '5p']],
            function(stdout)
                stdout = stdout:match('[%w:]+', 10)
                if stdout == 'yes' then
                    power_status = true
                    widget_icon.icon:set_image(icons.bluetooth)
                    widget.bg = colors.color8
                elseif stdout == 'no' then
                    power_status = false
                    widget_icon.icon:set_image(icons.bluetooth_off)
                    widget.bg = colors.colorA
                end
            end
        )
    end
)

widget:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awesome.emit_signal('bluetooth::power:toggle')
            end
        )
    )
)

return widget
