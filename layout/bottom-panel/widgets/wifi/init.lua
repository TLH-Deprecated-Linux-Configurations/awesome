--  ________ _______ _______ _______
-- |  |  |  |_     _|    ___|_     _|
-- |  |  |  |_|   |_|    ___|_|   |_
-- |________|_______|___|   |_______|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- simple widget that displays only if there is a wifi card (hopefully) and
-- then shows a pictoral representation of the status of the connection if
-- there is that clicking on brings up nmtui
--
-- Icons are not being moved to the general icon dump because moving them
-- would make the widget more painful to adapt, making copying this function
-- probably as easy as it can be in terms of knowing which parts to take.
-- You are welcome
-- ########################################################################
-- ########################################################################
-- ########################################################################
local PATH_TO_ICONS = HOME .. "/.config/awesome/layout/bottom-panel/widgets/wifi/icons/"
local interface = "wlan0"

local connected = true
local essid = "N/A"

local widget =
    wibox.widget {
    {
        id = "icon",
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local widget_button = clickable_container(wibox.container.margin(widget, dpi(14), dpi(14), 7, 7)) -- default top bottom margin is 7
widget_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn('kitty -e "nmtui"')
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Alternative to naughty.notify - tooltip. You can compare both and choose the preferred one
awful.tooltip(
    {
        objects = {widget_button},
        mode = "outside",
        align = "right",
        timer_function = function()
            if connected then
                return ("Connected to ") .. essid
            else
                return ("Disconnected")
            end
        end,
        preferred_positions = {"right", "left", "top", "bottom"},
        margin_leftright = dpi(8),
        margin_topbottom = dpi(8)
    }
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function grabText()
    if connected then
        awful.spawn.easy_async(
            "iw dev " .. interface .. " link",
            function(stdout)
                essid = stdout:match("SSID:(.-)\n")
                if (essid == nil) then
                    essid = "N/A"
                end
                print("Network essid: " .. essid)
            end
        )
    end
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
gears.timer {
    timeout = config.network_poll,
    call_now = true,
    autostart = true,
    callback = function()
        local widgetIconName = "wifi-strength"
        local interface_res = file.lines("/proc/net/wireless")[3]
        if interface_res == nil then
            connected = false
            signals.emit_wifi_status(false)
            widget.icon:set_image(PATH_TO_ICONS .. widgetIconName .. "-off" .. ".svg")
            return
        end

        local interface_name, _, link = interface_res:match("(%w+):%s+(%d+)%s+(%d+)")

        interface = interface_name
        file.overwrite("/tmp/interface.txt", interface_name)

        local wifi_strength = (tonumber(link) / 70) * 100
        if (wifi_strength ~= nil) then
            connected = true
            -- Update popup text
            local wifi_strength_rounded = math.floor(wifi_strength / 25 + 0.5)
            widgetIconName = widgetIconName .. "-" .. wifi_strength_rounded
            widget.icon:set_image(PATH_TO_ICONS .. widgetIconName .. ".svg")
        else
            connected = false
            widget.icon:set_image(PATH_TO_ICONS .. widgetIconName .. "-off" .. ".svg")
        end
        if (connected and (essid == "N/A" or essid == nil)) then
            grabText()
        end
        signals.emit_wifi_status(connected)
    end
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
widget:connect_signal(
    "mouse::enter",
    function()
        grabText()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
return widget_button
