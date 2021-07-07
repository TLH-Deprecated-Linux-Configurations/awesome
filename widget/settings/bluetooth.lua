--  _______         __   __   __
-- |     __|.-----.|  |_|  |_|__|.-----.-----.-----.
-- |__     ||  -__||   _|   _|  ||     |  _  |__ --|
-- |_______||_____||____|____|__||__|__|___  |_____|
--                                     |_____|
--  ______ __               __                __   __
-- |   __ \  |.--.--.-----.|  |_.-----.-----.|  |_|  |--.
-- |   __ <  ||  |  |  -__||   _|  _  |  _  ||   _|     |
-- |______/__||_____|_____||____|_____|_____||____|__|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local icons = require("theme.icons")
local split = require("lib.function.common").split
local signals = require("module.signals")
local mat_icon_button = require("widget.material.icon-button")
local mat_icon = require("widget.material.icon")
local card = require("module.ui-components.card")
local naughty = require("naughty")
local execute = require("module.hardware-check").execute
local scrollbox = require("module.ui-components.scrollbox")

local dpi = beautiful.xresources.apply_dpi
-- ########################################################################
-- ########################################################################
-- ########################################################################
local m = dpi(10)
local settings_index = dpi(40)
local settings_height = dpi(900)
local settings_width = dpi(1100)
local settings_nw = dpi(260)

local scrollbox_body

local refresh = function()
end

local devices = {}
local paired_devices = {}

