--  ________ __           __
-- |  |  |  |__|.-----.--|  |.-----.--.--.--.
-- |  |  |  |  ||     |  _  ||  _  |  |  |  |
-- |________|__||__|__|_____||_____|________|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- This is the init file of the window configurations and associated things
-- Except the decorations of the window which are handled in UI and Theme
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
require('configuration.window.savefloats')

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
            local i = gears.surface(gfs.get_configuration_dir() .. 'theme/icons/ghosts/awesome.png')
            c.icon = i._native
        end

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
        -- unsubscribe from animation
        local unsub =
            fade_in:subscribe(
            function(o)
                if c and c.valid then
                    c.opacity = o / 100
                end
            end
        )

        fade_in:set(100)
        fade_in.ended:subscribe(
            function()
                unsub()
            end
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- set windows behind in queue
        -- if not awesome.startup then
        --     awful.client.setslave(c)
        -- end
        -- Insure Windows are onscreen
        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Enable sloppy focus, so that focus follows mouse. not click to focus
client.connect_signal(
    'mouse::enter',
    function(c)
        c:emit_signal('request::activate', 'mouse_enter', {raise = false})
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Assign focus border to client focused
client.connect_signal(
    'focus',
    function(c)
        c.border_color = beautiful.border_focus
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- unfocus from client and restore border
client.connect_signal(
    'unfocus',
    function(c)
        c.border_color = beautiful.border_normal
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Add in layout configuration
require('configuration.layouts')
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
local function backup()
    local s = awful.screen.focused()
    local c = awful.client.focus.history.get(s, 0)
    if c then
        client.focus = c
        c:raise()
    end
end

-- ########################################################################
-- ########################################################################
-- ########################################################################

--+ attach to minimized state

client.connect_signal('property::minimized', backup)

--+ attach to closed state

client.connect_signal('unmanage', backup)
