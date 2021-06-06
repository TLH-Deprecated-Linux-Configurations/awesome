--  ______                                    __ __
-- |      |.-----.--------.-----.-----.-----.|__|  |_.-----.----.
-- |   ---||  _  |        |  _  |  _  |__ --||  |   _|  _  |   _|
-- |______||_____|__|__|__|   __|_____|_____||__|____|_____|__|
--                        |__|
--  ______              __                   __
-- |   __ \.---.-.----.|  |--.-----.-----.--|  |
-- |   __ <|  _  |  __||    <|  -__|     |  _  |
-- |______/|___._|____||__|__|_____|__|__|_____|

-- ########################################################################
-- ########################################################################
-- ########################################################################
local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local mat_list_item = require("widget.material.list-item")
local checkbox = require("lib.checkbox")

local config = require("config")

-- ########################################################################
-- Command ################################################################
-- ########################################################################
-- Checks that background blur is false
-- tr command removes special characters because lua is choosy on MATCH method

local cmd = 'grep -F \'"glx";\' ' .. config.getComptonFile() .. "| tr -d '[\\-\\;\\=\\ ]' "
local frameStatus
-- ########################################################################
-- ########################################################################
-- ########################################################################

local frameChecker

-- ########################################################################
-- Commands User Toggles ##################################################
-- ########################################################################
local glxDisable = {
  'sed -i -e \'s/"glx";/"xrender";/g\' ' .. config.getComptonFile(),
  "picom -b --dbus --experimental-backends --config " .. config.getComptonFile(),
  'notify-send "Xrenderer backend enabled"'
}
local glxEnable = {
  'sed -i -e \'s/"xrender";/"glx";/g\' ' .. config.getComptonFile(),
  "picom -b --dbus --experimental-backends --config " .. config.getComptonFile(),
  'notify-send "GLX effect enabled"'
}

local function run_once(glxCmd)
  local findme = glxCmd
  local firstspace = glxCmd:find(" ")
  if firstspace then
    findme = glxCmd:sub(0, firstspace - 1)
  end
  print("Running command: " .. string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, glxCmd))
  awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, glxCmd))
end

local function update_compositor()
  if (frameStatus == false) then
    awful.spawn.with_shell("kill -9 $(pidof picom)")
    for _, app in ipairs(glxDisable) do
      run_once(app)
    end
  else
    awful.spawn.with_shell("kill -9 $(pidof picom)")
    for _, app in ipairs(glxEnable) do
      run_once(app)
    end
  end
end

-- ########################################################################
-- ########################################################################
-- ########################################################################

local compton_button =
  checkbox(
  frameStatus,
  function(checked)
    frameStatus = checked
    update_compositor()
  end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function checkFrame()
  awful.spawn.easy_async_with_shell(
    cmd,
    function(stdout)
      print("Compositor backend: " .. stdout)
      frameChecker = stdout:match('backend"glx"')
      frameStatus = frameChecker ~= nil
      compton_button.update(frameStatus)
    end
  )
end

checkFrame()
-- ########################################################################
-- ########################################################################
-- ########################################################################
local settingsName =
  wibox.widget {
  text = "Accelerated graphics composition",
  font = "Hurmit Nerd Font Mono bold10",
  align = "left",
  widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local content =
  wibox.widget {
  settingsName,
  wibox.container.margin(compton_button, 0, 0, dpi(5), dpi(5)),
  bg = "#ffffff20",
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background(settingsName),
  layout = wibox.layout.ratio.horizontal
}
content:set_ratio(1, .85)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local comptonButton =
  wibox.widget {
  wibox.widget {
    content,
    widget = mat_list_item
  },
  layout = wibox.layout.fixed.vertical
}
-- ########################################################################
-- Return Widget ##########################################################
-- ########################################################################
return comptonButton
