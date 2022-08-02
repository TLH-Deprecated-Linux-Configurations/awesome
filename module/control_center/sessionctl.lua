-- session buttons
-- ~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local wibox = require("wibox")
local gears = require("gears")

-- widgets
-- ~~~~~~~

-- lockscreen button
local lock_button =
    wibox.widget {
    {
        widget = wibox.widget.textbox,
        text = "",
        font = "FontAwesome Regular 28",
        align = "center",
        valign = "center"
    },
    widget = wibox.container.margin,
    margins = dpi(8)
}

-- exitscreen button
local power_button =
    wibox.widget {
    {
        widget = wibox.widget.imagebox,
        image = icons.power,
        forced_height = dpi(36),
        forced_width = dpi(36),
        align = "center",
        valign = "center"
    },
    widget = wibox.container.margin,
    margins = dpi(8)
}

-- add function to them
-- ~~~~~~~~~~~~~~~~~~~~
power_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                awesome.emit_signal("module::exit_screen:show")
            end
        )
    )
)

lock_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                if control_c.visible then
                    cc_toggle()
                end
                require("layout.lockscreen").init()
                lock_screen_show()
            end
        )
    )
)

--~~~~~~~~~~~~~~~~~~~
--~~~~~~~~~~~~~~~~~~~
return wibox.widget {
    nil,
    {
        {
            clickable_container(lock_button, beautiful.bg_button, dpi(13), 0, beautiful.fg_color .. "33"),
            clickable_container(power_button, beautiful.bg_button, dpi(13), 0, beautiful.fg_color .. "33"),
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(10)
        },
        layout = wibox.layout.fixed.vertical
    },
    layout = wibox.layout.flex.vertical,
    expand = "none"
}
