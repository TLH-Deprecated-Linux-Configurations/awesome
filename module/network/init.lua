--  _______         __                        __
-- |    |  |.-----.|  |_.--.--.--.-----.----.|  |--.
-- |       ||  -__||   _|  |  |  |  _  |   _||    <
-- |__|____||_____||____|________|_____|__|  |__|__|
--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|
-- ------------------------------------------------- --
-- popup that lists wifi networks and currently connected network.

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
                    require('widget.network_center.title-text')
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

local status =
    wibox.widget {
    {
        {
            spacing = dpi(0),
            layout = wibox.layout.fixed.vertical,
            format_item(
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacing = dpi(16),
                    require('widget.network_center.status-icon'),
                    require('widget.network_center.status')
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
    forced_height = 70,
    ontop = true,
    border_width = dpi(2),
    border_color = colors.colorA,
    widget = wibox.container.background
}

local networks_panel =
    wibox.widget {
    {
        {
            spacing = dpi(0),
            layout = wibox.layout.flex.vertical,
            format_item(
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacing = dpi(16),
                    require('widget.network_center.networks-panel')
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

networkCenter =
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
networkCenter:setup {
    spacing = dpi(15),
    title,
    status,
    networks_panel,
    layout = wibox.layout.fixed.vertical
}
_G.nc_status = false

awesome.connect_signal(
    'network::center:toggle',
    function()
        if networkCenter.visible == false then
            networkCenter.visible = true
            awesome.emit_signal('network::networks:refreshPanel')
        elseif networkCenter.visible == true then
            networkCenter.visible = false
        end
    end
)

awesome.connect_signal(
    'network::center:toggle:off',
    function()
        networkCenter.visible = false
    end
)
return networkCenter
