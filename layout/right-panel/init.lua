local HOME = os.getenv("HOME")
local wibox = require("wibox")
local gears = require("gears")

local dpi = require("beautiful").xresources.apply_dpi
local clickable_container = require("widget.clickable-container")
local PATH_TO_ICONS = HOME .. "/.config/awesome/layout/right-panel/icons/"
local theme = require("theme.icons")

-- Load panel rules, it will create panel for each screen
require("layout.right-panel.panel-rules")

local widget =
    wibox.widget {
    {
        id = "icon",
        image = PATH_TO_ICONS .. "notification" .. ".svg",
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}

local widget_button = clickable_container(wibox.container.margin(widget, dpi(7), dpi(7), dpi(7), dpi(7))) -- 4 is top and bottom margin
widget_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                _G.screen.primary.right_panel:toggle()
            end
        )
    )
)

return widget_button
