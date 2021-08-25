--  _______ __               __        _____                           __
-- |     __|  |_.---.-.----.|  |_     |     |_.---.-.--.--.-----.----.|  |--.-----.----.
-- |__     |   _|  _  |   _||   _|    |       |  _  |  |  |     |  __||     |  -__|   _|
-- |_______|____|___._|__|  |____|    |_______|___._|_____|__|__|____||__|__|_____|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Libraries and Modules

local wibox = require('wibox')
local gears = require('gears')
local HOME = os.getenv('HOME')

local PATH_TO_ICONS = HOME .. '/.config/awesome/theme/icons/matangi/'

local dpi = require('beautiful').xresources.apply_dpi
local clickable_container = require('lib.clickable-container')
local start = require 'ui.pop.start'
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Load panel rules, it will create panel for each screen

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
local start_button = clickable_container(wibox.container.margin(widget, dpi(5), dpi(5), dpi(5), dpi(5)))

start_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awesome.emit_signal('widgets::start::toggle', mouse.screen)
            end
        )
    )
)

-- ########################################################################
-- ########################################################################
-- ########################################################################
widget.icon:set_image(PATH_TO_ICONS .. 'sidebar.svg')

return start_button
