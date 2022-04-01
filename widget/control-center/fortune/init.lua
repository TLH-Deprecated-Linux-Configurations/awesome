-- Fortune
local fortune_command = "fortune -n 140 -s"
-- local fortune_command = "fortune -n 140 -s computers"
local fortune =
    wibox.widget {
    font = "SFP Pro Rounded Heavy 16",
    text = "Loading your cookie...",
    widget = wibox.widget.textbox
}

local fortune_update_interval = 3600
awful.widget.watch(
    fortune_command,
    fortune_update_interval,
    function(widget, stdout)
        -- Remove trailing whitespaces
        stdout = stdout:gsub("^%s*(.-)%s*$", "%1")
        fortune.text = stdout
    end
)

local fortune_widget =
    wibox.widget {
    {
        {
            {
                nil,
                fortune,
                layout = wibox.layout.align.horizontal
            },
            margins = dpi(12),
            widget = wibox.container.margin
        },
        widget = wibox.container.background,
        bg = beautiful.bg_focus
    },
    margins = dpi(4),
    widget = wibox.container.margin
}

return fortune_widget
