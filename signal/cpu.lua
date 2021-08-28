--  ______ ______ _______      _______ __                     __
-- |      |   __ \   |   |    |     __|__|.-----.-----.---.-.|  |
-- |   ---|    __/   |   |    |__     |  ||  _  |     |  _  ||  |
-- |______|___|  |_______|    |_______|__||___  |__|__|___._||__|
--                                        |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Provides:
-- signal::cpu
--      used percentage (integer)

local update_interval = 5
local cpu_idle_script = [[
  sh -c "
  vmstat 1 2 | tail -1 | awk '{printf \"%d\", $15}'
  "]]
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Periodically get cpu info
--
awful.widget.watch(
  cpu_idle_script,
  update_interval,
  ---@diagnostic disable-next-line: unused-local

  function(widget, stdout)
    -- local cpu_idle = stdout:match('+(.*)%.%d...(.*)%(')
    local cpu_idle = stdout
    cpu_idle = string.gsub(cpu_idle, "^%s*(.-)%s*$", "%1")
    awesome.emit_signal("signal::cpu", 100 - tonumber(cpu_idle))
  end
)
