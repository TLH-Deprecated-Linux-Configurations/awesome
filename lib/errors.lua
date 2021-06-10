-- This script listens for errors and sends them to sentry.odex.be
-- It is used to debug common errors and make the user experience better
-- Information that is stored by sentry:
--  * username
--  * hostname
--  * TDE version
--  * stack trace of error

local sentrypkg = require("lib-tde.sentry")
local release = require("release")
local logger = require("lib-tde.logger")
local loglevel = logger.error
local warn = logger.warn

print("Resolved release to: " .. release)
print("Resolved environment to: " .. (os.getenv("TDE_ENV") or "production"))

local sentry =
    sentrypkg.new {
    sender = require("lib-tde.sentry.senders.luasocket").new {
        dsn = "https://4684617907b540c0a3caf0245e1d6a2a@sentry.odex.be/6"
    },
    logger = "TDE-log",
    release = release,
    environment = os.getenv("TDE_ENV") or "production",
    tags = {
        version = awesome.version,
        wmrelease = awesome.release,
        hostname = awesome.hostname
    }
}

local function removeStackTraceFromMSG(msg)
    -- find a match for stack traceback
    local i, j = msg:find("stack traceback:")

    -- if stack traceback was not found then we return the entire message
    if i == nil or j == nil then
        return msg
    end

    return msg:sub(1, i - 1)
end

local function send(msg)
    print("Caught Error", loglevel)
    local message = removeStackTraceFromMSG(tostring(msg))
    print(message, loglevel)
    local exception = {
        {
            ["type"] = "Error",
            ["value"] = message,
            ["module"] = "tde"
        }
    }
    sentry:captureException(
        exception,
        {
            tags = {
                compositor = awesome.composite_manager_running
            }
        }
    )
end

local in_error = false
local function send_error(msg)
    -- Make sure we don't go into an endless error loop
    if in_error then
        return
    end
    in_error = true
    if general["minimize_network_usage"] ~= "1" then
        send(msg)
    end
    in_error = false
end

awesome.connect_signal("debug::error_msg", send_error)

awesome.connect_signal(
    "debug::warn_msg",
    function(msg)
        print(msg, warn)
    end
)

awesome.connect_signal("debug::error", send_error)

return sentry
