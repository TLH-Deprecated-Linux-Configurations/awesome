---------------------------------------------------------------------------
-- Extract album cover from song
--
-- This is a helper module to extract metadata from music.
-- It depends on the external package playerctl.
--
-- @author Tom Meyers
-- @copyright 2020 Tom Meyers
-- @tdemod lib.extractcover
---------------------------------------------------------------------------

-- Extract album cover from song
-- Will used by music/mpd widget
-- Depends ffmpeg or perl-image-exiftool, song with hard-coded album cover

local extract = {}
-- TODO: get image information from spotify

--- Creates a file in /tmp/cover.jpg asynchronously containing the cover image of the current song
-- @staticfct extractalbum
-- @usage -- This will return {1: "abc", 2: "def"}
-- lib.extract_cover.extractalbum() -> returns nothing
local extract_cover = function()
  -- see https://github.com/altdesktop/playerctl/issues/172 for more info
  local extract_script =
    [[
    url=$(playerctl -p spotify metadata mpris:artUrl | sed "s/open\.spotify\.com/i.scdn.co/")
    if [ "$url" ]; then
      curl -fL "$url" -o /tmp/cover.jpg
    fi
  ]]

  awful.spawn.easy_async_with_shell(
    extract_script,
    function(stderr)
      print("Music image: " .. stderr)
    end,
    false
  )
end

extract.extractalbum = extract_cover

return extract
