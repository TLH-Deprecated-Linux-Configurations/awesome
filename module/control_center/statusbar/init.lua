-- requirements
-- ~~~~~~~~~~~~

-- widgets
-- ~~~~~~~
local battery = require("module.control_center.statusbar.battery")

---------------------------------------------------------- EOF Battery

-- clock
local clock = require("module.control_center.statusbar.clock")

-- extra control icon
local extras =
    wibox.widget {
    widget = wibox.widget.textbox,
    markup = "",
    font = "FontAwesome Regular Bold 20",
    valign = "center",
    align = "center"
}

local extra_shown = false

awesome.connect_signal(
    "control_center::extras",
    function(update)
        extra_shown = update
    end
)

extras:buttons {
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                if extra_shown then
                    show_extra_control_stuff()
                    extra_shown = false
                    extras.markup = ""
                else
                    extras.markup = ""
                    extra_shown = true
                    show_extra_control_stuff(true)
                end
            end
        )
    )
}

return wibox.widget {
    {
        clock,
        {
            widget = clickable_container,
            extras
        },
        battery,
        layout = wibox.layout.flex.horizontal
    },
    layout = wibox.layout.fixed.vertical,
    forced_height = dpi(60)
}
