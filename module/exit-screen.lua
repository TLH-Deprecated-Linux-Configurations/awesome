--  _______         __ __        _______
-- |    ___|.--.--.|__|  |_     |     __|.----.----.-----.-----.-----.
-- |    ___||_   _||  |   _|    |__     ||  __|   _|  -__|  -__|     |
-- |_______||__.__||__|____|    |_______||____|__| |_____|_____|__|__|

-- ########################################################################
-- ########################################################################
-- ########################################################################
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')

local dpi = require('beautiful').xresources.apply_dpi

local icons = require('theme.icons')
local apps = require('configuration.apps')
local clickable_container = require('widget.clickable-container')
local signals = require('module.signals')

local animate = require('lib.animations').createAnimObject
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Appearance
local icon_size = beautiful.exit_screen_icon_size or dpi(90)
local exit_screen_hide

local text = 'Goodbye for Now'

local user_name =
    wibox.widget {
    font = beautiful.font .. ' 48',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
awful.spawn.easy_async_with_shell(
    'whoami',
    function(stdout)
        if stdout then
            -- Remove new line
            local username = stdout:gsub('', '')

            -- Capitalize first letter of username
            -- Comment it if you're not using your name as your username
            username = username:sub(1, 1):upper() .. username:sub(2)

            user_name:set_markup(text .. username .. '!')
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
        font = beautiful.font,
        align = 'center',
        valign = 'center',
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
                    {
                        image = icon,
                        widget = wibox.widget.imagebox
                    },
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
    print('Suspending')
    exit_screen_hide()
    awful.spawn.with_shell(apps.default.lock)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local exit_command = function()
    print('Stopping the Electric Tantra Linux')
    _G.awesome.quit()
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local lock_command = function()
    print('Locking computer')
    exit_screen_hide()
    awful.spawn.with_shell('sleep 1 && ' .. apps.default.lock)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local poweroff_command = function()
    print('Powering off')
    awful.spawn.with_shell('poweroff')
    signals.emit_module_exit_screen_hide()
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local reboot_command = function()
    print('Rebooting')
    awful.spawn.with_shell('reboot')
    signals.emit_module_exit_screen_hide()
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local bios_command = function()
    print('Telling firmware to boot into the bios...')
    awful.spawn.with_shell('systemctl reboot --firmware-setup')
    signals.emit_module_exit_screen_hide()
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local hide_screen_command = function()
    print('Hiding exit screen')
    signals.emit_module_exit_screen_hide()
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local ignore = buildButton(icons.close, 'Return')
ignore:connect_signal(
    'button::release',
    function()
        hide_screen_command()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local poweroff = buildButton(icons.power, 'Shutdown')
poweroff:connect_signal(
    'button::release',
    function()
        poweroff_command()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local reboot = buildButton(icons.restart, 'Restart')
reboot:connect_signal(
    'button::release',
    function()
        reboot_command()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local suspend = buildButton(icons.sleep, 'Sleep')
suspend:connect_signal(
    'button::release',
    function()
        suspend_command()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local exit = buildButton(icons.logout, 'Logout')
exit:connect_signal(
    'button::release',
    function()
        exit_command()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local lock = buildButton(icons.lock, 'Lock')
lock:connect_signal(
    'button::release',
    function()
        lock_command()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local bios = buildButton(icons.bios, 'BIOS')
bios:connect_signal(
    'button::release',
    function()
        bios_command()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Create exit screen on every screen
screen.connect_signal(
    'request::desktop_decoration',
    function(s)
        -- Get screen geometry
        local screen_geometry = s.geometry

        -- Create the widget
        s.exit_screen =
            wibox {
            screen = s,
            type = 'splash',
            visible = false,
            ontop = true,
            height = screen_geometry.height,
            width = screen_geometry.width,
            x = screen_geometry.x,
            y = screen_geometry.y
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        s.exit_screen.bg = beautiful.bg_normal
        s.exit_screen.fg = beautiful.xforeground or '#FEFEFE'
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################

        screen.connect_signal(
            'removed',
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
                print('Refreshing exit screen')
                if not s.valid then
                    return
                end

                -- the action center itself
                s.exit_screen.x = s.geometry.x
                s.exit_screen.y = s.geometry.y
                s.exit_screen.width = s.geometry.width
                s.exit_screen.height = s.geometry.height
            end
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        signals.connect_background_theme_changed(
            function(theme)
                s.exit_screen.bg = theme.hue_800 .. beautiful.background_transparency
            end
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        local exit_screen_grabber =
            awful.keygrabber {
            auto_start = false,
            stop_event = 'release',
            keypressed_callback = function(_, _, key, _)
                if key == 's' then
                    suspend_command()
                elseif key == 'e' then
                    exit_command()
                elseif key == 'l' then
                    lock_command()
                elseif key == 'p' then
                    poweroff_command()
                elseif key == 'r' then
                    reboot_command()
                elseif key == 'b' then
                    bios_command()
                elseif key == 'Escape' or key == 'q' or key == 'x' then
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
            print('Showing exit screen ---')
            exit_screen_grabber:start()
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################
            -- Hide exit_screen in all screens to avoid duplication
            for scrn in screen do
                scrn.exit_screen.visible = false
            end
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################
            -- Then open it in the focused one
            local exit_scrn = awful.screen.focused().exit_screen
            exit_scrn.visible = true

            exit_scrn.y = screen_geometry.y - screen_geometry.height
            exit_scrn.opacity = 0
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################
            animate(
                _G.anim_speed,
                exit_scrn,
                {
                    y = screen_geometry.y,
                    opacity = 1
                },
                'outCubic'
            )
        end
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Signals
        signals.connect_module_exit_screen_show(
            function()
                print('Showing exit screen')

                -- turn of the left panel so we can consume the keygrabber
                _G.screen.primary.left_panel:HideDashboard()

                _G.exit_screen_show()
            end
        )

        signals.connect_module_exit_screen_hide(
            function()
                print('Hiding exit screen')
                exit_screen_hide()
            end
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        s.exit_screen:buttons(
            gears.table.join(
                -- Middle click - Hide exit_screen
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
                    spacing = dpi(40),
                    layout = wibox.layout.fixed.vertical
                },
                nil,
                expand = 'none',
                layout = wibox.layout.align.horizontal
            },
            nil,
            expand = 'none',
            layout = wibox.layout.align.vertical
        }
    end
)
