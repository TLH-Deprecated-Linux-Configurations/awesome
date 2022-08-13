--  _____             _______         __
-- |     \.-----.    |    |  |.-----.|  |_
-- |  --  |  _  |    |       ||  _  ||   _|
-- |_____/|_____|    |__|____||_____||____|

--  _____  __         __               __
-- |     \|__|.-----.|  |_.--.--.----.|  |--.
-- |  --  |  ||__ --||   _|  |  |   _||  _  |
-- |_____/|__||_____||____|_____|__|  |_____|
-- ------------------------------------------------- --

-- ------------------- variables ------------------- --
local service_name = 'Silent'
local service_icon = icons.notifications
-- ------------------------------------------------- --
-- ---------------------- icon --------------------- --
local icon =
    wibox.widget {
    image = service_icon,
    widget = wibox.widget.imagebox,
    valign = 'center',
    align = 'center',
    forced_width = dpi(48),
    forced_height = dpi(48)
}
-- ------------------------------------------------- --
-- ---------------------- name --------------------- --
local name =
    wibox.widget {
    font = beautiful.font .. '12',
    widget = wibox.widget.textbox,
    text = service_name,
    valign = 'center',
    align = 'center'
}
-- ------------------------------------------------- --
-- --------------------- button -------------------- --
local dnd_button =
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

_G.awesome_dnd_state = false

local update_things = function()
    if _G.awesome_dnd_state then
        icon.text = service_icon
        naughty.notification({title = 'Notifications', text = 'Notifications are disabled.'})
    else
        icon.text = service_icon
        naughty.notification({title = 'Notifications', text = 'Notifications are enabled.'})
    end
end

-- reload old state
--~~~~~~~~~~~~~~~~~

local output = readwrite.readall('dnd_state')

local boolconverter = {
    ['true'] = true,
    ['false'] = false
}

awesome_dnd_state = boolconverter[output]
update_things()
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

dnd_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                not_toggle()
            end
        ),
        awful.button(
            {},
            3,
            function()
                awesome_dnd_state = not awesome_dnd_state
                readwrite.write('dnd_state', tostring(_G.awesome_dnd_state))
                update_things()
            end
        )
    )
)

return dnd_button
