
local wibox = require("wibox")

local dpi = require("beautiful").xresources.apply_dpi

-- Music Title
local musicTitle =
  wibox.widget {
  {
    id = "title",
    font = "SFNS Display Bold 12",
    align = "center",
    valign = "bottom",
    ellipsize = "end",
    widget = wibox.widget.textbox
  },
  layout = wibox.layout.flex.horizontal
}
local function getTitle()
  awful.spawn.easy_async_with_shell(
    "playerctl metadata xesam:title",
    function(stdout)
      if (stdout:match("%W")) then
        musicTitle.title:set_text(stdout)
        print("Music title: " .. stdout)
      else
        musicTitle.title:set_text(i18n.translate("No active music player found."))
        print("No music found")
      end
    end
  )
end
_G.getTitle = getTitle

-- Music Artist
local musicArtist =
  wibox.widget {
  {
    id = "artist",
    font = "SFNS Display 9",
    align = "center",
    valign = "top",
    widget = wibox.widget.textbox
  },
  layout = wibox.layout.flex.horizontal
}
local function getArtist()
  awful.spawn.easy_async_with_shell(
    "playerctl metadata xesam:artist",
    function(stdout)
      if (stdout:match("%W")) then
        musicArtist.artist:set_text(stdout)
        print("Music artist: " .. stdout)
      else
        musicArtist.artist:set_text(i18n.translate("Try and play some music :)"))
      end
    end
  )
end

_G.getArtist = getArtist

local musicInfo =
  wibox.widget {
  wibox.container.margin(musicTitle, dpi(15), dpi(15)),
  wibox.container.margin(musicArtist, dpi(15), dpi(15)),
  layout = wibox.layout.flex.vertical
}

return musicInfo
