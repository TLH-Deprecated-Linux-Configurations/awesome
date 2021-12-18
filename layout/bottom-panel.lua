--  __           __   __
-- |  |--.-----.|  |_|  |_.-----.--------.
-- |  _  |  _  ||   _|   _|  _  |        |
-- |_____|_____||____|____|_____|__|__|__|

--                           __
-- .-----.---.-.-----.-----.|  |
-- |  _  |  _  |     |  -__||  |
-- |   __|___._|__|__|_____||__|
-- |__|
-- ########################################################################
-- ########################################################################
-- ########################################################################

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
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    panel:struts {
        bottom = dpi(36)
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    panel:connect_signal(
        'mouse::enter',
        function()
            local w = mouse.current_wibox
            if w then
                w.cursor = 'left_hand'
            end
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    s.systray =
        wibox.widget {
        visible = false,
        base_size = dpi(26),
        horizontal = true,
        screen = 'primary',
        widget = wibox.widget.systray
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local tag_list = require('widget.tag-list')
    s.search = require('widget.search-apps')()
    local clock = require('widget.clock')(s)
    local layout_box = require('widget.layoutbox')(s)

    s.tray_toggler = require('widget.tray-toggle')

    s.screen_rec = require('widget.screen-recorder')()
    s.battery = require('widget.battery')()
    s.network = require('widget.network')()
    s.control_center_toggle = require('widget.control-center-toggle')()
    s.global_search = require('widget.global-search')()
    s.info_center_toggle = require('widget.info-center-toggle')()
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    panel:setup {
        layout = wibox.layout.align.horizontal,
        position = 'bottom',
        {
            left = dpi(5),
            spacing = dpi(12),
            s.search,
            tag_list(s),
            layout = wibox.layout.fixed.horizontal
        },
        task_list(s),
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(2),
            left = dpi(2),
            right = dpi(2),
            {
                s.systray,
                margins = dpi(2),
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
-- ########################################################################
-- ########################################################################
-- ########################################################################
return bottom_panel
