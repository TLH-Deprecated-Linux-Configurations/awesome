local naughty = require("naughty")

local function finish()
    local HOME = os.getenv("HOME")
    local FILE = HOME .. "/.cache/tutorial_tos"
    io.open(FILE, "w"):write(
        "This user has completed the tutorial and it needs not be run again unless this file is deleted in which case the tutorial will again run upon the"
    ):close()
end

local function ninthTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "Tutorial Completed",
            message = "That concludes the present tutorial. Remember Mod4+F1 will display all the configured keyboard shortcuts!",
            timeout = 0,
            position = "bottom_left"
        }
    ):connect_signal("destroyed", finish)
end

local function eightTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "Workspaces",
            message = "The letters of the word awesome on the panel, which is revealed by moving your mouse to the bottom of the screen, each represent a workspace. Switch to the workspace with MOD4 + 1-7.",
            timeout = 0,
            position = "bottom_left"
        }
    ):connect_signal("destroyed", ninthTip)
end

local function seventhTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "Window Switching Functionality",
            message = "Alt-Tab allows switching between windows, Alt + Escape brings up a menu of open windows and the taskbar items reveal windows on the screen specific to that workspace",
            timeout = 0,
            position = "bottom_left"
        }
    ):connect_signal("destroyed", eightTip)
end

local function sixthTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "Window Snapping",
            message = "When a window is floating press ALT + MOD4 + (Arrow Keys) to move the window to the correponding side of the screen or ALT + Control + MOD4 for the corners",
            timeout = 0,
            position = "bottom_left"
        }
    ):connect_signal("destroyed", seventhTip)
end

local function fifthTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "Floating",
            message = "You can also use clients in the manner your used to with floating mode, hit Mod4+f, which can be onscreen with tiled windows ",
            timeout = 0,
            position = "top_right"
        }
    ):connect_signal("destroyed", sixthTip)
end

local function fourthTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "Close Window",
            message = "To kill a program use Mod4+x",
            timeout = 0,
            position = "top_right"
        }
    ):connect_signal("destroyed", fifthTip)
end

local function thirdTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "App Menu",
            message = "For a Gnome like app menu, just hit Mod4 by itself and a list populated with desktops iwll overlay your screen",
            timeout = 0,
            position = "bottom_left"
        }
    ):connect_signal("destroyed", fourthTip)
end

local function secondTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "Layouts",
            message = "Awesome is a tiling window manager at its core that gives users choice as far as tiling patterns, to change the layout press SPACE + Mod4(WIN).",
            timeout = 0,
            position = "bottom_left"
        }
    ):connect_signal("destroyed", thirdTip)
end

local func = {
    secondTip = secondTip,
    thirdTip = thirdTip,
    fourthTip = fourthTip,
    fifthTip = fifthTip,
    sixthTip = sixthTip,
    seventhTip = seventhTip,
    eightTip = eightTip,
    ninthTip = ninthTip,
    finish = finish
}

local HOME = os.getenv("HOME")
local FILE = HOME .. "/.cache/tutorial_tos"
if require("utils.file").exists(FILE) then
    print("Tutorial has already been shown")
    func["status"] = false
    return func
end

print("Showing tutorial")
require("gears").timer.start_new(
    3,
    function()
        naughty.notify(
            {
                app_name = "New User Tutorial",
                title = "Controling the Window Manager",
                message = "The first and most important tip is that to access a list of the keys bidngings press Mod4 (Win) + F1.",
                timeout = 0,
                position = "bottom_left"
            }
        ):connect_signal("destroyed", secondTip)
    end
)

func["status"] = true
return func
