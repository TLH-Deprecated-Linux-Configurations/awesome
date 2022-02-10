--  ______               __               __
-- |      |.-----.-----.|  |_.----.-----.|  |
-- |   ---||  _  |     ||   _|   _|  _  ||  |
-- |______||_____|__|__||____|__| |_____||__|
--  ______               __
-- |      |.-----.-----.|  |_.-----.----.
-- |   ---||  -__|     ||   _|  -__|   _|
-- |______||_____|__|__||____|_____|__|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
panel_visible = false

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local format_item = function(widget)
    return wibox.widget {
        {
            {
                layout = wibox.layout.align.vertical,
                expand = 'none',
                nil,
                widget,
                nil
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        forced_height = dpi(88),
        widget = wibox.container.background,
        bg = beautiful.bg_normal,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 6)
        end
    }
end
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local format_item_no_fix_height = function(widget)
    return wibox.widget {
        {
            {
                layout = wibox.layout.align.vertical,
                expand = 'none',
                nil,
                widget,
                nil
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        widget = wibox.container.background,
        bg = beautiful.bg_normal,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 6)
        end
    }
end
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local vertical_separator =
    wibox.widget {
    orientation = 'vertical',
    forced_height = dpi(1),
    forced_width = dpi(1),
    span_ratio = 0.55,
    widget = wibox.widget.separator
}

local control_center_row_one =
    wibox.widget {
    layout = wibox.layout.align.horizontal,
    forced_height = dpi(48),
    nil,
    format_item(require('layout.bottom-panel.widget.control-center.widget.user-profile')()),
    {
        format_item(
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(10),
                require('layout.bottom-panel.widget.control-center.widget.control-center-switch')(),
                vertical_separator,
                require('layout.bottom-panel.widget.control-center.widget.exit-screen-toggle')()
            }
        ),
        left = dpi(10),
        widget = wibox.container.margin
    }
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local main_control_row_two =
    wibox.widget {
    layout = wibox.layout.flex.horizontal,
    spacing = dpi(10),
    format_item_no_fix_height(
        {
            layout = wibox.layout.fixed.vertical,
            spacing = dpi(5),
            require('layout.bottom-panel.widget.control-center.widget.airplane-mode'),
            require('layout.bottom-panel.widget.control-center.widget.bluetooth-toggle'),
            require('layout.bottom-panel.widget.control-center.widget.dropbox-toggle')
        }
    ),
    {
        layout = wibox.layout.flex.vertical,
        spacing = dpi(10),
        format_item_no_fix_height(
            {
                layout = wibox.layout.align.vertical,
                expand = 'none',
                nil,
                require('layout.bottom-panel.widget.control-center.widget.dont-disturb'),
                nil
            }
        ),
        format_item_no_fix_height(
            {
                layout = wibox.layout.align.vertical,
                expand = 'none',
                nil,
                require('layout.bottom-panel.widget.control-center.widget.blur-toggle'),
                nil
            }
        )
    }
}

-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local main_control_row_sliders =
    wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(10),
    format_item(
        {
            require('layout.bottom-panel.widget.control-center.widget.blur-slider'),
            margins = dpi(10),
            widget = wibox.container.margin
        }
    ),
    format_item(
        {
            require('layout.bottom-panel.widget.control-center.widget.brightness-slider'),
            margins = dpi(10),
            widget = wibox.container.margin
        }
    ),
    format_item(
        {
            require('layout.bottom-panel.widget.control-center.widget.volume-slider'),
            margins = dpi(10),
            widget = wibox.container.margin
        }
    )
}
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local monitor_control_row_progressbars =
    wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = dpi(10),
    format_item(require('layout.bottom-panel.widget.control-center.widget.cpu-meter')),
    format_item(require('layout.bottom-panel.widget.control-center.widget.ram-meter')),
    format_item(require('layout.bottom-panel.widget.control-center.widget.temperature-meter')),
    format_item(require('layout.bottom-panel.widget.control-center.widget.harddrive-meter'))
}

local control_center = function(s)
    -- Set the control center geometry
    local panel_width = dpi(600)

    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    local panel =
        awful.popup {
        widget = {
            {
                {
                    layout = wibox.layout.fixed.vertical,
                    spacing = dpi(10),
                    control_center_row_one,
                    {
                        layout = wibox.layout.stack,
                        {
                            id = 'main_control',
                            visible = true,
                            layout = wibox.layout.fixed.vertical,
                            spacing = dpi(10),
                            main_control_row_two,
                            main_control_row_sliders
                        },
                        {
                            id = 'monitor_control',
                            visible = false,
                            layout = wibox.layout.fixed.vertical,
                            spacing = dpi(10),
                            monitor_control_row_progressbars
                        }
                    }
                },
                margins = dpi(16),
                widget = wibox.container.margin
            },
            id = 'control_center',
            bg = beautiful.bg_focus,
            shape = function(cr, w, h)
                gears.shape.rounded_rect(cr, w, h, 6)
            end,
            widget = wibox.container.background
        },
        screen = s,
        type = 'dock',
        visible = false,
        ontop = true,
        width = dpi(panel_width),
        maximum_width = dpi(panel_width),
        bg = beautiful.bg_focus,
        fg = beautiful.fg_normal,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 12)
        end
    }
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    awful.placement.bottom_right(
        panel,
        {
            honor_workarea = true,
            parent = s,
            margins = {bottom = dpi(s.geometry.height - 478), right = dpi(5)}
        }
    )
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    panel.opened = false
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    s.backdrop_control_center =
        wibox {
        ontop = true,
        screen = s,
        bg = '#000000cc',
        type = 'utility',
        x = s.geometry.x,
        y = s.geometry.y,
        width = s.geometry.width,
        height = s.geometry.height
    }
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    local open_panel = function()
        local focused = awful.screen.focused()
        panel_visible = true

        focused.backdrop_control_center.visible = true
        focused.control_center.visible = true

        panel:emit_signal('opened')
    end
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    local close_panel = function()
        local focused = awful.screen.focused()
        panel_visible = false

        focused.control_center.visible = false
        focused.backdrop_control_center.visible = false

        panel:emit_signal('closed')
    end
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- Hide this panel when app dashboard is called.
    function panel:hide_dashboard()
        close_panel()
    end
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    -- ------------------------------------------------- --
    function panel:toggle()
        self.opened = not self.opened
        if self.opened then
            open_panel()
        else
            close_panel()
        end
    end

    s.backdrop_control_center:buttons(
        awful.util.table.join(
            awful.button(
                {},
                1,
                nil,
                function()
                    panel:toggle()
                end
            )
        )
    )

    return panel
end

return control_center
