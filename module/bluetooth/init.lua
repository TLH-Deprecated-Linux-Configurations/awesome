--  ______ __               __                __   __
-- |   __ \  |.--.--.-----.|  |_.-----.-----.|  |_|  |--.
-- |   __ <  ||  |  |  -__||   _|  _  |  _  ||   _|     |
-- |______/__||_____|_____||____|_____|_____||____|__|__|
--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|
-- ------------------------------------------------- --

awful.screen.connect_for_each_screen(
    function(s)
        -- ------------------------------------------------- --
        bluetooth =
            wibox(
            {
                type = 'dock',
                shape = beautiful.client_shape_rounded_xl,
                screen = s,
                width = dpi(420),
                height = dpi(580),
                bg = beautiful.bg_color,
                margins = dpi(20),
                ontop = true,
                visible = false
            }
        )
        -- ------------------------------------------------- --
        -- -------------------- widgets -------------------- --

        local title =
            wibox.widget {
            {
                {
                    spacing = dpi(0),
                    layout = wibox.layout.align.vertical,
                    expand = 'max',
                    {
                        halign = 'center',
                        valign = 'center',
                        layout = wibox.layout.align.horizontal,
                        spacing = dpi(16),
                        require('widget.bluetooth.power-button'),
                        {
                            layout = wibox.container.place,
                            halign = 'center',
                            valign = 'center',
                            require('widget.bluetooth.title-text')
                        },
                        require('widget.bluetooth.search-button')
                    }
                },
                margins = dpi(10),
                widget = wibox.container.margin
            },
            shape = beautiful.client_shape_rounded_xl,
            bg = beautiful.bg_panel,
            forced_width = dpi(410),
            forced_height = dpi(70),
            ontop = true,
            border_width = dpi(2),
            border_color = colors.black,
            widget = wibox.container.background
        }
        -- ------------------------------------------------- --
        local devices_panel =
            wibox.widget {
            {
                {
                    layout = overflow.vertical(),
                    spacing = dpi(16),
                    require('widget.bluetooth.devices-panel')
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },
            shape = beautiful.client_shape_rounded_xl,
            bg = beautiful.bg_menu,
            forced_width = dpi(410),
            ontop = true,
            border_width = dpi(2),
            border_color = colors.colorA,
            widget = wibox.container.background
        }
        -- ------------------------------------------------- --
        local devices_text =
            wibox.widget {
            {
                {
                    spacing = dpi(0),
                    layout = wibox.layout.flex.vertical,
                    {
                        layout = wibox.layout.fixed.horizontal,
                        spacing = dpi(16),
                        require('widget.bluetooth.devices-text')
                    }
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },
            shape = beautiful.client_shape_rounded_xl,
            bg = beautiful.bg_panel,
            forced_width = dpi(410),
            forced_height = dpi(50),
            ontop = true,
            border_width = dpi(2),
            border_color = colors.black,
            widget = wibox.container.background
        }
        -- ------------------------------------------------- --
        -- ------------------- animations ------------------ --
        local slide_right =
            rubato.timed {
            pos = s.geometry.height,
            rate = 60,
            intro = 0.14,
            duration = 0.33,
            subscribed = function(pos)
                bluetooth.y = s.geometry.y + pos
            end
        }

        local slide_end =
            gears.timer(
            {
                single_shot = true,
                timeout = 0.33 + 0.08,
                callback = function()
                    bluetooth.visible = false
                end
            }
        )

        -- ------------------------------------------------- --
        --                   toggler script                  --
        -- ------------------------------------------------- --
        local screen_backup = 1

        bc_toggle = function(screen)
            -- NOTE set screen to default, if none were found
            if not screen then
                screen = awful.screen.focused()
            end

            -- NOTE control center x position
            bluetooth.x = screen.geometry.x + (dpi(1335) + beautiful.useless_gap * 4)

            -- NOTE  toggle visibility
            if bluetooth.visible then
                -- NOTE  check if screen is different or the same
                if screen_backup ~= screen.index then
                    bluetooth.visible = true
                else
                    slide_end:again()
                    slide_right.target = s.geometry.height
                end
            elseif not bluetooth.visible then
                slide_right.target = s.geometry.height - (bluetooth.height + beautiful.useless_gap * 2)
                bluetooth.visible = true
            end

            -- NOTE  set screen_backup to new screen
            screen_backup = screen.index
            -- ------------------------------------------------- --
            -- NOTE refresh the power status
            awesome.emit('bluetooth::power:refresh')
        end
        -- -------------------- Turn Off ------------------- --
        bc_off = function(screem)
            if bluetooth.visible then
                -- NOTE check if screen is different or the same
                slide_end:again()
                slide_right.target = s.geometry.height
            end
        end

        -- ------------------------------------------------- --
        --                   Initial setup                   --
        -- ------------------------------------------------- --
        bluetooth:setup {
            {
                {
                    {
                        nil,
                        title,
                        layout = wibox.layout.align.horizontal
                    },
                    devices_text,
                    devices_panel,
                    layout = wibox.layout.fixed.vertical,
                    spacing = dpi(24)
                },
                widget = wibox.container.margin,
                margins = dpi(20)
            },
            layout = wibox.layout.fixed.vertical
        }
    end
)
