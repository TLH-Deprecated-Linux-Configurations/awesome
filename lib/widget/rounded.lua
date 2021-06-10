---------------------------------------------------------------------------
-- functions to help with rounding widgets.
--
-- This package contains simple function to round your widgets.
--
--     wibox.widget {
--        text = "hello",
--        shape = lib.widget.rounded(),
--        widget = wibox.widget.textbox,
--     }
--
--
--
-- @author Tom Meyers
-- @copyright 2020 Tom Meyers
-- @tdemod lib.widget.rounded
-- @supermodule gears.object
---------------------------------------------------------------------------

local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi

--- Round the corners of a wibox, as a cairo surface shape
-- @tparam[opt] number size the size in pixels (best to wrap around a dpi call)
-- @staticfct rounded
-- @usage -- rounds the corners by 10 (based on the user dpi)
-- lib.widgets.rounded(dpi(10))
return function(size)
  if size == nil then
    size = dpi(10)
  end
  return function(c, w, h)
    gears.shape.rounded_rect(c, w, h, size)
  end
end
