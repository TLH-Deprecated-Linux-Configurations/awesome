--  _______
-- |_     _|.-----.--------.-----.
--   |   |  |  -__|        |  _  |
--   |___|  |_____|__|__|__|   __|
--                         |__|
-- ------------------------------------------------- --
-- provides the CPU temperature, requires local adaptation
local update_interval = 15
local temp_script = [[
  sh -c "
  sensors | grep edge | awk '{print $2}' | cut -c 2-3
  "]]

-- Periodically get temperature info
awful.widget.watch(
  temp_script,
  update_interval,
  function(widget, stdout)
    awesome.emit_signal('signal::temp', tonumber(stdout))
  end
)
