local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local dpi = beautiful.xresources.apply_dpi

local width = dpi(200)
local height = dpi(200)
local screen = awful.screen.focused()

local active_color_1 = {
    type = "linear",
    from = {0, 0},
    to = {200, 50}, -- replace with w,h later
    stops = {{0, "#e9efff"}, {0.50, "#f4f4f7"}}
}

local bright_icon =
    wibox.widget {
    markup = "<span foreground='#f4f4f7'><b></b></span>",
    align = "center",
    valign = "center",
    font = "Nineteen Ninety Seven 82",
    widget = wibox.widget.textbox
}

-- create the bright_adjust component
local bright_adjust =
    wibox(
    {
        screen = screen.primary,
        type = "notification",
        x = screen.geometry.width / 2 - width / 2,
        y = screen.geometry.height / 2 - height / 2 + 300,
        width = width,
        height = height,
        visible = false,
        ontop = true,
        bg = "#1b1d2488"
    }
)

local bright_bar =
    wibox.widget {
    widget = wibox.widget.progressbar,
    shape = gears.shape.rounded_bar,
    bar_shape = gears.shape.rounded_bar,
    color = active_color_1,
    background_color = "#3c3f4c88",
    max_value = 100,
    value = 0
}

bright_adjust:setup {
    {
        layout = wibox.layout.align.vertical,
        {
            bright_icon,
            top = dpi(15),
            left = dpi(50),
            right = dpi(50),
            bottom = dpi(15),
            widget = wibox.container.margin
        },
        {
            bright_bar,
            left = dpi(25),
            right = dpi(25),
            bottom = dpi(30),
            widget = wibox.container.margin
        }
    },
    shape = beautiful.client_shape_rounded_xl,
    bg = "#1b1d24aa",
    border_width = dpi(2),
    border_color = "#2f303daa",
    widget = wibox.container.background
}

-- create a 3 second timer to hide the volume adjust
-- component whenever the timer is started
local hide_bright_adjust =
    gears.timer {
    timeout = 3,
    autostart = true,
    callback = function()
        bright_adjust.visible = false
    end
}

awesome.connect_signal(
    "signal::brightness",
    function(value)
        bright_bar.value = value
        if bright_adjust.visible then
            hide_bright_adjust:again()
        else
            bright_adjust.visible = true
            hide_bright_adjust:start()
        end
    end
)
