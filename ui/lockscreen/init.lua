--  _____               __
-- |     |_.-----.----.|  |--.-----.----.----.-----.-----.-----.
-- |       |  _  |  __||    <|__ --|  __|   _|  -__|  -__|     |
-- |_______|_____|____||__|__|_____|____|__| |_____|_____|__|__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- serves as a wrapper in lua for the shell script I prefer for this
-- biggest advantage is the lockscreen uses your user password instead of one
-- that would be configured in this file or one of the others in this directory
-- (like a normal lockscreen)
local awful = require('awful')
local gfs = require('gears.filesystem')
local HOME = os.getenv 'HOME'
-- ########################################################################
-- ########################################################################
-- ########################################################################
local lock_screen = {}

local config_dir = gfs.get_configuration_dir()

lock_screen.init = function()
    -- preven triggeriing when awesome starts
    if not awesome.startup then
        awful.spawn('bash ' .. HOME .. '/.config/awesome/ui/lockscreen/blur.sh')
    end
end
return lock_screen
