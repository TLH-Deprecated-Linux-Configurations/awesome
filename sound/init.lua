-- Icons directory
local soundPath = "/usr/share/sounds/Yaru/stereo/"

local function play_sound()
    print("Playing audio-pop sound")
    spawn.with_shell("paplay ~/.config/awesome/sound/audio-pop.wav")
end
return play_sound

