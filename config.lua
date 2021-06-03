-- This file holds general configuration parameters and functions you can use
local HOME = os.getenv("HOME")
local filesystem = require("gears.filesystem")
local file_exists = require("lib.file").exists

-- We add *_startup_delay to most polls
-- to separate the runtime
-- Otherwise all polls will run at the same time creating a peak of cpu usage
-- By spreading them out using delays we get lower cpu usage

local config = {
    package_timeout = 180, -- how frequently we want to check if there are new updates in seconds
    battery_timeout = 20, -- How frequently we want to check our battery status in seconds
    player_reaction_time = 0.01, -- The time for the music player to respond to our play/pause action
    player_update = 5, -- Timeout to check if a new song is playing
    bluetooth_poll = 5, -- how often do we check if bluetooth is active/disabled
    network_poll = 5, -- how often we should try to detect the ssid name
    network_startup_delay = 1,
    harddisk_poll = 5, -- how often do we check how full the harddisk is
    harddisk_startup_delay = 3,
    temp_poll = 5, -- how often do we check the current temperature
    temp_startup_delay = 5,
    ram_poll = 5, -- how often do we check the current ram usage
    ram_startup_delay = 7,
    weather_poll = 1200, -- how often we check the weather status
    cpu_poll = 5, -- how often do we check the current cpu status
    cpu_startup_delay = 9,
    garbage_collection_cycle = 2 * 60, -- collect garbage every x seconds
    colors_config = HOME .. "/.config/awesome/electric-tantra/colors.conf",
    icons_config = HOME .. "/.config/awesome/electric-tantra/icons.conf",
    logo = HOME .. "/.config/awesome/theme/icons/logo.svg",
    getComptonFile = function()
        local userfile = HOME .. "/.config/picom.conf"
        if (file_exists(userfile)) then
            return userfile
        end
        return filesystem.get_configuration_dir() .. "/external/picom.conf "
    end,
    aboutText = "the Electric Tantra Linux " ..
        os.date("%Y") .. "\n\n" .. i18n.translate("The Linux Environment of Thomas Leon Highbaugh") .. " "
}

return config
