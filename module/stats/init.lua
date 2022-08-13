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
        stats =
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
        -- widgets

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
                        require('widget.stats.power-button'),
                        {
                            layout = wibox.container.place,
                            halign = 'center',
                            valign = 'center',
                            require('widget.stats.title-text')
                        },
                        require('widget.stats.search-button')
                    }
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },
            shape = beautiful.client_shape_rounded_xl,
            bg = beautiful.bg_normal,
            forced_width = dpi(410),
            forced_height = dpi(60),
            ontop = true,
            border_width = dpi(2),
            border_color = colors.colorA,
            widget = wibox.container.background
        }
        -- ------------------------------------------------- --
        local devices_panel =
            wibox.widget {
            {
                {
                    layout = overflow.vertical(),
                    spacing = dpi(16),
                    require('widget.stats.devices-panel')
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
                        require('widget.stats.devices-text')
                    }
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },
            shape = beautiful.client_shape_rounded_xl,
            bg = beautiful.bg_normal,
            forced_width = dpi(410),
            forced_height = 70,
            ontop = true,
            border_width = dpi(2),
            border_color = beautiful.bg_normal,
            widget = wibox.container.background
        }
        -- animations
        --------------
        local slide_right =
            rubato.timed {
            pos = s.geometry.height,
            rate = 60,
            intro = 0.14,
            duration = 0.33,
            subscribed = function(pos)
                stats.y = s.geometry.y + pos
            end
        }

        local slide_end =
            gears.timer(
            {
                single_shot = true,
                timeout = 0.33 + 0.08,
                callback = function()
                    stats.visible = false
                end
            }
        )

        -- toggler script
        --~~~~~~~~~~~~~~~
        local screen_backup = 1

        bc_toggle = function(screen)
            -- set screen to default, if none were found
            if not screen then
                screen = awful.screen.focused()
            end

            -- control center x position
            stats.x = screen.geometry.x + (dpi(1048) + beautiful.useless_gap * 4)

            -- toggle visibility
            if stats.visible then
                -- check if screen is different or the same
                if screen_backup ~= screen.index then
                    stats.visible = true
                else
                    slide_end:again()
                    slide_right.target = s.geometry.height
                end
            elseif not stats.visible then
                slide_right.target = s.geometry.height - (stats.height + beautiful.useless_gap * 2)
                stats.visible = true
            end

            -- set screen_backup to new screen
            screen_backup = screen.index
        end
        -- Eof toggler script
        --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        -- function to show/hide extra buttons
        -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        -- Initial setup
        stats:setup {
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
