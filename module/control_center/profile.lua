-- profile widget
-- ~~~~~~~~~~~~~~

-- image
local profile_image =
    wibox.widget {
    {
        image = config_dir .. '/themes/icons/svg/logo.png',
        clip_shape = beautiful.client_shape_rounded_xl,
        widget = wibox.widget.imagebox
    },
    widget = wibox.container.background,
    bg = beautiful.bg_button,
    border_width = dpi(1),
    forced_width = dpi(125),
    forced_height = dpi(125),
    shape = beautiful.client_shape_rounded_xl,
    border_color = colors.black
}

-- username
local username =
    wibox.widget {
    widget = wibox.widget.textbox,
    text = os.getenv('USER'),
    font = beautiful.font .. ' Regular  13',
    align = 'left',
    valign = 'center'
}

-- description/host
local desc =
    wibox.widget {
    widget = wibox.widget.textbox,
    text = '@AwesomeWM',
    font = beautiful.font .. ' Bold 11',
    align = 'left',
    valign = 'center'
}

-- return
return wibox.widget {
    profile_image,
    {
        nil,
        {
            username,
            desc,
            layout = wibox.layout.fixed.vertical,
            spacing = dpi(2)
        },
        layout = wibox.layout.align.vertical,
        expand = 'none'
    },
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(15)
}
