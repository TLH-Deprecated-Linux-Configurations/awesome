-- ______         __   __                       ______                     __
-- |   __ \.-----.|  |_|  |_.-----.--------.    |   __ \.---.-.-----.-----.|  |
-- |   __ <|  _  ||   _|   _|  _  |        |    |    __/|  _  |     |  -__||  |
-- |______/|_____||____|____|_____|__|__|__|    |___|   |___._|__|__|_____||__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- The main system bar, which is revealed by hovering your mouse near the
-- bottom edge of the screen.
--
local bottom_panel = function(s)
    local function show_widget_or_default(widget, show, require_is_function)
        if show and require_is_function then
            return require(widget)()
        elseif show then
            return require(widget)
        end
        return wibox.widget.base.empty_widget()
    end

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local offsetx = 0
    local panel =
        awful.wibar {
        ontop = true,
        screen = s,
        position = "bottom",
        height = dpi(48),
        -- 48
        width = s.geometry.width - offsetx,
        x = s.geometry.x + offsetx,
        y = s.geometry.y,
        stretch = false,
        bg = "linear:0,0:0,21:0,#3c3f4ccc:1,#17191ecc",
        fg = beautiful.fg_normal
    }
    panel:struts {bottom = dpi(38)}
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    panel:connect_signal(
        "mouse::enter",
        function()
            local w = mouse.current_wibox
            -- local c = client.focus
            -- c.bg = beautiful.xcolor7 .. '88'
            if w then
                w.cursor = "left_ptr"
            end
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local build_widget = function(widget)
        return wibox.widget {
            {
                widget,
                border_width = dpi(2),
                border_color = beautiful.xcolor7 .. "88",
                bg = "linear:0,0:0,21:0,#3c3f4ccc:1,#17191ecc",
                shape = beautiful.panel_button_shape,
                widget = wibox.container.background,
                resize = true
            },
            top = dpi(2),
            bottom = dpi(2),
            widget = wibox.container.margin
        }
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Pull in and build the widgets used on the bar
    --
    s.control_center_toggle = build_widget(require "layout.left-panel")
    s.bluetooth = build_widget(show_widget_or_default("layout.bottom-panel.widgets.bluetooth", hardware.hasBluetooth()))
    s.network = build_widget(show_widget_or_default("layout.bottom-panel.widgets.wifi", hardware.hasWifi()))
    local layout_box = build_widget(require "layout.bottom-panel.widgets.layoutbox"(s))
    local dropbox = build_widget(require "layout.bottom-panel.widgets.dropbox.dropbox")
    s.battery = build_widget(show_widget_or_default("layout.bottom-panel.widgets.battery", hardware.hasBattery(), true))
    s.mytextclock = build_widget(require "layout.bottom-panel.widgets.clock")
    local notification_center = build_widget(require "layout.right-panel")
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Set Up the Panel, add in the widgets
    panel:setup {
        {
            layout = wibox.layout.align.horizontal,
            expand = true,
            position = "bottom",
            spacing = dpi(18),
            {
                top = dpi(4),
                bottom = dpi(4),
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(8),
                s.control_center_toggle,
                tag_list(s),
                widget = wibox.container.margin
            },
            task_list(s),
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(2),
                s.network,
                s.bluetooth,
                dropbox,
                layout_box,
                -- s.screen_record,
                s.battery,
                s.mytextclock,
                notification_center
                -- clock,
            }
        },
        left = dpi(10),
        right = dpi(10),
        widget = wibox.container.margin
    }
    -- ########################################################################
    -- ### Provide the Trigger for the Bottom #################################
    -- ########################################################################
    -- Invisible trigger that enables the bottom_panel
    local panel_trigger =
        awful.wibar {
        screen = s,
        position = "bottom",
        height = 1,
        ontop = true,
        width = s.geometry.width,
        bg = "#00000000",
        visible = true
    }
    panel_trigger.timer = gears.timer {timeout = 3}
    panel_trigger.timer:connect_signal(
        "timeout",
        function()
            panel.visible = false
            panel_trigger.visible = true
        end
    )
    -- Show panel and hide trigger
    panel_trigger:connect_signal(
        "mouse::enter",
        function()
            panel.visible = true
            panel_trigger.visible = false
        end
    )
    -- Hide panel and show trigger
    panel:connect_signal(
        "mouse::leave",
        function()
            panel_trigger.timer:start()
        end
    )

    -- hide panel when client is fullscreen
    local function change_panel_visibility(client)
        if client.screen == s then
            panel.ontop = not client.fullscreen
        end
    end

    -- connect panel visibility function to relevant signals
    _G.client.connect_signal("property::fullscreen", change_panel_visibility)
    _G.client.connect_signal("focus", change_panel_visibility)
    return panel
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return bottom_panel
