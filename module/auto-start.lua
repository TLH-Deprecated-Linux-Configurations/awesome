--  _______ _______ _______ _______
-- |   _   |   |   |_     _|       |
-- |       |   |   | |   | |   -   |
-- |___|___|_______| |___| |_______|

--  _______ _______ _______ ______ _______
-- |     __|_     _|   _   |   __ \_     _|
-- |__     | |   | |       |      < |   |
-- |_______| |___| |___|___|___|__| |___|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Run all the apps listed in configuration/apps.lua as run_on_start_up only once when awesome start
-- ########################################################################
-- ########################################################################
-- ########################################################################

local config = require('configuration.config')
local debug_mode = config.module.auto_start.debug_mode or false
-- ########################################################################
-- ########################################################################
-- ########################################################################
local run_once = function(cmd)
    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then
        findme = cmd:sub(0, firstspace - 1)
    end
    awful.spawn.easy_async_with_shell(
        string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd),
        function(stdout, stderr)
            -- Debugger
            if not stderr or stderr == '' or not debug_mode then
                return
            end
            naughty.notification(
                {
                    app_name = 'Start-up Applications',
                    title = '<b>Danger Will Robinson! Danger! Danger! Error detected when starting an application!</b>',
                    message = stderr:gsub('%\n', ''),
                    timeout = 20,
                    icon = require('beautiful').awesome_icon
                }
            )
        end
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
for _, app in ipairs(apps.run_on_start_up) do
    run_once(app)
end
