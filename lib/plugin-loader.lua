
local dirExists = require("lib.file").dir_exists
local naughty = require("naughty")
local icons = require("theme.icons")
local ERROR = require("lib.logger").error

local function getItem(item)
    return plugins[item] or nil
end

local function inValidPlugin(name, msg)
    print("Plugin " .. name .. " is not valid!")
    print(name .. " returned: " .. msg)
    -- notify the user that a wrong plugin was entered
    naughty.notification(
        {
            title = i18n.translate("Plugin System"),
            text = 'Plugin <span weight="bold">' .. name .. "</span>\n" .. msg,
            timeout = 5,
            urgency = "critical",
            icon = icons.warning
        }
    )
end

local function prequire(library)
    local status, lib = pcall(require, library)
    if (status) then
        return lib
    end
    print(lib, ERROR)
    return nil
end

local function handle_plugin(value, name)
    -- system plugins are also accepted and start with widget.
    if value:sub(1, 7) == "widget." then
        if
            general["minimize_network_usage"] == "1" and
                (value == "widget.sars-cov-2" or value == "widget.weather")
         then
            print("Disabled widget: '" .. value .. "' due to low network requirements")
        else
            -- only require plugin if it exists
            -- otherwise the user entered a wrong plugin
            return true, require(value)
        end
    elseif dirExists(os.getenv("HOME") .. "/.config/awesome/plugins/" .. value) then
        local plugin = prequire(value)
        if (plugin) then
            print("Plugin " .. name .. " is loaded in!")
            return true, plugin
        else
            inValidPlugin(
                name,
                "Errored out while loading. Make sure your plugins is the latest version."
            )
        end
    else
        inValidPlugin(name, "Not found. Make sure it is present in  ~/.config/awesome/plugins/" .. name .. "/init.lua")
    end
    return false
end

local function getPluginSection(section)
    print(section .. " plugin loading started")
    local iterator = {}
    local item = getItem(section)
    if item == nil then
        return iterator
    end
    if type(item) == "table" then
        for _, value in ipairs(getItem(section)) do
            local valid, plugin = handle_plugin(value, section)
            if valid then
                table.insert(iterator, plugin)
            end
        end
    else
        local valid, plugin = handle_plugin(item, section)
        if valid then
            table.insert(iterator, plugin)
        end
    end

    print(section .. " plugin loading ended")
    return iterator
end

return getPluginSection
