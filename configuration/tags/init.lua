local icons = require("theme.icons")
local config = require("parser")(os.getenv("HOME") .. "/.config/awesome/electric-tantra/tags.conf")
local menubar = require("menubar")
local bling = require("lib.bling")
local function icon(item)
  return menubar.utils.lookup_icon(item)
end

local function getItem(item)
  return config[item] or nil
end

local function getLayoutPerTag(number)
  local screen = "tag_" .. number
  local item = getItem(screen)
  if item ~= nil then
    if item == "0" or item == "mstab" then
      return bling.layout.mstab
    end
    if item == "1" or item == "floating" then
      return awful.layout.suit.floating
    end

    if item == "2" or item == "dwindle" then
      return awful.layout.suit.spiral.dwindle
    end

    if item == "3" or item == "fair" then
      return awful.layout.suit.fair
    end
    if item == "4" or item == "magnifier" then
      return awful.layout.suit.magnifier
    end
    if item == "5" or item == "max" then
      return awful.layout.suit.max
    end
    if item == "6" or item == "fairh" then
      return awful.layout.suit.fair.horizontal
    end
  else
    return bling.layout.mstab
  end
end

local function getGapPerTag(number)
  local gap = "tag_gap_" .. number
  return tonumber(getItem(gap)) or 4
end

local tags = {
  {
    icon = icon("webbrowser-app") or icons.chrome,
    type = "chrome",
    defaultApp = "chrome",
    screen = s,
    name = "A",
    layout = getLayoutPerTag(0)
  },
  {
    icon = icon("utilities-terminal") or icons.terminal,
    type = "terminal",
    defaultApp = "st",
    screen = s,
    layout = getLayoutPerTag(1)
  },
  {
    icon = icon("visual-studio-code-insiders") or icons.code,
    type = "code",
    defaultApp = "code-insiders",
    screen = s,
    layout = getLayoutPerTag(2)
  },
 {
    icon = icon("system-file-manager") or icons.folder,
    type = "files",
    
    screen = s,
    layout = getLayoutPerTag(3)
  },
  {
    icon = icon("deepin-music") or icons.music,
    type = "music",
    
    screen = s,
    layout = getLayoutPerTag(4)
  },
  {
    icon = icon("applications-games") or icons.game,
    type = "game",
    
    screen = s,
    layout = getLayoutPerTag(5)
  },
  {
    icon = icon("gimp") or icons.art,
    type = "art",
    
    screen = s,
    layout = getLayoutPerTag(6)
  },
  {
    icon = icon("utilities-system-monitor") or icons.lab,
    type = "any",
    defaultApp = "",
    screen = s,
    layout = getLayoutPerTag(7)
  },

  {
    icon = icon("utilities-system-monitor") or icons.lab,
    type = "any",
    defaultApp = "",
    screen = s,
    layout = getLayoutPerTag(8)
  }
}
tag.connect_signal(
  "request::default_layouts",
  function()
    awful.layout.append_default_layouts(
      {
        bling.layout.mstab,
        awful.layout.suit.tile,
        awful.layout.suit.spiral.dwindle,
        awful.layout.suit.floating,
        awful.layout.suit.fair,
        awful.layout.suit.magnifier,
        awful.layout.suit.max,
        awful.layout.suit.fair.horizontal
      }
    )
  end
)

awful.screen.connect_for_each_screen(
  function(s)
  -- Each screen has its own tag table.
	
	local tag_names = {"A", "W", "E", "S", "O", "M","E","W","M"}
	for idx, name in ipairs(tag_names) do
		local selected = false
		if idx == 1 then 
			selected = true
		end

		awful.tag.add(name, {
			screen = s,
			layout = bling.layout.mstab,
			selected = selected,
		})
	end
    --awful.tag({ "WEB", "DEV", "TERM", "MISC", "EMG" }, s, awful.layout.layouts[1])

    local tags = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
	}



end
  )

_G.tag.connect_signal(
  "property::layout",
  function(t)
    local currentLayout = awful.tag.getproperty(t, "layout")
    if (currentLayout == awful.layout.suit.max) then
      t.gap = 2
    else
      t.gap = awful.tag.getproperty(t, "gap") or 4
    end
    t.master_count = 2
  end
)
