--  _______         __               __         __
-- |_     _|.--.--.|  |_.-----.----.|__|.---.-.|  |
--   |   |  |  |  ||   _|  _  |   _||  ||  _  ||  |
--   |___|  |_____||____|_____|__|  |__||___._||__|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- This is for the popup windows intended to help new users get started.
-- something most tiling window managers probably should inlcude, especially
-- this archiac nightmare but do not. So this file addresses that need and informs
-- users how to find the keybindings help.
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Final Dialogue Window
--
local function finish()
    local HOME = os.getenv("HOME")
    local file = HOME .. "/.cache/tutorial"
    io.open(file, "w"):write("tutorial is complete"):close()
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- tip 9
local function ninthTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = "All Done! Enjoy Using the Electric Tantra Linux`",
            timeout = 0,
            position = "top_left"
        }
    ):connect_signal("destroyed", finish)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function eightTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = "To see the keybindings, press mod+f1.",
            timeout = 0,
            position = "top_left"
        }
    ):connect_signal("destroyed", ninthTip)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- tip 7
--
local function seventhTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = "To go to a new workspace try mod+2, launch a program and switch back with mod+1. Workspace " ..
                "represented by the letters of the word AWESOMEWM on the bottom bar.",
            timeout = 0,
            position = "top_left"
        }
    ):connect_signal("destroyed", eightTip)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- tip 6
--
local function sixthTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = "Click on the gear icon to access quick settings and dash.",
            timeout = 0,
            position = "top_left"
        }
    ):connect_signal("destroyed", seventhTip)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- tip 5
--
local function fifthTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = "Got notifications that disappeared before you could react? Click the menu icon to the left of the" ..
                " clock widget on the bottom bar",
            timeout = 0,
            position = "top_right"
        }
    ):connect_signal("destroyed", sixthTip)
end
-- ########################################################################
-- ## Fourth Tip ##########################################################
-- ########################################################################
local function fourthTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = "To kill a program use mod+x",
            timeout = 0,
            position = "top_right"
        }
    ):connect_signal("destroyed", fifthTip)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- tip 3
local function thirdTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = "Try to open a few terminals and see what happens. mod+Enter to open a terminal or press the" ..
                " windows key and a system app menu will appear.",
            timeout = 0,
            position = "bottom_left"
        }
    ):connect_signal("destroyed", fourthTip)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- tip 2
local function secondTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = "To show the bar, hover your mouse over the last row of pixels at the bottom of the screen.",
            timeout = 0,
            position = "bottom_left"
        }
    ):connect_signal("destroyed", thirdTip)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- assign tips (providing order, calls above functions)
--
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
-- ########################################################################
-- ## Check to see if tutorial already ran or not #########################
-- ########################################################################
local HOME = os.getenv("HOME")
local file = HOME .. "/.cache/tutorial"
if require("widget.functions.file").exists(file) then
    print("Tutorial has already been shown")
    func["status"] = false
    return func
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
print("Showing tutorial")
require("gears").timer.start_new(
    3,
    function()
        naughty.notify(
            {
                app_name = "User Tutorial",
                title = "User Tutorial",
                message = " These tips are intended to help you get started using this configuration either on the LiveISO of the Electric Tantra Linux or in case you are evaluating the configuration on your own installation. \n \n \n Click this box to proceed to the first starter tip! \n ",
                timeout = 0,
                position = "top_left"
            }
        ):connect_signal("destroyed", secondTip)
    end
)

func["status"] = true
return func
