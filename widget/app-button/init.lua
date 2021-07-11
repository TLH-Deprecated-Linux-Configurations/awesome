local wibox = require("wibox")
local clickable_container = require("widget.clickable-container")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local awful = require("awful")
local HOME = os.getenv("HOME")
local filesystem = require "gears.filesystem"

local PATH_TO_ICONS = HOME .. "/.config/awesome/widget/app-button/icons/"

local widget =
    wibox.widget {
    {
        id = "icon",
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}

local widget_button = clickable_container(wibox.container.margin(widget, dpi(2), dpi(2), 1, 1)) -- default top bottom margin is 7
widget_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn(
                    HOME ..
                        "/.config/awesome/bin/applauncher.sh " ..
                            screen.primary.dpi .. " " .. filesystem.get_configuration_dir()
                )
            end
        )
    )
)

-- Alternative to naughty.notify - tooltip. You can compare both and choose the preferred one
awful.tooltip(
    {
        objects = {widget_button},
        mode = "outside",
        align = "right",
        text = "System Application Menu"
    }
)

widget.icon:set_image(PATH_TO_ICONS .. "el-logo.svg")

return widget_button
