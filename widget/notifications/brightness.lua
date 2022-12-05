--  __           __   __
-- |  |--.---.-.|  |_|  |_.-----.----.--.--.
-- |  _  |  _  ||   _|   _|  -__|   _|  |  |
-- |_____|___._||____|____|_____|__| |___  |
--                                   |_____|
--               __   __   ___ __              __   __
-- .-----.-----.|  |_|__|.'  _|__|.----.---.-.|  |_|__|.-----.-----.-----.
-- |     |  _  ||   _|  ||   _|  ||  __|  _  ||   _|  ||  _  |     |__ --|
-- |__|__|_____||____|__||__| |__||____|___._||____|__||_____|__|__|_____|
-- ------------------------------------------------- --
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
wibox.widget(
    {
        id = 'popup_icon',
        image = icons.brightness,
        align = 'center',
        forced_height = dpi(72),
        forced_width = dpi(72),
        valign = 'center',
        widget = wibox.widget.imagebox()
    }
)

-- create the bright_adjust component
local bright_adjust =
    wibox(
    {
        -- screen = screen.focused,
        type = "notification",
        x = screen.geometry.width / 2 - width / 2,
        y = screen.geometry.height / 2 - height / 2 + 300,
        width = width,
        height = height,
        visible = false,
        ontop = true,
        bg = colors.alpha(colors.black, "88")
    }
)
-- ------------------------------------------------- --

local bright_bar =
    wibox.widget {
    widget = wibox.widget.progressbar,
    shape = gears.shape.rounded_bar,
    bar_shape = gears.shape.rounded_bar,
    color = colors.white,
    background_color = colors.alpha(colors.colorH, "88"),
    max_value = 100,
    value = 100
}
-- ------------------------------------------------- --
bright_adjust:setup {
    {
        layout = wibox.layout.align.vertical,
        {
            bright_icon,
            top = dpi(35),
            left = dpi(65),
            right = dpi(65),
            bottom = dpi(35),
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
    bg = colors.alpha(colors.black, "88"),
    border_width = dpi(2),
    border_color = colors.alpha(colors.colorA, "aa"),
    widget = wibox.container.background
}
-- ------------------------------------------------- --
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


-- ------------------------------------------------- --
local update_slider = function(percentage)
    local brightness = percentage
    if bright_adjust.visible then
        hide_bright_adjust:again()
    else
        bright_adjust.visible = true
        hide_bright_adjust:start()
    end
    
    if brightness ~= nil then
        bright_bar:set_value(brightness)
    end
end
-- ------------------------------------------------- --

awesome.connect_signal(
    "signal::brightness",
    function(percentage)
        if percentage ~= nil then
            update_slider(percentage)
        end
    end
)