local connections = wibox.layout.fixed.vertical()
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function loading()
    connections.children = {}
    local text =
        wibox.widget {
        text = ("Connecting..."),
        font = "agave Nerd Font Mono Bold 24",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
        forced_height = settings_height - settings_index
    }
    connections:add(text)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function notify(title, msg)
    naughty.notification(
        {
            title = ("Bluetooth"),
            text = (title) .. '\n<span weight="bold">' .. msg .. "</span>",
            timeout = 5,
            urgency = "critical",
            icon = icons.warning
        }
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function make_bluetooth_widget(tbl)
    -- make sure ssid is not nil
    local name = tbl.name or tbl.mac
    local mac = tbl.mac
    local paired = tbl.paired
    local connected = tbl.connected

    local box = card()
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local disconnect_btn = mat_icon_button(mat_icon(icons.minus, dpi(25)))
    disconnect_btn:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                nil,
                function()
                    print("Disconnecting from: " .. name)
                    local cmd = "bluetoothctl disconnect '" .. mac .. "'"
                    print("Executing command: " .. cmd)
                    loading()
                    awful.spawn.easy_async(
                        cmd,
                        function(out, _, _, code)
                            print("Bluetooth connection result: " .. out)
                            if not (code == 0) then
                                notify("Disconnection failed", out)
                            end
                            refresh()
                        end
                    )
                end
            )
        )
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local connect_btn = mat_icon_button(mat_icon(icons.plus, dpi(25)))
    connect_btn:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                nil,
                function()
                    print("Connect to bluetooth using the name: " .. name)
                    local cmd = "bluetoothctl connect '" .. mac .. "'"
                    print("Executing command: " .. cmd)
                    loading()
                    awful.spawn.easy_async(
                        cmd,
                        function(out, _, _, code)
                            print("Bluetooth connection result: " .. out)
                            if not (code == 0) then
                                notify("Connection failed", out)
                            end
                            refresh()
                        end
                    )
                end
            )
        )
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local pair_btn = mat_icon_button(mat_icon(icons.bluetooth, dpi(25)))
    pair_btn:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                nil,
                function()
                    print("Pairing to " .. name)
                    local cmd = "bluetoothctl pair '" .. mac .. "'"
                    print("Executing command: " .. cmd)
                    loading()
                    awful.spawn.easy_async(
                        cmd,
                        function(out, _, _, code)
                            print("Bluetooth pairing result: " .. out)
                            if not (code == 0) then
                                notify("Pairing failed", out)
                            end
                            awful.spawn("bluetoothctl trust '" .. mac .. "'")
                            refresh()
                        end
                    )
                end
            )
        )
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local unpair_btn = mat_icon_button(mat_icon(icons.bluetooth_off, dpi(25)))
    unpair_btn:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                nil,
                function()
                    print("unpairing to " .. name)
                    local cmd = "bluetoothctl untrust '" .. mac .. "'"
                    local cmd2 = "bluetoothctl remove '" .. mac .. "'"
                    loading()
                    awful.spawn.easy_async(
                        cmd,
                        function()
                            awful.spawn.easy_async(
                                cmd2,
                                function()
                                    refresh()
                                end
                            )
                        end
                    )
                end
            )
        )
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local buttons = wibox.layout.fixed.horizontal()
    -- only allow pairing if we aren't paired yet
    if paired then
        buttons:add(unpair_btn)
        awful.tooltip {
            objects = {unpair_btn},
            text = ("Forget ") .. name
        }
    else
        buttons:add(pair_btn)
        awful.tooltip {
            objects = {pair_btn},
            text = ("Pair with ") .. name
        }
    end
    if connected then
        buttons:add(disconnect_btn)
        awful.tooltip {
            objects = {disconnect_btn},
            text = ("Disconnect from ") .. name
        }
    else
        buttons:add(connect_btn)
        awful.tooltip {
            objects = {connect_btn},
            text = ("Connect to ") .. name
        }
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- name on the left, password entry in the middle, connect button on the right
    local widget =
        wibox.widget {
        wibox.container.margin(
            wibox.widget {
                widget = wibox.widget.textbox,
                text = name,
                font = beautiful.title_font
            },
            dpi(10),
            dpi(10),
            dpi(10),
            dpi(10)
        ),
        nil,
        buttons,
        layout = wibox.layout.align.horizontal
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    box.update_body(widget)

    local container = wibox.container.margin()
    container.bottom = m
    container.forced_width = settings_width - settings_nw - (m * 2)
    container.forced_height = dpi(50)
    container.widget = box
    return container
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return function()
    local view = wibox.container.margin()
    view.left = m
    view.right = m

    local title = wibox.widget.textbox("Bluetooth")
    title.font = beautiful.title_font
    title.forced_height = settings_index + m + m

    local close = wibox.widget.imagebox(icons.close)
    close.forced_height = settings_index
    close:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                function()
                    if root.elements.settings then
                        root.elements.settings.close()
                    end
                end
            )
        )
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    scrollbox_body = scrollbox(connections)
    view:setup {
        layout = wibox.container.background,
        bg = beautiful.bg_normal .. "00",
        --fg = config.colors.xf,
        {
            layout = wibox.layout.align.vertical,
            {
                layout = wibox.layout.align.horizontal,
                nil,
                wibox.container.margin(
                    {
                        layout = wibox.container.place,
                        title
                    },
                    settings_index * 2
                ),
                close
            },
            {
                layout = wibox.container.place,
                valign = "top",
                halign = "center",
                scrollbox_body
            }
        }
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local timer =
        gears.timer {
        autostart = true,
        timeout = 20,
        callback = function()
            print("Refreshing")
            refresh()
        end
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local stop_view = function()
        print("Stopping bluetooth advertisment")
        timer:stop()
        -- disable our discovery
        awful.spawn(
            [[sh -c '
    killall bluetoothctl;
    bluetoothctl scan off;
    bluetoothctl pairable off;
    bluetoothctl discoverable off;
    ']]
        )
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- make sure we always gracefully shutdown
    signals.connect_exit(
        function()
            stop_view()
        end
    )
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local function is_connected(mac, stdout)
        if stdout == nil then
            return false
        end
        return (stdout:find(mac) ~= nil)
    end

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local function check_data()
        -- only generate the list if both commands completed
        if #devices > 0 and #paired_devices > 0 then
            local stdout, _ = execute("bluetoothctl info")
            for _, value in ipairs(devices) do
                connections:add(
                    make_bluetooth_widget(
                        {
                            name = value.name,
                            mac = value.mac,
                            paired = paired_devices[value.mac] ~= nil,
                            connected = is_connected(value.mac, stdout)
                        }
                    )
                )
            end
        end
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    refresh = function(bIsTimer)
        if scrollbox_body then
            scrollbox_body.reset()
        end
        if bIsTimer == nil then
            print("Starting bluetooth advertisment")
            awful.spawn("sh -c 'bluetoothctl scan on; bluetoothctl pairable on; bluetoothctl discoverable on'")
        elseif timer.started == nil then
            timer:start()
        end
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- remove all connections
        connections.children = {}
        devices = {}
        paired_devices = {}

        awful.spawn.easy_async_with_shell(
            "bluetoothctl devices",
            function(out)
                for _, value in ipairs(split(out, "\n")) do
                    local mac, name = string.match(value, "^Device ([A-F0-9:]+) (.*)$")
                    if name == nil then
                        name = mac
                    end
                    if mac ~= nil then
                        table.insert(
                            devices,
                            {
                                mac = mac,
                                name = name
                            }
                        )
                    end
                end
                check_data()
            end
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        awful.spawn.easy_async_with_shell(
            "bluetoothctl paired-devices",
            function(out)
                for _, value in ipairs(split(out, "\n")) do
                    local mac = string.match(value, "^Device ([A-F0-9:]+) .*$") or split(value, " ")[2]
                    if mac ~= nil then
                        paired_devices[mac] = true
                    end
                end
                -- this is to indicate that we are done
                table.insert(paired_devices, true)
                check_data()
            end
        )
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    view.refresh = refresh
    view.stop_view = stop_view
    return view
end
