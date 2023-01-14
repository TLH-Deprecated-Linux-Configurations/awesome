--  ______ __               __
-- |      |__|.-----.-----.|  |_
-- |   ---|  ||  -__|     ||   _|
-- |______|__||_____|__|__||____|
--  __  __
-- |  |/  |.-----.--.--.-----.
-- |     < |  -__|  |  |__ --|
-- |__|\__||_____|___  |_____|
--               |_____|
-- ------------------------------------------------- --
-- NOTE: This assigns the keys specific to client windows
-- --------------------- Calls --------------------- --
local awful = require('awful')

local modkey = 'Mod4'
local altkey = 'Mod1'
local snap_edge = require('utilities.client.snap_edge')
-- _G.client.focus = c
-- ------------------------------------------------- --
-- Call in the maps for the client keys
local clientmap = require('configuration.root.keys.maps.client')
local snapmap = require('configuration.root.keys.maps.snap')
local resizemap = require('configuration.root.keys.maps.resize')
local movemap = require('configuration.root.keys.maps.move')
-- ------------------------------------------------- --

-- Now we call modalbinding from utils to make the above useful
local modalbind = require('utilities.client.modalbind')
modalbind.init()

-- numpad key codes 1-9
-- local numpad_map = {87, 88, 89, 83, 84, 85, 79, 80, 81}

require('awful.autofocus')
-- ------------------------------------------------- --
local clientkeys =
  awful.util.table.join(
  -- modals use alt + key to activate
  awful.key(
    {'Mod1'},
    'r',
    function()
      modalbind.grab {
        keymap = resizemap,
        name = 'Window Resizing',
        stay_in_mode = true
      }
    end,
    {description = 'Enter Window Resizing Mode', group = 'Floating Client'}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {'Mod1'},
    's',
    function()
      modalbind.grab {
        keymap = snapmap,
        name = 'Window Snapping',
        stay_in_mode = true
      }
    end,
    {description = 'Enter Window Snapping Mode', group = 'Floating Client'}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {'Mod1'},
    'm',
    function()
      modalbind.grab {
        keymap = movemap,
        name = 'Window Movement',
        stay_in_mode = true
      }
    end,
    {description = 'Enter Window Movement Mode', group = 'Floating Client'}
  ),
  -- ------------------------------------------------- --
  awful.key(
    {'Mod1'},
    'd',
    function()
      modalbind.grab {
        keymap = clientmap,
        name = 'Client Control',
        stay_in_mode = false
      }
    end,
    {description = 'Enter Client Control Mode', group = 'Client'}
  )
)
-- ------------------------------------------------- --
return clientkeys
