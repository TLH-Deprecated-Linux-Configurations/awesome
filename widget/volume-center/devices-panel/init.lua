--  _____               __
-- |     \.-----.--.--.|__|.----.-----.-----.
-- |  --  |  -__|  |  ||  ||  __|  -__|__ --|
-- |_____/|_____|\___/ |__||____|_____|_____|
--  ______                     __
-- |   __ \.---.-.-----.-----.|  |
-- |    __/|  _  |     |  -__||  |
-- |___|   |___._|__|__|_____||__|
-- ------------------------------------------------- --
local emptyCenter = require("widget.notification-center.empty")
local width = dpi(410)

local panelLayout = wibox.layout.fixed.vertical()

panelLayout.spacing = dpi(7)
panelLayout.forced_width = width

local resetDevicePanelLayout = function()
  panelLayout:reset(panelLayout)
end

local volumeDevicesAdded = function(n)
  local box = require("widget.volume-center.elements")
  panelLayout:insert(1, box.create(n.title, n.sinkNumText, n.sinkNum, n.isDefault))
end

awesome.connect_signal(
  "volume::devices:refreshPanel",
  function()
    resetDevicePanelLayout()
    awful.spawn.with_line_callback(
      [[bash -c "pactl list sinks | grep -E 'Description|Sink' | sed 's/Description: //g; N; s/\n//; s/\t//; s/Sink #//; s/Description://'"]],
      {
        stdout = function(line)
          awful.spawn.easy_async_with_shell(
            "pactl list sinks | grep -E 'Sink|Name' | sed 's/Description: //g; N; s/\\n//; s/\\t//g; s/Name://' | grep 'Sink #" ..
              line:sub(1, 1) .. "' | sed 's/Sink #" .. line:sub(1, 1) .. " //'",
            function(stdout)
              local name = stdout:gsub("\n", "")
              awful.spawn.easy_async_with_shell(
                [[bash -c "pactl get-default-sink"]],
                function(stdout)
                  if name == stdout:gsub("\n", "") then
                    volumeDevicesAdded(
                      {
                        title = line:sub(3),
                        sinkNumText = "Sink " .. line:sub(1, 1),
                        sinkNum = line:sub(1, 1),
                        isDefault = true
                      }
                    )
                  else
                    volumeDevicesAdded(
                      {
                        title = line:sub(3),
                        sinkNumText = "Sink " .. line:sub(1, 1),
                        sinkNum = line:sub(1, 1),
                        isDefault = false
                      }
                    )
                  end
                end
              )
            end
          )
        end
      }
    )
  end
)

return panelLayout
