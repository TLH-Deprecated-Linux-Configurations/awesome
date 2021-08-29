--  ______         __   __
-- |   __ \.---.-.|  |_|  |_.-----.----.--.--.
-- |   __ <|  _  ||   _|   _|  -__|   _|  |  |
-- |______/|___._||____|____|_____|__| |___  |
--                                     |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local filehandle = require("module.functions.file")
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Check if a battery exists
-- @return string The percentage of the battery
-- @staticfct getBatteryPath
-- @usage -- This will /sys/class/power_supply/BAT0 if it exists
-- module.hardware.battery.getBatteryPath() -- return location of the battery state
local function getBatteryPath()
    -- check if battery 0 or 1 exists
    local battery_base_dir = "/sys/class/power_supply"
    local data = filehandle.list_dir(battery_base_dir)
    for _, item in ipairs(data) do
        if string.find(filehandle.basename(item), "BAT") ~= nil then
            return item
        end
    end
    return nil
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Return true if the battery is charging
-- @return boolean True if it is charging
-- @staticfct isBatteryCharging
-- @usage -- This will return True if charging
--  module.hardware.battery.isBatteryCharging() -- True
local function isBatteryCharging()
    local battery = getBatteryPath()
    if battery then
        local value = filehandle.string(battery .. "/status"):gsub("\n", "")
        if value == "Charging" then
            return true
        end
    end
    return false
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Return the percentage of the battery or nil (if no battery exists)
-- @return number The percentage of the battery
-- @staticfct getBatteryPercentage
-- @usage -- This will 100 if fully charged
-- module.hardware.battery.getBatteryPercentage() -- return percentage of battery
local function getBatteryPercentage()
    -- get back a battery location
    local battery = getBatteryPath()
    if battery == nil then
        return nil
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- battery exists, lets get the percentage back
    local value = filehandle.string(battery .. "/capacity")
    if value then
        value = value:gsub("\n", "")
        return tonumber(value)
    end
    -- something went wrong parsing the value
    return 0
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return {
    isBatteryCharging = isBatteryCharging,
    getBatteryPercentage = getBatteryPercentage,
    getBatteryPath = getBatteryPath
}
