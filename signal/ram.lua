--  ______
-- |   __ \.---.-.--------.
-- |      <|  _  |        |
-- |___|__||___._|__|__|__|

-- Provides:
-- signal::ram
--      used (integer - mega bytes)
--      total (integer - mega bytes)
local awful = require("awful")

local update_interval = 20
-- Returns the used amount of ram in percentage

local ram_script = [[free | sed -n '2p' | awk '{printf " %d %d %d\n", $7, $2, $3}']]
-- Periodically get ram info free | sed -n '2p'
awful.widget.watch(
  ram_script,
  update_interval,
  function(stdout)
    local available, total, used = string.match(stdout, "(%d+)")
    local total = stdout:match("@@(.*)@")
    local used = tonumber(total) - tonumber(available)
    awesome.emit_signal("signal::ram", tonumber(used), tonumber(total))
    collectgarbage("collect")
  end
)
