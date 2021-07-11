local gears = require("gears")
local config = require("module.config")

return function()
  return function(c, w, h)
    gears.shape.rounded_rect(c, w, h, 12)
  end
end
