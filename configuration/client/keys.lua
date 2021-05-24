
require("awful.autofocus")
local config = require("configuration.keys.mod")
local modkey = config.modKey

local clientKeys =
  awful.util.table.join(
  awful.key(
    {modkey},
    config.fullscreen,
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = i18n.translate("toggle fullscreen"), group = i18n.translate("client")}
  ),
  awful.key(
    {modkey},
    config.ontop,
    function(c)
      c.ontop = not c.ontop
      c.sticky = c.ontop
      c:raise()
    end,
    {description = i18n.translate("toggle ontop mode"), group = i18n.translate("client")}
  ),
  awful.key(
    {modkey},
    "x",
    function(c)
      c:kill()
    end,
    {description = i18n.translate("close"), group = i18n.translate("client")}
  ),
  awful.key(
    {modkey},
    "x",
    function(c)
      c.floating = not c.floating
      c:raise()
    end,
    {description = i18n.translate("toggle floating"), group = i18n.translate("client")}
  )
)

return clientKeys
