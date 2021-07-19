--  ______                                    __ __
-- |      |.-----.--------.-----.-----.-----.|__|  |_.-----.----.
-- |   ---||  _  |        |  _  |  _  |__ --||  |   _|  _  |   _|
-- |______||_____|__|__|__|   __|_____|_____||__|____|_____|__|
--                        |__|
--  ______         __   __
-- |   __ \.--.--.|  |_|  |_.-----.-----.
-- |   __ <|  |  ||   _|   _|  _  |     |
-- |______/|_____||____|____|_____|__|__|

-- ########################################################################
-- ########################################################################
-- ########################################################################
local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local mat_list_item = require("widget.material.list-item")
local checkbox = require("module.interface.checkbox")

local config = require("module.functions")

local cmd = 'grep -F "blur-background-frame = false;" ' .. config.getComptonFile() .. "| tr -d '[\\-\\;\\=\\ ]' "
local frameStatus

-- ########################################################################
-- ########################################################################
-- ########################################################################

local frameChecker

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Commands toggling the button
local blurDisable = {
    'sed -i -e "s/blur-background-frame = true/blur-background-frame = false/g" ' .. config.getComptonFile(),
    "sleep 1; picom --dbus --experimental-backends --config " .. config.getComptonFile(),
    'notify-send "Blur effect disabled"'
}
local blurEnable = {
    'sed -i -e "s/blur-background-frame = false/blur-background-frame = true/g" ' .. config.getComptonFile(),
    "sleep 1; picom --dbus --experimental-backends --config " .. config.getComptonFile(),
    'notify-send "Blur effect enabled"'
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function run_once(blurCmd)
    local findme = blurCmd
    local firstspace = blurCmd:find(" ")
    if firstspace then
        findme = blurCmd:sub(0, firstspace - 1)
    end
    awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, blurCmd))
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function update_compositor()
    if (frameStatus == true) then
        awful.spawn.with_shell("kill -9 $(pidof picom)")
        for _, app in ipairs(blurDisable) do
            run_once(app)
        end
    else
        awful.spawn.with_shell("kill -9 $(pidof picom)")
        for _, app in ipairs(blurEnable) do
            run_once(app)
        end
    end
end

-- ########################################################################
-- ########################################################################
-- ########################################################################
local compton_button =
    checkbox(
    frameStatus,
    function(checked)
        frameStatus = checked
        update_compositor()
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function checkFrame()
    awful.spawn.easy_async_with_shell(
        cmd,
        function(stdout)
            frameChecker = stdout:match("blurbackgroundframefalse")
            frameStatus = frameChecker == nil
            compton_button.update(frameStatus)
        end
    )
end

checkFrame()
-- ########################################################################
-- ########################################################################
-- ########################################################################
local settingsName =
    wibox.widget {
    text = ("Window Effects"),
    font = "agave Nerd Font Mono Bold  10",
    align = "left",
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local content =
    wibox.widget {
    settingsName,
    wibox.container.margin(compton_button, 0, 0, dpi(5), dpi(5)),
    bg = "#f4f4f720",
    shape = gears.shape.rounded_rect,
    widget = wibox.container.background(settingsName),
    layout = wibox.layout.ratio.horizontal
}
content:set_ratio(1, .85)

local comptonButton =
    wibox.widget {
    wibox.widget {
        content,
        widget = mat_list_item
    },
    layout = wibox.layout.fixed.vertical
}

return comptonButton
