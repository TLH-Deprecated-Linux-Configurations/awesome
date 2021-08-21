--  _______                   __         __                   __
-- |     __|.----.----.---.-.|  |_.----.|  |--.-----.---.-.--|  |
-- |__     ||  __|   _|  _  ||   _|  __||     |  _  |  _  |  _  |
-- |_______||____|__| |___._||____|____||__|__|   __|___._|_____|
--                                            |__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local awful = require('awful')
local bling = require('module.bling')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local awestore = require('awestore')
local helpers = require('helpers')
-- ########################################################################
-- ########################################################################
-- ########################################################################
local anim_x =
    awestore.tweened(
    -1010,
    {
        duration = 600,
        easing = awestore.easing.cubic_in_out
    }
)

local music_scratch =
    bling.module.scratchpad:new {
    command = music,
    rule = {instance = 'music'},
    sticky = false,
    autoclose = false,
    floating = true,
    geometry = {x = dpi(10), y = dpi(606), height = dpi(460), width = dpi(960)},
    reapply = true,
    awestore = {x = anim_x}
}

awesome.connect_signal(
    'scratch::music',
    function()
        music_scratch:toggle()
    end
)

local anim_y =
    awestore.tweened(
    1090,
    {
        duration = 600,
        easing = awestore.easing.cubic_in_out
    }
)

local chat_scratch =
    bling.module.scratchpad:new {
    command = [[ telegram ]],
    rule = {class = 'chat'},
    sticky = false,
    autoclose = false,
    floating = true,
    geometry = {x = dpi(460), y = dpi(90), height = dpi(900), width = dpi(1000)},
    reapply = true,
    awestore = {y = anim_y}
}

awesome.connect_signal(
    'scratch::chat',
    function()
        chat_scratch:toggle()
    end
)
