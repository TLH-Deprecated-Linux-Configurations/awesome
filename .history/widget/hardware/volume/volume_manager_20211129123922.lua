-- .--.--.-----.|  |.--.--.--------.-----.    .--------.---.-.-----.---.-.-----.-----.----.
-- |  |  |  _  ||  ||  |  |        |  -__|    |        |  _  |     |  _  |  _  |  -__|   _|
--  \___/|_____||__||_____|__|__|__|_____|    |__|__|__|___._|__|__|___._|___  |_____|__|
--                                                                       |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local signals = require("configuration.settings.signals")
local time = require("lib.lib-lua.socket.headers").time
local volume = require("widget.hardware.volume")

local startup = true
local prev_time = 0
local boot_time = time()
local deltaTime = 0.1

local function play_sound()
    print("Playing audio-pop sound")
    spawn.with_shell("paplay ~/.config/awesome/sound/audio-pop.wav")
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
signals.connect_volume(
    function(value)
        -- we set prev_time initially to a higher value so we don't hear a pop sound when starting up the DE
            volume.set_volume(value)
            play_sound()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
signals.connect_volume_update(
    function()
        volume.get_volume(
            function(volume_level, muted)
                -- if the sound system is down then default to a volume of 0
                signals.emit_volume(volume_level)
                signals.emit_volume_is_muted(muted)
                if not startup and time() > (boot_time + 5) then
                    if _G.toggleVolOSD ~= nil then
                        _G.toggleVolOSD(true)
                    end
                    if _G.UpdateVolOSD ~= nil then
                        _G.UpdateVolOSD()
                    end
                else
                    startup = false
                end
            end
        )
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- request a volume update on startup
signals.emit_volume_update()
