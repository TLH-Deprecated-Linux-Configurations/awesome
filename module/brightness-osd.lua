--  ______        __         __     __
-- |   __ \.----.|__|.-----.|  |--.|  |_.-----.-----.-----.-----.
-- |   __ <|   _||  ||  _  ||     ||   _|     |  -__|__ --|__ --|
-- |______/|__|  |__||___  ||__|__||____|__|__|_____|_____|_____|
--                   |_____|
--  _______ _______ _____
-- |       |     __|     \
-- |   -   |__     |  --  |
-- |_______|_______|_____/
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- OSD in this case means on screen display. This renders the dialog that
--  appears when/if you use the function keys to change the brightness as
-- opposed to the control center.
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- header
--
local osd_header =
    wibox.widget {
    text = 'Brightness',
    font = 'SFMono Nerd Font Mono Heavy  16',
    align = 'left',
    valign = 'center',
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- value of the brightness
--
local osd_value =
    wibox.widget {
    text = '0%',
    font = 'SFMono Nerd Font Mono Heavy  16',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local slider_osd =
    wibox.widget {
    nil,
    {
        id = 'bri_osd_slider',
        bar_shape = gears.shape.rounded_rect,
        bar_height = dpi(24),
        bar_color = '#22262d',
        bar_active_color = '#f4f4f7ee',
        handle_color = '#ffffff',
        handle_shape = gears.shape.circle,
        handle_width = dpi(24),
        handle_border_color = '#00000012',
        handle_border_width = dpi(1),
        maximum = 100,
        widget = wibox.widget.slider
    },
    nil,
    expand = 'none',
    layout = wibox.layout.align.vertical
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local bri_osd_slider = slider_osd.bri_osd_slider

bri_osd_slider:connect_signal(
    'property::value',
    function()
        local brightness_level = bri_osd_slider:get_value()
        spawn('light -S ' .. math.max(brightness_level, 5), false)

        -- Update textbox widget text
        osd_value.text = brightness_level .. '%'

        -- Update the brightness slider if values here change
        awesome.emit_signal('widget::brightness:update', brightness_level)

        if awful.screen.focused().show_bri_osd then
            awesome.emit_signal('module::brightness_osd:show', true)
        end
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- if pressing the popup, keep it open
--
bri_osd_slider:connect_signal(
    'button::press',
    function()
        awful.screen.focused().show_bri_osd = true
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- on mouse leaving the popup, close it
bri_osd_slider:connect_signal(
    'mouse::leave',
    function()
        awful.screen.focused().show_bri_osd = false
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- on mouse entering the popup, keep it open
--
bri_osd_slider:connect_signal(
    'mouse::enter',
    function()
        awful.screen.focused().show_bri_osd = true
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- The emit will come from brightness slider
--
awesome.connect_signal(
    'module::brightness_osd',
    function(brightness)
        bri_osd_slider:set_value(brightness)
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- icon used
--
local icon =
    wibox.widget {
    {image = icons.brightness, resize = true, widget = wibox.widget.imagebox},
    forced_height = dpi(150),
    top = dpi(12),
    bottom = dpi(12),
    widget = wibox.container.margin
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
--  set dimensions
--
local osd_height = dpi(250)
local osd_width = dpi(250)

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- add into the desktop decorations signal
--
screen.connect_signal(
    'request::desktop_decoration',
    function(s)
        local s = s or {}
        s.show_bri_osd = false

        s.brightness_osd_overlay =
            awful.popup {
            widget = {},
            ontop = true,
            visible = false,
            type = 'notification',
            screen = s,
            height = osd_height,
            width = osd_width,
            maximum_height = osd_height,
            maximum_width = osd_width,
            offset = dpi(5),
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 12)
            end,
            bg = beautiful.bg_focus,
            preferred_anchors = 'middle',
            preferred_positions = {'left', 'right', 'top', 'bottom'}
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        s.brightness_osd_overlay:setup {
            {
                {
                    layout = wibox.layout.fixed.vertical,
                    {
                        {
                            layout = wibox.layout.align.horizontal,
                            expand = 'none',
                            nil,
                            icon,
                            nil
                        },
                        {
                            layout = wibox.layout.fixed.vertical,
                            spacing = dpi(5),
                            {
                                layout = wibox.layout.align.horizontal,
                                expand = 'none',
                                osd_header,
                                nil,
                                osd_value
                            },
                            slider_osd
                        },
                        spacing = dpi(10),
                        layout = wibox.layout.fixed.vertical
                    }
                },
                left = dpi(24),
                right = dpi(24),
                widget = wibox.container.margin
            },
            bg = beautiful.background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 2)
            end,
            widget = wibox.container.background()
        }
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Reset timer on mouse hover
        --
        s.brightness_osd_overlay:connect_signal(
            'mouse::enter',
            function()
                s.show_bri_osd = true
                awesome.emit_signal('module::brightness_osd:rerun')
            end
        )
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- hide popup function
local hide_osd =
    gears.timer {
    timeout = 2,
    autostart = true,
    callback = function()
        local focused = awful.screen.focused()
        focused.brightness_osd_overlay.visible = false
        focused.show_vol_osd = false
    end
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
--  rerun popup
--
awesome.connect_signal(
    'module::brightness_osd:rerun',
    function()
        if hide_osd.started then
            hide_osd:again()
        else
            hide_osd:start()
        end
    end
)

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- provide the coordinates for the popup
--
local placement_placer = function()
    local focused = awful.screen.focused()
    local brightness_osd = focused.brightness_osd_overlay
    awful.placement.next_to(
        brightness_osd,
        {
            preferred_positions = 'bottom',
            preferred_anchors = 'middle',
            geometry = focused.bottom_panel or awful.screen.focused(),
            offset = {x = 0, y = dpi(-20)}
        }
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- signal for showing popup
awesome.connect_signal(
    'module::brightness_osd:show',
    function(bool)
        placement_placer()
        awful.screen.focused().brightness_osd_overlay.visible = bool
        if bool then
            awesome.emit_signal('module::brightness_osd:rerun')
            awesome.emit_signal('module::volume_osd:show', false)
        else
            hide_osd()
        end
    end
)
