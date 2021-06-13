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
local HOME = os.getenv('HOME')

require('module.menu')

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- restore the last state
require('module.state')
require('tutorial')

require('module.dev-widget-update')
-- ########################################################################
-- ########################################################################
-- ########################################################################
require('module.signals').connect_exit(
    function()
        -- stop current autorun.sh
        -- This is done because otherwise multiple instances would be running at the same time
        awful.spawn('pgrep -f' .. HOME .. '.config/awesome/autorun.sh | xargs kill -9')
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local lockscreentime = '120'
if general['screen_timeout'] == 1 or general['screen_timeout'] == nil then
    awful.spawn(HOME .. '/.config/awesome/autorun.sh ' .. lockscreentime)
else
    awful.spawn(HOME .. '/.config/awesome/autorun.sh')
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
require('module.screen_changed')
