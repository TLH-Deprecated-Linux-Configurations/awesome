--  _______ __          __
-- |     __|  |_.---.-.|  |_.-----.
-- |__     |   _|  _  ||   _|  -__|
-- |_______|____|___._||____|_____|

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- This module listens for events and stores then
-- This makes certain data persistent

local signals = require('widget.settings.signals')
local serialize = require('widget.functions.serialize')
local filehandle = require('widget.functions.file')

local volume = require('widget.hardware.volume')

local file = os.getenv('HOME') .. '/.cache/awesome/settings_state.json'
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function load()
    local table = {
        volume = 50,
        volume_muted = false,
        brightness = 100,
        mouse = {}
    }
    if not filehandle.exists(file) then
        return table
    end
    local result = serialize.deserialize_from_file(file)
    -- in case someone modified the state object and some properties are faulty or errored outputs
    result.volume = result.volume or table.volume
    result.volume_muted = result.volume_muted or table.volume_muted
    result.brightness = result.brightness or table.brightness
    result.mouse = result.mouse or table.mouse
    result.do_not_disturb = result.do_not_disturb or table.do_not_disturb
    result.oled_mode = result.oled_mode or table.oled_mode
    return result
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function save(table)
    print('Updating state into: ' .. file)
    serialize.serialize_to_file(file, table)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function setup_state(state)
    -- set volume mute state
    volume.set_muted_state(state.volume_muted)
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- set the volume
    print('Setting volume: ' .. state.volume)
    volume.set_volume(state.volume or 0)
    signals.emit_volume_update()
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- set the brightness
    if (_G.oled) then
        awful.spawn('brightness -s ' .. math.max(state.brightness, 5) .. ' -F') -- toggle pixel values
    else
        awful.spawn('brightness -s 100 -F') -- reset pixel values
        awful.spawn('brightness -s ' .. math.max(state.brightness, 5))
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    signals.emit_brightness(math.max(state.brightness, 5))
    signals.emit_do_not_disturb(state.do_not_disturb or false)
    signals.emit_oled_mode(state.oled_mode or false)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- load the initial state
-- luacheck: ignore 121
local save_state = load()
setup_state(save_state)

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- listen for events and store the state on those events

signals.connect_volume(
    function(value)
        save_state.volume = value
        save(save_state)
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
signals.connect_volume_is_muted(
    function(is_muted)
        save_state.volume_muted = is_muted
        save(save_state)
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
signals.connect_brightness(
    function(value)
        print('Brightness value: ' .. value)
        save_state.brightness = value
        save(save_state)
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
signals.connect_exit(
    function()
        print('Shutting down, grabbing last state')
        awful.spawn("sh -c 'which autorandr && autorandr --force'")
        save(save_state)
    end
)
