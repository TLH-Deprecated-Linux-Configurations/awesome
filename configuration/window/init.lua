--  ________ __           __
-- |  |  |  |__|.-----.--|  |.-----.--.--.--.
-- |  |  |  |  ||     |  _  ||  _  |  |  |  |
-- |________|__||__|__|_____||_____|________|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local awful = require('awful')
local gears = require('gears')
local gfs = gears.filesystem
local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = require('beautiful.xresources').apply_dpi
local helpers = require('helpers')
local awestore = require('awestore')
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Bling Module

local bling = require('module.bling')
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- This is to slave windows' positions in floating layout
-- Not Mine
-- https://github.com/larkery/awesome/blob/master/savefloats.lua
require('configuration.window.savefloats')

-- Better mouse resizing on tiled
-- Not mine
-- https://github.com/larkery/awesome/blob/master/better-resize.lua
require('configuration.window.better-resize')
-- ########################################################################
-- ########################################################################
-- ########################################################################
client.connect_signal(
    'request::manage',
    function(c)
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Fade in animation (fade out is in keys)

        if not c.icon then
            local i = gears.surface(gfs.get_configuration_dir() .. 'icons/ghosts/awesome.png')
            c.icon = i._native
        end
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        local fade_in =
            awestore.tweened(
            0,
            {
                duration = beautiful.fade_duration,
                easing = awestore.easing.linear
            }
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        local unsub =
            fade_in:subscribe(
            function(o)
                if c and c.valid then
                    c.opacity = o / 100
                end
            end
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        fade_in:set(100)
        fade_in.ended:subscribe(
            function()
                unsub()
            end
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- if not awesome.startup then awful.client.setslave(c) end
        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Give ST and icon
        if c.class == 'st-256color' or c.class == 'st-dialog' or c.class == 'st-float' or c.instance == 'st-256color' then
            local new_icon = gears.surface(gfs.get_configuration_dir() .. 'icons/ghosts/terminal.png')
            c.icon = new_icon._native
        end
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal(
    'mouse::enter',
    function(c)
        c:emit_signal('request::activate', 'mouse_enter', {raise = false})
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
client.connect_signal(
    'focus',
    function(c)
        c.border_color = beautiful.border_focus
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
client.connect_signal(
    'unfocus',
    function(c)
        c.border_color = beautiful.border_normal
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
require('configuration.window.layouts')
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Hide all windows when a splash is shown
awesome.connect_signal(
    'widgets::splash::visibility',
    function(vis)
        local t = screen.primary.selected_tag
        if vis then
            for idx, c in ipairs(t:clients()) do
                c.hidden = true
            end
        else
            for idx, c in ipairs(t:clients()) do
                c.hidden = false
            end
        end
    end
)

-- EOF ------------------------------------------------------------------------
