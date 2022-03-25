--  ___ ___         __
-- |   |   |.-----.|  |.--.--.--------.-----.
-- |   |   ||  _  ||  ||  |  |        |  -__|
--  \_____/ |_____||__||_____|__|__|__|_____|

--               __   __   ___ __              __   __
-- .-----.-----.|  |_|__|.'  _|__|.----.---.-.|  |_|__|.-----.-----.-----.
-- |     |  _  ||   _|  ||   _|  ||  __|  _  ||   _|  ||  _  |     |__ --|
-- |__|__|_____||____|__||__| |__||____|___._||____|__||_____|__|__|_____|

local dpi = beautiful.xresources.apply_dpi

local width = dpi(200)
local height = dpi(200)
local screen = awful.screen.focused()

local active_color_1 = {
    type = "linear",
    from = {0, 0},
    to = {200, 50}, -- replace with w,h later
    stops = {{0, colors.lesswhite}, {0.50, colors.white}}
}

local volume_icon =
    wibox.widget {
    markup = "<span foreground='" .. colors.white .. "'><b></b></span>",
    align = "center",
    valign = "center",
    font = "SFMono Nerd Font Mono Bold  64",
    widget = wibox.widget.textbox
}

-- create the volume_adjust component
local volume_adjust =
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

local volume_bar =
    wibox.widget {
    widget = wibox.widget.progressbar,
    shape = gears.shape.rounded_bar,
    bar_shape = gears.shape.rounded_bar,
    color = colors.white,
    background_color = colors.alpha(colors.color1, "88"),
    max_value = 100,
    value = 100,
    forced_height = dpi(25),
    height = dpi(25),
    forced_width = dpi(200)
}

volume_adjust:setup {
    {
        layout = wibox.layout.align.vertical,
        {
            volume_icon,
            top = dpi(15),
            left = dpi(50),
            right = dpi(50),
            bottom = dpi(15),
            widget = wibox.container.margin
        },
        {
            volume_bar,
            left = dpi(25),
            right = dpi(25),
            bottom = dpi(30),
            widget = wibox.container.margin
        }
    },
    shape = beautiful.client_shape_rounded_xl,
    bg = colors.alpha(colors.black, "aa"),
    border_width = dpi(2),
    border_color = colors.alpha(colors.colorA, "aa"),
    widget = wibox.container.background
}

-- create a 3 second timer to hide the volume adjust
-- component whenever the timer is started
local hide_volume_adjust =
    gears.timer {
    timeout = 3,
    autostart = true,
    callback = function()
        volume_adjust.visible = false
    end
}
local update_mute = function()
    awful.spawn.easy_async_with_shell(
        [["pamixer --get-mute"]],
        function(stdout)
            if stdout ~= nil then
                local status = string.match(stdout, "%a+")
                if stdout == "true" then
                    volume_icon.txt = ""
                elseif status == "false" then
                    volume_icon.txt = ""
                end
            end
        end
    )
end

awesome.connect_signal(
    "signal::volume:mute",
    function()
        update_mute()
    end
)
awesome.connect_signal(
    "signal::volume:unmute",
    function()
        update_mute()
    end
)

local update_slider = function()
    awful.spawn.with_line_callback(
        "pamixer --get-volume",
        -- ------------------------------------------------- --
        {
            stdout = function(value)
                local volume = tonumber(value)
                update_mute()
                if volume_adjust.visible == false then
                    volume_adjust.visible = true
                    hide_volume_adjust:start()
                else
                    hide_volume_adjust:again()
                end
                if volume >= 0 and volume <= 100 and volume ~= nil then
                    volume_bar:set_value(volume)
                end
            end
        }
    )
end
update_slider()

awesome.connect_signal(
    "signal::volume:update",
    function(percentage)
        if percentage ~= nil then
            update_slider()
        end
    end
)
