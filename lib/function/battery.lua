---------------------------------------------------------------------------
-- This module contains useful helper functions when working with batteries.
--
-- To get the charging status of the battery you must do an asynchronous call to not block the main thread
-- a function call must be wrapped in a `awful.spawn.easy_async_with_shell`
--
--     awful.spawn.easy_async_with_shell(lib.function.battery.chargedScript, function(stdout)
--        lib.function.battery.isBatteryCharging(stdout) -- returns is the battery is charging e.g. false
--     end)
--
-- Another example is to check the current battery percentage
--
--     awful.spawn.easy_async_with_shell(lib.function.battery.upowerBatteryScript, function(stdout)
--        lib.function.battery.getBatteryInformationFromUpower(stdout) -- returns battery percentage e.g. 87
--     end)
--
-- @author Tom Meyers
-- @copyright 2020 Tom Meyers
-- @tdemod lib.function.battery
---------------------------------------------------------------------------

local filehandle = require('module.file')

--- Check if a battery exists
-- @return string The percentage of the battery
-- @staticfct getBatteryPath
-- @usage -- This will /sys/class/power_supply/BAT0 if it exists
-- lib.function.battery.getBatteryPath() -- return location of the battery state
local function getBatteryPath()
    -- check if battery 0 or 1 exists
    local battery_base_dir = '/sys/class/power_supply'
    local data = filehandle.list_dir(battery_base_dir)
    for _, item in ipairs(data) do
        if string.find(filehandle.basename(item), 'BAT') ~= nil then
            return item
        end
    end
    return nil
end

--- Return true if the battery is charging
-- @return boolean True if it is charging
-- @staticfct isBatteryCharging
-- @usage -- This will return True if charging
--  lib.function.battery.isBatteryCharging() -- True
local function isBatteryCharging()
    local battery = getBatteryPath()
    if battery then
        local value = filehandle.string(battery .. '/status'):gsub('\n', '')
        if value == 'Charging' then
            return true
        end
    end
    return false
end

--- Return the percentage of the battery or nil (if no battery exists)
-- @return number The percentage of the battery
-- @staticfct getBatteryPercentage
-- @usage -- This will 100 if fully charged
-- lib.function.battery.getBatteryPercentage() -- return percentage of battery
local function getBatteryPercentage()
    -- get back a battery location
    local battery = getBatteryPath()
    if battery == nil then
        return nil
    end

    -- battery exists, lets get the percentage back
    local value = filehandle.string(battery .. '/capacity')
    if value then
        value = value:gsub('\n', '')
        return tonumber(value)
    end
    -- something went wrong parsing the value
    return 0
end

return {
    isBatteryCharging = isBatteryCharging,
    getBatteryPercentage = getBatteryPercentage,
    getBatteryPath = getBatteryPath
}
