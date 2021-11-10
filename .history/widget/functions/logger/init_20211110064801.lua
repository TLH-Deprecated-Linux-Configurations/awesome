--  _____
-- |     |_.-----.-----.-----.-----.----.
-- |       |  _  |  _  |  _  |  -__|   _|
-- |_______|_____|___  |___  |_____|__|
--               |_____|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local filehandle = require("widget.functions.file")

-- store the old print variable into echo
echo = print
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- color coded log messages

--- Indicate that this print message is an error
-- @property error
-- @param string
local LOG_ERROR = "\27[0;31m[ ERROR "
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Indicate that this print message is a warning
-- @property warn
-- @param string
local LOG_WARN = "\27[0;33m[ WARN "
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Indicate that this print message is a debug message
-- @property debug
-- @param string
local LOG_DEBUG = "\27[0;35m[ DEBUG "
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Indicate that this print message is an info message
-- @property info
-- @param string
local LOG_INFO = "\27[0;32m[ INFO "
-- ########################################################################
-- ########################################################################
-- ########################################################################
local dir = os.getenv("HOME") .. "/.cache/awesome"
local filename = dir .. "/stdout.log"
local filename_error = dir .. "/error.log"

filehandle.overwrite(filename, "")
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- helper function to convert a table to a string
-- WARN: For internal use only, this should never be exposed to the end user
-- usage: local string = pretty_print_table({})
local function table_to_string(tbl, depth, indent)
        indent = indent or 1
    -- limit the max size
    if indent > depth then
        if type(tbl) == "table" then
            return "{  ..."
        end
        return ""
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local formatting = string.rep("  ", indent)
    local result = "{\n"
    for k, v in pairs(tbl) do
        local format = formatting .. tostring(k) .. ": "
        if type(v) == "table" then
            result = result .. format .. table_to_string(v, depth - 1, indent + 1) .. formatting .. "},\n"
        else
            if type(v) == "string" then
                result = result .. format .. "'" .. v .. "',\n"
            else
                result = result .. format .. tostring(v) .. ",\n"
            end
        end
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- edge case initial indentation requires manually adding ending bracket
    if indent == 1 then
        return result .. "}"
    end
    return result
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- The default lua print message is overridden
-- @tparam string arg The string to print
-- @tparam[opt] enum log_type The type of log message
-- @tparam[opt] depth number In case you print a table, show the table until a certain depth
-- @staticfct print
-- @usage -- Print the error message "hello"
-- print("hello", logger.error)
print = function(arg, log_type, depth)
    depth = depth or 3
    -- validate the input
    if arg == nil or _G.UNIT_TESTING_ACTIVE == true then
        return
    end
    if type(arg) == "table" then
        arg = table_to_string(arg, depth)
    end
    if not (type(arg) == "string") then
        arg = tostring(arg)
    end

    local log = log_type or LOG_INFO
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- effective logging
    local file = io.open(filename, "a")
    local file_error
    if log == LOG_ERROR then
        file_error = io.open(filename_error, "a")
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local out = os.date("%H:%M:%S") .. "." .. math.floor(time() * 10000) % 10000
    local statement = log .. out:gsub("\n", "") .. " ]\27[0m "
    for line in arg:gmatch("[^\r\n]+") do
        -- print it to stdout
        echo(statement .. line)
        -- append it to the log file
        if file ~= nil then
            file:write(statement .. line .. "\n")
        end
        if file_error ~= nil and log == LOG_ERROR then
            file_error:write(statement .. line .. "\n")
        end
    end
    if file ~= nil then
        file:close()
    end
    if file_error ~= nil then
        file_error:close()
    end
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return {
    warn = LOG_WARN,
    error = LOG_ERROR,
    debug = LOG_DEBUG,
    info = LOG_INFO
}
