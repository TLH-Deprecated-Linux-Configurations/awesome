--  __           __   __
-- |  |--.-----.|  |_|  |_.-----.--------.
-- |  _  |  _  ||   _|   _|  _  |        |
-- |_____|_____||____|____|_____|__|__|__|
--                           __
-- .-----.---.-.-----.-----.|  |
-- |  _  |  _  |     |  -__||  |
-- |   __|___._|__|__|_____||__|
-- |__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --

local bottom_panel = function(s)
    local panel =
        awful.wibar {
        ontop = true,
        screen = s,
        type = 'dock',
        height = dpi(36),
        position = 'bottom',
        width = s.geometry.width,
        maximum_width = s.geometry.width,
        x = s.geometry.x,
        y = s.geometry.y,
        --stretch = true,
        bg = beautiful.bg_focus,
        fg = beautiful.fg_normal
    }
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    panel:struts {
        bottom = dpi(36)
    }
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    panel:connect_signal(
        'mouse::enter',
        function()
            local w = mouse.current_wibox
            if w then
                w.cursor = 'left_hand'
            end
        end
    )
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    s.systray =
        wibox.widget {
        visible = false,
        base_size = dpi(26),
        horizontal = true,
        screen = 'primary',
        widget = wibox.widget.systray
    }
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- Define Widgets
    --
    local tag_list = require('layout.bottom-panel.widget.tag-list')
    s.search = require('layout.bottom-panel.widget.app-menu')()
    local clock = require('layout.bottom-panel.widget.clock')(s)
    local layout_box = require('layout.bottom-panel.widget.layoutbox')(s)

    s.tray_toggler = require('layout.bottom-panel.widget.tray-toggle')

    s.screen_rec = require('layout.bottom-panel.widget.screen-recorder')()
    s.battery = require('layout.bottom-panel.widget.battery')()
    s.network = require('layout.bottom-panel.widget.network')()
    s.control_center_toggle = require('layout.bottom-panel.widget.control-center-toggle')()

    s.info_center_toggle = require('layout.bottom-panel.widget.info-center-toggle')()
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    panel:setup {
        layout = wibox.layout.align.horizontal,
        position = 'bottom',
        {
            spacing = dpi(12),
            margins = dpi(8),
            s.search,
            tag_list(s),
            layout = wibox.layout.fixed.horizontal
        },
        {
            widget = wibox.container.margin,
            task_list(s),
            margins = dpi(2)
        },
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(2),
            left = dpi(2),
            right = dpi(2),
            {
                s.systray,
                margins = dpi(8),
                widget = wibox.container.margin
            },
            s.tray_toggler,
            s.network,
            layout_box,
            s.control_center_toggle,
            s.info_center_toggle,
            s.screen_rec,
            s.battery,
            clock
        }
    }

    return panel
end
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
return bottom_panel
