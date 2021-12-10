--  _______         __ __        _______
-- |    ___|.--.--.|__|  |_     |     __|.----.----.-----.-----.-----.
-- |    ___||_   _||  |   _|    |__     ||  __|   _|  -__|  -__|     |
-- |_______||__.__||__|____|    |_______||____|__| |_____|_____|__|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Appearance
local icon_size = beautiful.exit_screen_icon_size or dpi(90)
local exit_screen_hide

local text = "Exit Menu"

local user_name =
    wibox.widget {
    font = beautiful.font .. " 48",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
awful.spawn.easy_async_with_shell(
    "whoami",
    function(stdout)
        if stdout then
            local username

            user_name:set_markup(text)
        end
    end,
    false
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local buildButton = function(icon, name)
    local button_text =
        wibox.widget {
        text = name,
        font = beautiful.font .. " 14",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local abutton =
        wibox.widget {
        {
            {
                {
                    {image = icon, widget = wibox.widget.imagebox},
                    margins = dpi(0),
                    widget = wibox.container.margin
                },
                bg = beautiful.groups_bg,
                widget = wibox.container.background
            },
            shape = gears.shape.rounded_rect,
            forced_width = icon_size,
            forced_height = icon_size,
            widget = clickable_container
        },
        left = dpi(24),
        right = dpi(24),
        widget = wibox.container.margin
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local buildabutton =
        wibox.widget {
        layout = wibox.layout.fixed.vertical,
        spacing = dpi(5),
        abutton,
        button_text
    }

    return buildabutton
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local suspend_command = function()
    print("Suspending")
    exit_screen_hide()
    awful.spawn.with_shell(apps.default.lock)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local exit_command = function()
    print("Stopping the Electric Tantra Linux")
    _G.awesome.quit()
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local lock_command = function()
    print("Locking computer")
    exit_screen_hide()
    awful.spawn.with_shell("sleep 1 && " .. apps.default.lock)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local poweroff_command = function()
    print("Powering off")
    awful.spawn.with_shell("poweroff")
    signals.emit_module_exit_screen_hide()
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local reboot_command = function()
    print("Rebooting")
    awful.spawn.with_shell("reboot")
    signals.emit_module_exit_screen_hide()
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local bios_command = function()
    print("Rebooting to the BIOS Menu")
    awful.spawn.with_shell("systemctl reboot --firmware-setup")
    signals.emit_module_exit_screen_hide()
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local hide_screen_command = function()
    print("Hiding exit screen")
    signals.emit_module_exit_screen_hide()
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local ignore = buildButton(icons.close, "Return")
ignore:connect_signal(
    "button::release",
    function()
        hide_screen_command()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local poweroff = buildButton(icons.power, "Shutdown")
poweroff:connect_signal(
    "button::release",
    function()
        poweroff_command()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local reboot = buildButton(icons.refresh, "Restart")
reboot:connect_signal(
    "button::release",
    function()
        reboot_command()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local suspend = buildButton(icons.sleep, "Sleep")
suspend:connect_signal(
    "button::release",
    function()
        suspend_command()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local exit = buildButton(icons.logout, "Logout")
exit:connect_signal(
    "button::release",
    function()
        exit_command()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local lock = buildButton(icons.lock, "Lock")
lock:connect_signal(
    "button::release",
    function()
        lock_command()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local bios = buildButton(icons.bios, "BIOS")
bios:connect_signal(
    "button::release",
    function()
        bios_command()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Create exit screen on every screen
screen.connect_signal(
    "request::desktop_decoration",
    function(s)
        -- Get screen geometry
        local screen_geometry = s.geometry

        -- Create the widget
        s.exit_screen =
            wibox {
            screen = s,
            visible = false,
            ontop = true,
            height = screen_geometry.height,
            maximum_height = screen_geometry.height,
            maximum_width = screen_geometry.width,
            width = screen_geometry.width,
            placement = awful.placement.center,
            x = screen_geometry.x,
            y = screen_geometry.y
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        s.exit_screen.bg = beautiful.bg_normal .. "88"
        s.exit_screen.fg = beautiful.xforeground or "#FEFEFE"
        s.exit_screen.x = s.geometry.x
        s.exit_screen.y = s.geometry.y
        s.exit_screen.width = s.geometry.width
        s.exit_screen.maximum_width = s.geometry.width
        s.exit_screen.height = s.geometry.height
        s.exit_screen.maximum_height = s.geometry.height
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################

        screen.connect_signal(
            "removed",
            function(removed)
                if s == removed then
                    s.exit_screen.visible = false
                    s.exit_screen = nil
                end
            end
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################

        signals.connect_refresh_screen(
            function()
                print("Refreshing exit screen")
                if not s.valid then
                    return
                end

                s.exit_screen.x = s.geometry.x
                s.exit_screen.y = s.geometry.y
                s.exit_screen.width = s.geometry.width
                s.exit_screen.maximum_width = s.geometry.width
                s.exit_screen.height = s.geometry.height
                s.exit_screen.maximum_height = s.geometry.height
            end
        )

        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        local exit_screen_grabber =
            awful.keygrabber {
            auto_start = false,
            stop_event = "release",
            keypressed_callback = function(_, _, key, _)
                if key == "s" then
                    suspend_command()
                elseif key == "e" then
                    exit_command()
                elseif key == "l" then
                    lock_command()
                elseif key == "p" then
                    poweroff_command()
                elseif key == "r" then
                    reboot_command()
                elseif key == "b" then
                    bios_command()
                elseif key == "Escape" or key == "q" or key == "x" then
                    signals.emit_module_exit_screen_hide()
                end
            end
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Hide exit screen
        exit_screen_hide = function()
            exit_screen_grabber:stop()

            -- Hide exit_screen in all screens
            for scrn in screen do
                scrn.exit_screen.visible = false
            end
            s.exit_screen.visible = false
        end
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Exit screen show
        _G.exit_screen_show = function()
            print("Showing exit screen ---")
            exit_screen_grabber:start()
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################
            -- It makes more sense to have both screens show the menu than just one while the other screen is normal
            for scrn in screen do
                scrn.exit_screen.visible = true
            end

            -- ########################################################################
            -- ########################################################################
            -- ########################################################################
            animate(
                _G.anim_speed,
                s.exit_screen,
                {
                    y = screen_geometry.y,
                    height = screen_geometry.height,
                    opacity = 1
                },
                "outCubic"
            )
        end
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Signals
        signals.connect_module_exit_screen_show(
            function()
                print("Showing exit screen")

                -- turn of the left panel so we can consume the keygrabber
                _G.screen.left_panel:HideDashboard()

                _G.exit_screen_show()
            end
        )

        signals.connect_module_exit_screen_hide(
            function()
                print("Hiding exit screen")
                exit_screen_hide()
            end
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        s.exit_screen:buttons(
            gears.table.join( -- Middle click - Hide exit_screen
                awful.button(
                    {},
                    2,
                    function()
                        exit_screen_hide()
                    end
                ),
                -- Right click - Hide exit_screen
                awful.button(
                    {},
                    3,
                    function()
                        exit_screen_hide()
                    end
                )
            )
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Item placement
        s.exit_screen:setup {
            nil,
            {
                nil,
                {
                    user_name,
                    {
                        ignore,
                        poweroff,
                        reboot,
                        suspend,
                        exit,
                        lock,
                        bios,
                        layout = wibox.layout.fixed.horizontal
                    },
                    spacing = dpi(80),
                    layout = wibox.layout.fixed.vertical
                },
                nil,
                expand = "none",
                layout = wibox.layout.align.horizontal
            },
            nil,
            expand = "none",
            layout = wibox.layout.align.vertical
        }
    end
)
