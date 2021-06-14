--  ______               __               __      ______               __
-- |      |.-----.-----.|  |_.----.-----.|  |    |      |.-----.-----.|  |_.-----.----.
-- |   ---||  _  |     ||   _|   _|  _  ||  |    |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|__| |_____||__|    |______||_____|__|__||____|_____|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################

local wibox = require('wibox')
local gears = require('gears')
local icons = require('theme.icons')

local dpi = require('beautiful').xresources.apply_dpi
local clickable_container = require('widget.material.clickable-container')

-- Load panel rules, it will create panel for each screen
require('layout.left-panel.panel-rules')
-- ########################################################################
-- ########################################################################
-- ########################################################################
local widget =
    wibox.widget {
    {
        id = 'icon',
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local home_button = clickable_container(wibox.container.margin(widget, dpi(5), dpi(0), dpi(5), dpi(5)))

home_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                _G.screen.primary.left_panel:toggle()
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
_G.screen.primary.left_panel:connect_signal(
    'opened',
    function()
        widget.icon:set_image(icons.close)
        _G.menuopened = true
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
_G.screen.primary.left_panel:connect_signal(
    'closed',
    function()
        widget.icon:set_image(icons.settings)
        _G.menuopened = false
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
widget.icon:set_image(icons.settings)

return home_button
