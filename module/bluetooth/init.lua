--  ______ __               __                __   __
-- |   __ \  |.--.--.-----.|  |_.-----.-----.|  |_|  |--.
-- |   __ <  ||  |  |  -__||   _|  _  |  _  ||   _|     |
-- |______/__||_____|_____||____|_____|_____||____|__|__|
--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|
-- ------------------------------------------------- --
local screen_geometry = require('awful').screen.focused().geometry

local width = dpi(410)

local title =
    wibox.widget {
    {
        {
            spacing = dpi(0),
            layout = wibox.layout.align.vertical,
            expand = 'max',
            format_item(
                {
                    halign = 'center',
                    valign = 'center',
                    layout = wibox.layout.fixed.horizontal,
                    spacing = dpi(16),
                    require('widget.bluetooth.power-button'),
                    require('widget.bluetooth.title-text'),
                    require('widget.bluetooth.search-button')
                }
            )
        },
        margins = dpi(5),
        widget = wibox.container.margin
    },
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, beautiful.groups_radius)
    end,
    bg = beautiful.bg_normal,
    forced_width = width,
    forced_height = dpi(40),
    ontop = true,
    border_width = dpi(2),
    border_color = colors.colorA,
    widget = wibox.container.background
}

local devices_panel =
    wibox.widget {
    {
        {
            spacing = dpi(0),
            layout = wibox.layout.flex.vertical,
            format_item(
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacing = dpi(16),
                    require('widget.bluetooth.devices-panel')
                }
            )
        },
        margins = dpi(5),
        widget = wibox.container.margin
    },
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, beautiful.groups_radius)
    end,
    bg = beautiful.bg_menu,
    forced_width = width,
    ontop = true,
    border_width = dpi(2),
    border_color = colors.colorA,
    widget = wibox.container.background
}

bluetoothCenter =
    wibox(
    {
        x = screen_geometry.width - width - dpi(8),
        y = screen_geometry.y + dpi(35),
        visible = false,
        ontop = true,
        screen = screen.primary,
        type = 'splash',
        height = screen_geometry.height - dpi(35),
        width = width,
        bg = 'transparent',
        fg = colors.white
    }
)
bluetoothCenter:setup {
    spacing = dpi(15),
    title,
    devices_panel,
    layout = wibox.layout.fixed.vertical
}
_G.nc_status = false

awesome.connect_signal(
    'bluetooth::center:toggle',
    function()
        if bluetoothCenter.visible == false then
            bluetoothCenter.visible = true
            awesome.emit_signal('bluetooth::devices:refreshPanel')
        elseif bluetoothCenter.visible == true then
            bluetoothCenter.visible = false
        end
    end
)

awesome.connect_signal(
    'bluetooth::center:toggle:off',
    function()
        bluetoothCenter.visible = false
    end
)
return bluetoothCenter
