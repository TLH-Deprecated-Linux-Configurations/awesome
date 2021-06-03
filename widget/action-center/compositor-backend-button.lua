
local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local mat_list_item = require("widget.material.list-item")
local checkbox = require("lib.checkbox")

local config = require("config")

local cmd = 'grep -F \'"glx";\' ' .. config.getComptonFile() .. "| tr -d '[\\-\\;\\=\\ ]' "
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
      print("Compositor backend: " .. stdout)
      frameChecker = stdout:match('backend"glx"')
      frameStatus = frameChecker ~= nil
      compton_button.update(frameStatus)
    end
  )
end

checkFrame()

local settingsName =
  wibox.widget {
  text = "Accelerated graphics composition",
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
