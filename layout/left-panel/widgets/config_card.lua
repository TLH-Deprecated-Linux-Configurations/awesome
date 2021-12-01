--  _______              __         __      _______           __ __
-- |     __|.-----.----.|__|.---.-.|  |    |   |   |.-----.--|  |__|.---.-.
-- |__     ||  _  |  __||  ||  _  ||  |    |       ||  -__|  _  |  ||  _  |
-- |_______||_____|____||__||___._||__|    |__|_|__||_____|_____|__||___._|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local wibox = require('wibox')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local card = require('widget.interface.card')

local beautiful = require('beautiful')

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Generate widget with background
local genWidget = function(widgets)
    return wibox.widget {
        {
            widgets,
            bg = beautiful.bg_modal,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 12)
            end,
            widget = wibox.container.background
        },
        margins = dpi(0),
        widget = wibox.container.margin
    }
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local config_card = card('Settings', dpi(60))

-- ########################################################################
-- ########################################################################
-- ########################################################################
local config_layout =
    wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(25),
    genWidget(require 'layout.left-panel.widgets.wifi'),
    genWidget(require 'layout.left-panel.widgets.bluetooth')
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local body =
    wibox.widget {
    {
        expand = 'none',
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            nil
        },
        config_layout,
        {
            layout = wibox.layout.fixed.horizontal,
            nil
        }
    },
    margins = dpi(5),
    widget = wibox.container.margin
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
config_card.update_body(body)

return wibox.container.margin(config_card, dpi(10), dpi(10), dpi(10), dpi(10))
