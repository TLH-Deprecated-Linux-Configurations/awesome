-- _____          ___ __
-- |     |_.-----.'  _|  |_
-- |       |  -__|   _|   _|
-- |_______|_____|__| |____|
-- ______                     __
-- |   __ \.---.-.-----.-----.|  |
-- |    __/|  _  |     |  -__||  |
-- |___|   |___._|__|__|_____||__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local PATH_TO_ICONS = HOME .. "/.config/awesome/layout/left-panel/icons/"
local apps = require "configuration.settings.apps"
local animate = require "widget.interface.animations".createAnimObject
local get_screen = require "lib.function.common".focused_screen
local keyconfig = require "configuration.keys.mod"
local modKey = keyconfig.modKey
-- body gets populated with a scrollbox widget once generated
local body = {}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local left_panel_func = function()
    -- set the panel width equal to the rofi settings
    -- the rofi width is defined in configuration/rofi/sidebar/rofi.rasi
    -- under the section window-> width
    local left_panel_width = dpi(450)
    local s = get_screen()
    local backdrop =
        wibox {
        ontop = true,
        screen = s,
        bg = "#00000033",
        type = "dock",
        x = s.geometry.x,
        y = s.geometry.y,
        width = s.geometry.width,
        height = s.geometry.height
    }

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local function update_backdrop_location()
        backdrop.x = s.geometry.x
        backdrop.y = s.geometry.y
        backdrop.width = s.geometry.width
        backdrop.height = s.geometry.height
    end

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local left_panel =
        wibox {
        ontop = true,
        screen = s,
        bg = "radial:960,540,10:0,0,10:0,#2f303d:0.34,#17191e:0.65,#22262d:1,#17191e",
        width = left_panel_width,
        height = s.geometry.height,
        x = s.geometry.x,
        y = s.geometry.y,
        fg = beautiful.fg_normal
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    screen.connect_signal(
        "removed",
        function(removed)
            if s == removed then
                s = get_screen()
            end
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- this is called when we need to update the screen
    signals.connect_refresh_screen(
        function()
            print "Refreshing action center"
            if left_panel == nil then
                return
            end
            s = get_screen()
            -- the action center itself
            left_panel.x = s.geometry.x
            left_panel.y = s.geometry.y
            left_panel.width = left_panel_width
            left_panel.height = s.geometry.height
            -- the backdrop
            update_backdrop_location()
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    left_panel.opened = false
    local grabber
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local openleft_panel = function()
        backdrop.visible = true
        left_panel.visible = true
        if grabber then
            grabber:start()
        end
        left_panel:emit_signal "opened"
        s = get_screen()
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- start the animations
        left_panel.x = s.geometry.x - left_panel_width
        left_panel.bg = "radial:960,540,1000:0,0,1000:0,#2f303d:0.34,#17191e:0.65,#22262d:1,#17191e"
        left_panel.y = s.geometry.y
        left_panel.height = s.geometry.height
        left_panel.opacity = 0
        animate(
            _G.anim_speed,
            left_panel,
            {opacity = 1, x = s.geometry.x},
            "outCubic",
            function()
                update_backdrop_location()
            end
        )
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local closeleft_panel = function()
        s = get_screen()
        -- start the animations
        left_panel.x = s.geometry.x
        left_panel.y = s.geometry.y
        left_panel.height = s.geometry.height
        left_panel.border_radius = dpi(4)
        left_panel.opacity = 1
        backdrop.visible = false
        animate(
            _G.anim_speed,
            left_panel,
            {opacity = 0, x = s.geometry.x - left_panel_width},
            "outCubic",
            function()
                left_panel.visible = false
                -- Change to notify mode on close
                if grabber then
                    grabber:stop()
                end
                left_panel:emit_signal "closed"
                update_backdrop_location()
            end
        )
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    grabber =
        awful.keygrabber {
        keybindings = {
            awful.key {
                modifiers = {},
                key = "Escape",
                on_press = function()
                    left_panel.opened = false
                    closeleft_panel()
                end
            },
            awful.key {
                modifiers = {modKey},
                key = keyconfig.configPanel,
                on_press = function()
                    left_panel.opened = false
                    closeleft_panel()
                end
            }
        },
        -- Note that it is using the key name and not the modifier name.
        stop_key = "Escape",
        stop_event = "release"
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    left_panel:struts {left = 0}
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local action_grabber =
        awful.keygrabber {
        keybindings = {
            awful.key {
                modifiers = {},
                key = "Escape",
                on_press = function()
                    left_panel:close()
                end
            }
        },
        -- Note that it is using the key name and not the modifier name.
        stop_key = "Escape",
        stop_event = "release"
    }

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Hide this left_panel when app dashboard is called.
    function left_panel:HideDashboard()
        closeleft_panel()
    end

    function left_panel:toggle()
        self.opened = not self.opened
        if self.opened then
            openleft_panel()
        else
            closeleft_panel()
        end
    end

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    function left_panel:run_rofi()
        action_grabber:stop()
        _G.awesome.spawn(apps.default.web, false, false, false, false, left_panel:toggle())
    end

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    function left_panel:run_wifi()
        action_grabber:stop()
        _G.awesome.spawn(apps.default.rofiwifimenu, false, false, false, false, left_panel:toggle())
    end

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    backdrop:buttons(
        awful.util.table.join(
            awful.button(
                {},
                1,
                function()
                    left_panel:toggle()
                end
            )
        )
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local exit_button_widget = wibox.widget.imagebox(PATH_TO_ICONS .. "power.svg")
    local exit_button =
        button(
        exit_button_widget,
        function()
            left_panel:toggle()
            action_grabber:stop()
            _G.exit_screen_show()
        end
    )
    exit_button.bg = beautiful.xcolor8 .. "ff"
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local separator = seperator_widget(20, "vertical", 0)
    local topSeparator = seperator_widget(20, "horizontal", 0)
    local bottomSeparator = seperator_widget(5, "horizontal", 0)

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local function settings_plugin()
        local screen_card = card "System Tray"
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        screen_card.update_body(require "layout.left-panel.widgets.systray")
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        local table_widget =
            wibox.widget {
            topSeparator,
            require "layout.left-panel.widgets.quick-settings",
            require "layout.left-panel.widgets.hardware-monitor"(s),
            separator,
            wibox.container.margin(screen_card, dpi(20), dpi(20), dpi(20), dpi(20)),
            separator,
            layout = wibox.layout.fixed.vertical
        }
        return table_widget
    end

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    body =
        wibox.widget {
        layout = wibox.layout.align.vertical,
        separator,
        settings_plugin(),
        wibox.container.margin(
            {
                layout = wibox.layout.fixed.vertical,
                wibox.widget {
                    wibox.widget {
                        exit_button,
                        widget = wibox.container.background,
                        bg = beautiful.xcolor8,
                        border_width = dpi(3),
                        border_color = beautiful.xcolor7 .. "33",
                        shape = beautiful.btn_lg_shape
                    },
                    widget = mat_list_item
                },
                bottomSeparator
            },
            dpi(15),
            dpi(15),
            dpi(15),
            dpi(15)
        )
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    left_panel:setup {
        expand = "none",
        layout = wibox.layout.fixed.vertical,
        body
    }
    return left_panel
end
return left_panel_func
