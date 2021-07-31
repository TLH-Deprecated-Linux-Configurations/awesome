--  _____                          _____                  __
-- |     |_.---.-.-----.--.--.    |     |_.-----.---.-.--|  |.-----.----.
-- |       |  _  |-- __|  |  |    |       |  _  |  _  |  _  ||  -__|   _|
-- |_______|___._|_____|___  |    |_______|_____|___._|_____||_____|__|
--                     |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- menu takes a bit of time to load in.
-- because of this we put it in the back so the rest of the system can already behave
-- Look into awesome-freedesktop for more information
local HOME = os.getenv("HOME")

require("module.interface.menu")

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- restore the last state
require("module.settings.state")
require("widget.tutorial")

require("module.functions.dev-widget-update")
-- ########################################################################
-- ########################################################################
-- ########################################################################
require("module.settings.signals").connect_exit(
    function()
        -- stop current autorun.sh
        -- This is done because otherwise multiple instances would be running at the same time
        awful.spawn("pgrep -f" .. HOME .. ".config/awesome/autorun.sh | xargs kill -9")
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local lockscreentime = "5"
awful.spawn(HOME .. "/.config/awesome/autorun.sh " .. lockscreentime)
-- ########################################################################
-- ########################################################################
-- ########################################################################
require("module.hardware.screen_changed")
