-- Icons directory
local soundPath = '/usr/share/sounds/Pop/stereo/notification/'

local function play_sound()
    print('Playing audio-pop sound')
    spawn('paplay ~/.config/awesome/sound/audio-pop.wav')
end
return {
    play_sound,
    startup = soundPath .. 'system-ready.oga',
    logout = soundPath .. 'system-shutdown.oga',
    close = soundPath .. 'device-removed.oga',
    maximize = soundPath .. 'device-added.oga',
    unmaximize = soundPath .. 'device-remove.oga',
    minimize = soundPath .. 'window-attention-inactive.oga',
    tile = soundPath .. 'complete.oga',
    notification = soundPath .. 'notification.oga',
    volume = soundPath .. 'volume.oga',
    plug = soundPath .. 'power-plug.oga',
    unplug = soundPath .. 'device-removed.oga',
    map = soundPath .. 'message.oga',
    switch = soundPath .. 'device-added.oga',
    trash = soundPath .. 'window-attention-inactive.oga'
}
