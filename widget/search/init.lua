--  _______                         __
-- |     __|.-----.---.-.----.----.|  |--.
-- |__     ||  -__|  _  |   _|  __||     |
-- |_______||_____|___._|__| |____||__|__|

local wibox = require('wibox')
local clickable_container = require('widget.material.clickable-container')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local apps = require('configuration.apps')
local theme = require('theme.icons')
local HOME = os.getenv('HOME')
-- acpi sample outputs
-- Battery 0: Discharging, 75%, 01:51:38 remaining
-- Battery 0: Charging, 53%, 00:57:43 until charged
-- ########################################################################
-- ########################################################################
-- ########################################################################
local PATH_TO_ICONS = HOME .. '/.config/awesome/widget/search/icons/'

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
local widget_button = clickable_container(wibox.container.margin(widget, dpi(10), dpi(10), dpi(5), dpi(5))) -- 4 is top and bottom margin
widget_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                --awful.spawn('blueberry')
                awful.spawn(apps.default.rofiappmenu)
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
widget.icon:set_image(PATH_TO_ICONS .. 'search' .. '.svg')

-- To use colors from beautiful theme put
-- following lines in rc.lua before require("battery"):
--beautiful.tooltip_fg = beautiful.fg_normal
--beautiful.tooltip_bg = beautiful.bg_normal
-- ########################################################################
-- ########################################################################
-- ########################################################################
return widget_button
