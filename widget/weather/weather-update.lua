
-- Provides:
-- evil::weather
--      temperature (integer)
--      description (string)
--      icon_code (string)
local HOME = os.getenv("HOME")
local gears = require("gears")
local config = require("config")
local theme = require("theme.icons.dark-light")

local PATH_TO_ICONS = HOME .. "/.config/awesome/widget/weather/icons/"

-- Don't update too often, because your requests might get blocked for 24 hours
local update_interval = config.weather_poll

local signals = require("lib-tde.signals")

--  Weather script using your API KEY
local weather_details_script = "/bin/bash".. HOME .."/.config/awesome//weather.sh"

-- Sometimes it's too slow for internet to connect so the weather widget
-- will not update until the next 20 mins so this is helpful to update it
-- 20 seconds after logging in.
gears.timer {
    timeout = 20,
    autostart = true,
    single_shot = true,
    callback = function()
        awful.spawn.easy_async_with_shell(
            weather_details_script,
            function(stdout)
                local icon_code = string.sub(stdout, 1, 3) or "..."
                local weather_details = string.sub(stdout, 5)
                weather_details = string.gsub(weather_details, "^%s*(.-)%s*$", "%1")
                -- Replace "-0" with "0" degrees
                weather_details = string.gsub(weather_details, "%-0", "0")
                -- Capitalize first letter of the description
                weather_details = weather_details:sub(1, 1):upper() .. weather_details:sub(2)
                local description = weather_details:match("(.*)@@")
                local temperature = weather_details:match("@@(.*)")
                if icon_code == "..." then
                    signals.emit_weather("Maybe it's 10000", "No internet connection...", "")
                else
                    signals.emit_weather(temperature, description, icon_code)
                end
            end
        )
    end
}

-- Update widget every 1200 seconds/20 mins
awful.widget.watch(
    weather_details_script,
    update_interval,
    function(_, stdout)
        local icon_code = string.sub(stdout, 1, 3)
        local weather_details = string.sub(stdout, 5)
        weather_details = string.gsub(weather_details, "^%s*(.-)%s*$", "%1")
        -- Replace "-0" with "0" degrees
        weather_details = string.gsub(weather_details, "%-0", "0")
        -- Capitalize first letter of the description
        weather_details = weather_details:sub(1, 1):upper() .. weather_details:sub(2)
        local description = weather_details:match("(.*)@@")
        local temperature = weather_details:match("@@(.*)")
        if icon_code == "..." then
            signals.emit_weather("Maybe it's 10000", "No internet connection...", "")
        else
            signals.emit_weather(temperature, description, icon_code)
        end
    end
)

signals.connect_weather(
    function(temperature, description, icon_code)
        local widgetIconName

        print("Current weather temperature: " .. temperature)
        print("Current weather description: " .. description)

        -- Set icon and color depending on icon_code
        if string.find(icon_code, "11") then
            widgetIconName = "sun_icon"
        elseif string.find(icon_code, "22") then
            widgetIconName = "moon_icon"
        elseif string.find(icon_code, "33") then
            widgetIconName = "dcloud_icon"
        elseif string.find(icon_code, "44") then
            widgetIconName = "ncloud_icon"
        elseif string.find(icon_code, "55") or string.find(icon_code, "04") then
            widgetIconName = "cloud_icon"
        elseif string.find(icon_code, "66") or string.find(icon_code, "10") then
            widgetIconName = "rain_icon"
        elseif string.find(icon_code, "77") then
            widgetIconName = "storm_icon"
        elseif string.find(icon_code, "88") then
            widgetIconName = "snow_icon"
        elseif string.find(icon_code, "99") or string.find(icon_code, "40") then
            widgetIconName = "mist_icon"
        else
            widgetIconName = "whatever_icon"
        end

        -- Update data. Global variables stored in widget.weather.init
        _G.weather_icon_widget.icon:set_image(theme(PATH_TO_ICONS .. widgetIconName .. ".svg"))
        _G.weather_description.text = description
        _G.weather_temperature.text = temperature
    end
)
