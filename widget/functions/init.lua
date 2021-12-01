--  _______                    __   __
-- |    ___|.--.--.-----.----.|  |_|__|.-----.-----.-----.
-- |    ___||  |  |     |  __||   _|  ||  _  |     |__ --|
-- |___|    |_____|__|__|____||____|__||_____|__|__|_____|

-- ########################################################################
-- ########################################################################
-- ########################################################################

-- This file holds general configuration parameters and functions you can use
local HOME = os.getenv("HOME")
local gears = require("gears")
local filesystem = require("gears.filesystem")
local file_exists = require("widget.functions.file").exists

-- We add *_startup_delay to most polls
-- to separate the runtime
-- Otherwise all polls will run at the same time creating a peak of cpu usage
-- By spreading them out using delays we get lower cpu usage
-- ########################################################################
-- ########################################################################
-- ########################################################################
local config_functions = {
    battery_timeout = 20, -- How frequently we want to check our battery status in seconds
    player_reaction_time = 0.01, -- The time for the music player to respond to our play/pause action
    bluetooth_poll = 5, -- how often do we check if bluetooth is active/disabled
    network_poll = 5, -- how often we should try to detect the ssid name
    network_startup_delay = 1,
    harddisk_poll = 35, -- how often do we check how full the harddisk is
    harddisk_startup_delay = 3,
    temp_poll = 5, -- how often do we check the current temperature
    temp_startup_delay = 5,
    ram_poll = 5, -- how often do we check the current ram usage
    ram_startup_delay = 7,
    cpu_poll = 5, -- how often do we check the current cpu status
    cpu_startup_delay = 9,
    logo = HOME .. "/.config/awesome/theme/icons/logo.svg",
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    getComptonfile = function()
        local userfile = HOME .. "/.config/picom.conf"
        if (file_exists(userfile)) then
            return userfile
        end
        return filesystem.get_configuration_dir() .. "/external/picom.conf "
    end,
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    aboutText = "the Electric Tantra Linux " ..
        os.date("%Y") .. "\n\n" .. "The Linux Environment of Thomas Leon Highbaugh" .. " "
}

return config_functions
