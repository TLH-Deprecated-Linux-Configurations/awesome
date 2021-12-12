--  _______ __         __           __
-- |     __|  |.-----.|  |--.---.-.|  |
-- |    |  |  ||  _  ||  _  |  _  ||  |
-- |_______|__||_____||_____|___._||__|
--  ___ ___              __         __     __
-- |   |   |.---.-.----.|__|.---.-.|  |--.|  |.-----.-----.
-- |   |   ||  _  |   _||  ||  _  ||  _  ||  ||  -__|__ --|
--  \_____/ |___._|__|  |__||___._||_____||__||_____|_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- This makes for neater files without boilerplate and improves the
-- developer experience considerably compared to the standard use of local
-- require statements to call libraries in per file
-- ########################################################################
-- ########################################################################
-- ########################################################################
local gears = require('gears')
local beautiful = require('beautiful')
local awful = require('awful')

local filesystem = require('gears.filesystem')
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. 'utilities/'
local HOME = os.getenv 'HOME'

local beautiful = require('beautiful')

awful.util.shell = 'zsh'
