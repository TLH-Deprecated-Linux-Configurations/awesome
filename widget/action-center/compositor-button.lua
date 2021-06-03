
local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local mat_list_item = require("widget.material.list-item")
local checkbox = require("lib.checkbox")

local config = require("config")

local cmd = 'grep -F "blur-background-frame = false;" ' .. config.getComptonFile() .. "| tr -d '[\\-\\;\\=\\ ]' "
local frameStatus

------

-- The cmd variable is declared above
-- It checks the line "blur-background-frame: false;"
-- I use 'tr' shell command to remove the special characters
-- because lua is choosy on MATCH method
-- So the output will be 'blurbackgroundframefalse'
-- if it matches the assigned value inside the match method below
-- then it will declared as value of frameChecker
-- The rest is history
local frameChecker

-- Commands that will be executed when I toggle the button
local blurDisable = {
  'sed -i -e "s/blur-background-frame = true/blur-background-frame = false/g" ' .. config.getComptonFile(),
  "sleep 1; picom --dbus --experimental-backends --config " .. config.getComptonFile(),
  'notify-send "Blur effect disabled"'
}
local blurEnable = {
  'sed -i -e "s/blur-background-frame = false/blur-background-frame = true/g" ' .. config.getComptonFile(),
  "sleep 1; picom --dbus --experimental-backends --config " .. config.getComptonFile(),
  'notify-send "Blur effect enabled"'
}

local function run_once(blurCmd)
  local findme = blurCmd
  local firstspace = blurCmd:find(" ")
  if firstspace then
    findme = blurCmd:sub(0, firstspace - 1)
  end
  awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, blurCmd))
end

local function update_compositor()
  if (frameStatus == true) then
    awful.spawn.with_shell("kill -9 $(pidof picom)")
    for _, app in ipairs(blurDisable) do
      run_once(app)
    end
  else
    awful.spawn.with_shell("kill -9 $(pidof picom)")
    for _, app in ipairs(blurEnable) do
      run_once(app)
    end
  end
end

-----------------------------------------------------------------------------------------------------------------

local compton_button =
  checkbox(
  frameStatus,
  function(checked)
    frameStatus = checked
    update_compositor()
  end
)

local function checkFrame()
  awful.spawn.easy_async_with_shell(
    cmd,
    function(stdout)
      frameChecker = stdout:match("blurbackgroundframefalse")
      frameStatus = frameChecker == nil
      compton_button.update(frameStatus)
    end
  )
end

checkFrame()

local settingsName =
  wibox.widget {
  text = i18n.translate("Window Effects"),
  font = "Iosevka Regular 10",
  align = "left",
  widget = wibox.widget.textbox
}

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

local comptonButton =
  wibox.widget {
  wibox.widget {
    content,
    widget = mat_list_item
  },
  layout = wibox.layout.fixed.vertical
}

return comptonButton
