--  ___ ___ __
-- |   |   |__|.----.-----.
-- |   |   |  ||  __|  -__|
--  \_____/|__||____|_____|
--  _______         __               __         __      ______         __
-- |   |   |.---.-.|  |_.-----.----.|__|.---.-.|  |    |      |.-----.|  |.-----.----.-----.
-- |       ||  _  ||   _|  -__|   _||  ||  _  ||  |    |   ---||  _  ||  ||  _  |   _|__ --|
-- |__|_|__||___._||____|_____|__|  |__||___._||__|    |______||_____||__||_____|__| |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local filesystem = require('gears.filesystem')
local mat_colors = require('theme.mat-colors')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local dpi = require('beautiful').xresources.apply_dpi
local xresources = require('beautiful.xresources')
local xrdb = xresources.get_current_theme()

-- ########################################################################
-- ########################################################################
-- ########################################################################
local theme = {}
theme.xbackground = xrdb.background
theme.background = xrdb.background
theme.xforeground = xrdb.foreground
theme.foreground = xrdb.foreground
theme.xcolor0 = xrdb.color0
theme.xcolor1 = xrdb.color1
theme.xcolor2 = xrdb.color2
theme.xcolor3 = xrdb.color3
theme.xcolor4 = xrdb.color4
theme.xcolor5 = xrdb.color5
theme.xcolor6 = xrdb.color6
theme.xcolor7 = xrdb.color7
theme.xcolor8 = xrdb.color8
theme.xcolor9 = xrdb.color9
theme.xcolor10 = xrdb.color10
theme.xcolor11 = xrdb.color11
theme.xcolor12 = xrdb.color12
theme.xcolor13 = xrdb.color13
theme.xcolor14 = xrdb.color14
theme.xcolor15 = xrdb.color15
theme.xcolor16 = '#555e70'
theme.xcolor17 = '#b2bfd9'
theme.xcolor18 = '#22262d'
theme.xcolor19 = '#727f96'

-- ########################################################################
-- ########################################################################
-- ########################################################################
theme.icons = theme_dir .. '/icons/'
theme.font = 'agave Nerd Font Mono Bold'
theme.taglist_font = 'awesomewm-font 22'
theme.taglist_spacing = 1
theme.useless_gap = dpi(4)
theme.titlebars_enabled = true

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Colors Pallets

-- Primary
theme.primary = '#8b9cbe'

-- Accent
theme.accent = '#8265ff'

-- Background
theme.background = mat_colors.huegrey3

-- ########################################################################
-- ########################################################################
-- ########################################################################

theme.background.hue_800 = mat_colors.huegrey3.hue_800 .. '66'

theme.background.hue_900 = mat_colors.huegrey3.hue_900 .. '66'

local awesome_overrides = function(_)
    --
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return {theme = theme, awesome_overrides = awesome_overrides}
