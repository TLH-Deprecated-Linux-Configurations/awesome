
-- menu takes a bit of time to load in.
-- because of this we put it in the back so the rest of the system can already behave
-- Look into awesome-freedesktop for more information

require("module.menu")

if not (general["disable_desktop"] == "1") then
    require("module.installer")
    require("module.desktop")
end

-- restore the last state
require("module.state")
require("tutorial")

require("module.dev-widget-update")

require("lib-tde.signals").connect_exit(
    function()
        -- stop current autorun.sh
        -- This is done because otherwise multiple instances would be running at the same time
        awful.spawn("pgrep -f /etc/xdg/tde/autorun.sh | xargs kill -9")
    end
)

local lockscreentime = general["screen_on_time"] or "120"
if general["screen_timeout"] == 1 or general["screen_timeout"] == nil then
    awful.spawn("/etc/xdg/tde/autorun.sh " .. lockscreentime)
else
    awful.spawn("/etc/xdg/tde/autorun.sh")
end

require("module.screen_changed")
