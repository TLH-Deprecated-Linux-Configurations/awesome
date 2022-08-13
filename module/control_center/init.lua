--  ______               __               __
-- |      |.-----.-----.|  |_.----.-----.|  |
-- |   ---||  _  |     ||   _|   _|  _  ||  |
-- |______||_____|__|__||____|__| |_____||__|
--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|
-- ------------------------------------------------- --
awful.screen.connect_for_each_screen(
    function(s)
        -- ------------------------------------------------- --
        --                 initialize widget                 --
        -- ------------------------------------------------- --
        control_c =
            wibox(
            {
                type = 'dock',
                shape = beautiful.client_shape_rounded_xl,
                screen = s,
                width = dpi(420),
                bg = beautiful.bg_normal,
                margins = dpi(20),
                ontop = true,
                visible = false
            }
        )
        -- ------------------------------------------------- --
        -- ------------------ widget calls ----------------- --

        local profile = require('module.control_center.profile')
        local sessions = require('module.control_center.sessionctl')
        local sliders = require('module.control_center.sliders')

        local services = require('module.control_center.services')
        local statusline = require('module.control_center.statusbar')

        -- ------------------------------------------------- --
        -- ------------------- animations ------------------ --
        local slide_right =
            rubato.timed {
            pos = s.geometry.height,
            rate = 60,
            intro = 0.14,
            duration = 0.33,
            subscribed = function(pos)
                control_c.y = s.geometry.y + pos
            end
        }

        local slide_end =
            gears.timer(
            {
                single_shot = true,
                timeout = 0.33 + 0.08,
                callback = function()
                    control_c.visible = false
                end
            }
        )

        -- end initialize widget

        -- ------------------------------------------------- --
        --                   toggler script                  --
        -- ------------------------------------------------- --
        local screen_backup = 1

        cc_toggle = function(screen)
            -- set screen to default, if none were found
            if not screen then
                screen = awful.screen.focused()
            end
            -- ------------------------------------------------- --
            -- control center x position
            control_c.x = screen.geometry.x + (dpi(48) + beautiful.useless_gap * 4)
            -- ------------------------------------------------- --
            -- toggle visibility
            if control_c.visible then
                -- ------------------------------------------------- --
                -- insure the keygrabber doesn't stick
                awful.keygrabber.stop()

                -- ------------------------------------------------- --
                -- check if screen is different or the same
                if screen_backup ~= screen.index then
                    control_c.visible = true
                else
                    slide_end:again()
                    slide_right.target = s.geometry.height
                end
            elseif not control_c.visible then
                slide_right.target = s.geometry.height - (control_c.height + beautiful.useless_gap * 2)
                control_c.visible = true
                -- ------------------------------------------------- --
                -- ----------------- run keygrabber ---------------- --
                awful.keygrabber.run(
                    function(_, key, event)
                        if event == 'release' then
                            return
                        end
                        -- ------------------------------------------------- --
                        -- set keygrabber to grab Escape, q or x to close cc
                        if key == 'Escape' or key == 'q' or key == 'x' then
                            if screen_backup ~= screen.index then
                                control_c.visible = true
                            else
                                -- ------------------------------------------------- --
                                -- close animations with keygrabber stop command
                                slide_end:again()
                                slide_right.target = s.geometry.height
                                awful.keygrabber.stop()
                                -- ------------------------------------------------- --
                                -- turn off notifications center
                                not_off(s)
                                -- ------------------------------------------------- --
                                -- turn off bluetooth
                                bc_off(s)
                                -- ------------------------------------------------- --
                                -- turn off networkgit
                                net_off(s)
                            end
                        end
                        if key == 'b' then
                            awesome.emit_signal('bluetooth::devices:refreshPanel')
                            bc_toggle()
                        end
                        if key == 'n' then
                            nc_toggle()
                            awesome.emit_signal('network::networks:refreshPanel')
                        end
                        if key == 'm' then
                            not_toggle()
                        end
                    end
                )
            end

            -- set screen_backup to new screen
            screen_backup = screen.index
        end
        -- Eof toggler script

        -- ------------------------------------------------- --
        --                     Functions                     --
        -- ------------------------------------------------- --

        -- ------ function to show/hide extra buttons ------ --
        function show_extra_control_stuff(input)
            if input then
                awesome.emit_signal('control_center::extras', true)
                control_c.height = dpi(705)
                readwrite.write('cc_state', 'open')
            else
                awesome.emit_signal('control_center::extras', false)
                control_c.height = dpi(580)
                readwrite.write('cc_state', 'closed')
            end
            slide_right.target = s.geometry.height - (control_c.height + beautiful.useless_gap * 2)
        end
        -- ------------------------------------------------- --
        -- ----------------- Initial setup ----------------- --
        control_c:setup {
            {
                {
                    {
                        profile,
                        nil,
                        sessions,
                        layout = wibox.layout.align.horizontal
                    },
                    sliders,
                    services,
                    layout = wibox.layout.fixed.vertical,
                    spacing = dpi(24)
                },
                widget = wibox.container.margin,
                margins = dpi(20)
            },
            {
                statusline,
                margins = {left = dpi(20), right = dpi(20), bottom = dpi(0), top = dpi(0)},
                widget = wibox.container.margin
            },
            layout = wibox.layout.fixed.vertical
        }

        -- ------------------------------------------------- --
        -- ------ reload cc state on reload or startup ----- --
        local output = readwrite.readall('cc_state')

        if output:match('open') then
            awesome.emit_signal('control_center::extras', true)
            control_c.height = dpi(705)
        else
            awesome.emit_signal('control_center::extras', false)
            control_c.height = dpi(580)
        end
        --------------------------------------------------------
    end
)
