
local naughty = require("naughty")

local function finish()
    local HOME = os.getenv("HOME")
    local FILE = HOME .. "/.cache/tutorial_tos"
    io.open(FILE, "w"):write("tutorial is complete"):close()
end

local function ninthTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = i18n.translate(
                "All Done! Enjoy Using the Electric Tantra Linux`"
            ),
            timeout = 0,
            position = "top_left"
        }
    ):connect_signal("destroyed", finish)
end

local function eightTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = i18n.translate("To see the keybindings, press mod+f1."),
            timeout = 0,
            position = "top_left"
        }
    ):connect_signal("destroyed", ninthTip)
end

local function seventhTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = i18n.translate("To go to a new workspace try mod+2, launch a program and switch back with mod+1"),
            timeout = 0,
            position = "top_left"
        }
    ):connect_signal("destroyed", eightTip)
end

local function sixthTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = i18n.translate("Click on the gear logo to access general settings."),
            timeout = 0,
            position = "top_left"
        }
    ):connect_signal("destroyed", seventhTip)
end

local function fifthTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = i18n.translate("To launch applications use mod. Try to start a few! PS you can kill them with mod+x."),
            timeout = 0,
            position = "top_right"
        }
    ):connect_signal("destroyed", sixthTip)
end

local function fourthTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = i18n.translate("To kill a program use mod+q"),
            timeout = 0,
            position = "top_right"
        }
    ):connect_signal("destroyed", fifthTip)
end

local function thirdTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = i18n.translate(
                "Try to open a few terminals and see what happens. mod+Enter to open a terminal."
            ),
            timeout = 0,
            position = "bottom_left"
        }
    ):connect_signal("destroyed", fourthTip)
end

local function secondTip()
    naughty.notify(
        {
            app_name = "New User Tutorial",
            title = "New User Tutorial",
            message = i18n.translate("The default window tiling layout can be changed by pressing the icon below to the left of the clock."),
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
if require("lib-tde.file").exists(FILE) then
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
                title = "New User Tutorial",
                message = i18n.translate("Each letter in the word 'Awesomewm' represents a workspace."),
                timeout = 0,
                position = "top_left"
            }
        ):connect_signal("destroyed", secondTip)
    end
)

func["status"] = true
return func
