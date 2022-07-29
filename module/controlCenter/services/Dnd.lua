-- wifi button/widget
-- ~~~~~~~~~~~~~~~~~~

-- requirements
-- ~~~~~~~~~~~~

-- misc/vars
-- ~~~~~~~~~

local service_name = "Silent"
local service_icon = icons.dont_disturb

-- widgets
-- ~~~~~~~

-- icon
local icon =
    wibox.widget {
    image = service_icon,
    widget = wibox.widget.imagebox,
    valign = "center",
    align = "center",
    forced_width = dpi(48),
    forced_height = dpi(48)
}

-- name
local name =
    wibox.widget {
    font = beautiful.font .. "12",
    widget = wibox.widget.textbox,
    text = service_name,
    valign = "center",
    align = "center"
}

-- animation :love:
local circle_animate =
    wibox.widget {
    widget = wibox.container.background,
    shape = beautiful.client_shape_rounded_xl,
    bg = beautiful.accent,
    forced_width = 110
}

-- mix those
local alright =
    wibox.widget {
    {
        {
            nil,
            {
                icon,
                top = dpi(14),
                bottom = dpi(14),
                left = dpi(24),
                right = dpi(24),
                widget = wibox.container.margin
            },
            layout = wibox.layout.align.vertical
        },
        layout = wibox.layout.stack
    },
    shape = beautiful.client_shape_rounded_xl,
    widget = clickable_container,
    forced_width = dpi(96),
    forced_height = dpi(96)
}

local animation_button_opacity =
    rubato.timed {
    pos = 0,
    rate = 60,
    intro = 0.08,
    duration = 0.3,
    awestore_compat = true,
    subscribed = function(pos)
        circle_animate.opacity = pos
    end
}

_G.awesome_dnd_state = false

local update_things = function()
    if _G.awesome_dnd_state then
        icon.text = service_icon
        name.text = service_name
        animation_button_opacity:set(1)
        naughty.notification({title = "Notifs disabled"})
    else
        icon.text = service_icon
        name.text = service_name
        animation_button_opacity:set(0)
        naughty.notification({title = "Notifs enabled"})
    end
end

-- reload old state
--~~~~~~~~~~~~~~~~~

local output = readwrite.readall("dnd_state")

local boolconverter = {
    ["true"] = true,
    ["false"] = false
}

awesome_dnd_state = boolconverter[output]
update_things()
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

alright:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                awesome_dnd_state = not awesome_dnd_state
                readwrite.write("dnd_state", tostring(_G.awesome_dnd_state))
                update_things()
            end
        )
    )
)

return alright
