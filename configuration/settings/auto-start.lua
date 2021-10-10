-- --   _______ _______ _______ _______        _______ _______ _______ ______ _______
--     |   _   |   |   |_     _|       |______|     __|_     _|   _   |   __ \_     _|
--    |       |   |   | |   | |   -   |______|__     | |   | |       |      < |   |
--   |___|___|_______| |___| |_______|      |_______| |___| |___|___|___|__| |___|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Run all the apps listed in configuration/apps.lua as run_on_start_up only once when awesome start

local apps = require("configuration.settings.apps")
local run_once = require("lib.function.application_runner")
local delayed_timer = require("lib.function.delayed-timer")
local HOME = os.getenv "HOME"

-- ########################################################################
-- ########################################################################
-- ########################################################################
for _, app in ipairs(apps.run_on_start_up) do
    run_once(app)
end

-- ########################################################################
-- ########################################################################
-- ########################################################################
delayed_timer(
    5,
    function()
        -- picom crashed, we have to restart it again
        if not awesome.composite_manager_running then
            awful.spawn(apps.run_on_start_up[1])
        end
        awful.spawn(HOME .. "/.config/awesome/bin/autorun.sh")
    end,
    5
)
