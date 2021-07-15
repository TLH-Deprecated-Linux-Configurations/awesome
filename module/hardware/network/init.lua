---------------------------------------------------------------------------
-- This module adds a simple api to extract wifi ssid data
--
-- @author Tom Meyers
-- @copyright 2020 Tom Meyers
-- @tdemod module.hardware.network
---------------------------------------------------------------------------

local split = require("lib.function.common").split

local function __extract_ssid_line(line)
    collectgarbage("collect")
    local splitted = split(line, "%s")
    local result = {
        active = false
    }

    local bSSIDEnded = false
    for i, value in ipairs(splitted) do
        if value == "Infra" then
            bSSIDEnded = true
        end

        if i >= 2 and result["bssid"] ~= nil and not bSSIDEnded then
            if result["ssid"] == nil then
                result["ssid"] = value
            else
                result["ssid"] = result["ssid"] .. " " .. value
            end
        end

        if i == 1 and value == "*" then
            result["active"] = true
        elseif i == 1 then
            result["bssid"] = value
        end

        if i == 2 and result["active"] then
            result["bssid"] = value
        end
    end

    -- invalid ssid
    if result["ssid"] == "--" then
        return nil
    end

    return result
end

--- Get a list back of all found ssid's by the network card
-- @tparam function callback A callback with a table as input (List of all networks with the key being the ssid)
-- @staticfct get_ssid_list
-- @usage -- This will return {"network ssid": {"ssid": "network ssid", "bssid": "aa:bb:cc:ee:ff:11", "active": true}}
-- module.hardware.network.get_ssid_list(function (list)
--    for ssid, tbl in pairs(list) do
--        print(tbl["ssid"] .. ": " .. tbl["bssid"] .. " - is connection active: " .. tbl["active"])
--    end
-- end)
local function get_ssid_list(callback)
    collectgarbage("collect")
    awful.spawn.easy_async_with_shell(
        "nmcli dev wifi list",
        function(out)
            local lines = split(out, "\n")
            local result = {}

            for i, line in ipairs(lines) do
                -- logic to skip the heading
                if i > 1 then
                    print(line)
                    local extracted = __extract_ssid_line(line)
                    if extracted ~= nil and result[extracted.ssid] == nil then
                        result[extracted.ssid] = extracted
                    elseif extracted ~= nil and not result[extracted.ssid]["active"] then
                        result[extracted.ssid] = extracted
                    end
                end
            end

            callback(result)
        end
    )
end

return {
    get_ssid_list = get_ssid_list
}
