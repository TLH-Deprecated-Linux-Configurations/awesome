--  _______
-- |_     _|.----.-----.-----.-----.
--  _|   |_ |  __|  _  |     |__ --|
-- |_______||____|_____|__|__|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
--  This is to call all of the icon files that are stored configuration-wide
-- for whatever reason. I also try to keep icons in the directory of the
-- widget calling them but that is an on-going process and so this fills in
-- the gap for now
-- ########################################################################
-- ########################################################################
-- ########################################################################
local dir = os.getenv('HOME') .. '/.config/awesome/theme/icons/'

return {
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Taglist Directory
    text_editor = dir .. 'text-editor.svg',
    social = dir .. 'social.svg',
    file_manager = dir .. 'file-manager.svg',
    multimedia = dir .. 'multimedia.svg',
    development = dir .. 'development.svg',
    sandbox = dir .. 'sandbox.svg',
    terminal = dir .. 'terminal.svg',
    graphics = dir .. 'graphics.svg',
    menu = dir .. 'menu.svg',
    close_small = dir .. 'close-small.svg',
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Others/System UI
    web_browser = dir .. 'web-browser.svg',
    close = dir .. 'close.svg',
    logout = dir .. 'logout.svg',
    sleep = dir .. 'power-sleep.svg',
    power = dir .. 'power.svg',
    lock = dir .. 'lock.svg',
    restart = dir .. 'restart.svg',
    search = dir .. 'magnify.svg',
    volume = dir .. 'volume-high.svg',
    brightness = dir .. 'brightness-7.svg',
    effects = dir .. 'effects.svg',
    chart = dir .. 'chart-areaspline.svg',
    memory = dir .. 'memory.svg',
    harddisk = dir .. 'harddisk.svg',
    thermometer = dir .. 'thermometer.svg',
    plus = dir .. 'plus.svg',
    batt_charging = dir .. 'battery-charge.svg',
    batt_discharging = dir .. 'battery-discharge.svg',
    toggled_on = dir .. 'toggled-on.svg',
    toggled_off = dir .. 'toggled-off.svg'
}
