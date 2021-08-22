--  _____                            __
-- |     |_.---.-.--.--.-----.--.--.|  |_.-----.
-- |       |  _  |  |  |  _  |  |  ||   _|__ --|
-- |_______|___._|___  |_____|_____||____|_____|
--               |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Libraries and Modules
local awful = require('awful')
local gears = require('gears')
local gfs = gears.filesystem
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = require('beautiful.xresources').apply_dpi
local helpers = require('helpers')
local awestore = require('awestore')
local bling = require('module.bling')

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Bling Provided Layouts
local mstab = bling.layout.mstab
local centered = bling.layout.centered
local vertical = bling.layout.vertical
local horizontal = bling.layout.horizontal
local equal = bling.layout.equalarea

-- Custom Layouts
-- TODO add icons for these in theme
local stack = require 'configuration.window.layouts.stack'
local empathy = require 'configuration.window.layouts.empathy'
local centermaster = require 'configuration.window.layouts.centermaster'
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Set the layouts, order is the order they will be in for the tags top being first.

tag.connect_signal(
    'request::default_layouts',
    function()
        awful.layout.append_default_layouts(
            {
                stack,
                empathy,
                centermaster,
                mstab,
                awful.layout.suit.tile,
                awful.layout.suit.floating,
                centered,
                vertical,
                horizontal,
                equal,
                awful.layout.suit.spiral,
                awful.layout.suit.spiral.dwindle,
                awful.layout.suit.max
                --      awful.layout.suit.floating,
                --    awful.layout.suit.tile,
                --     awful.layout.suit.tile.left,
                --     awful.layout.suit.tile.bottom,
                --     awful.layout.suit.tile.top,
                --     awful.layout.suit.fair,
                --     awful.layout.suit.fair.horizontal,

                --      awful.layout.suit.max.fullscreen,
                --      awful.layout.suit.magnifier,
                --      awful.layout.suit.corner.nw
                -- awful.layout.suit.corner.ne,
                -- awful.layout.suit.corner.sw,
                -- awful.layout.suit.corner.se,
            }
        )
    end
)
require 'configuration.window.layouts.layout_list'
