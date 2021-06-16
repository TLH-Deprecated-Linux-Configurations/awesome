local naughty = require('naughty')

local function finish()
    local HOME = os.getenv('HOME')
    local FILE = HOME .. '/.cache/tutorial_tos'
    io.open(FILE, 'w'):write('tutorial is complete'):close()
end

local function ninthTip()
    naughty.notify(
        {
            app_name = 'New User Tutorial',
            title = 'New User Tutorial',
            message = 'All Done! Enjoy Using the Electric Tantra Linux`',
            timeout = 0,
            position = 'top_left'
        }
    ):connect_signal('destroyed', finish)
end

local function eightTip()
    naughty.notify(
        {
            app_name = 'New User Tutorial',
            title = 'New User Tutorial',
            message = 'To see the keybindings, press mod+f1.',
            timeout = 0,
            position = 'top_left'
        }
    ):connect_signal('destroyed', ninthTip)
end

local function seventhTip()
    naughty.notify(
        {
            app_name = 'New User Tutorial',
            title = 'New User Tutorial',
            message = 'To go to a new workspace try mod+2, launch a program and switch back with mod+1',
            timeout = 0,
            position = 'top_left'
        }
    ):connect_signal('destroyed', eightTip)
end

local function sixthTip()
    naughty.notify(
        {
            app_name = 'New User Tutorial',
            title = 'New User Tutorial',
            message = 'Click on the gear icon to access general settings.',
            timeout = 0,
            position = 'top_left'
        }
    ):connect_signal('destroyed', seventhTip)
end

local function fifthTip()
    naughty.notify(
        {
            app_name = 'New User Tutorial',
            title = 'New User Tutorial',
            message = 'To launch applications use the windows key to bring up the application menu. Try to start a few! PS you can kill them with mod+x.',
            timeout = 0,
            position = 'top_right'
        }
    ):connect_signal('destroyed', sixthTip)
end

local function fourthTip()
    naughty.notify(
        {
            app_name = 'New User Tutorial',
            title = 'New User Tutorial',
            message = 'To kill a program use mod+q',
            timeout = 0,
            position = 'top_right'
        }
    ):connect_signal('destroyed', fifthTip)
end

local function thirdTip()
    naughty.notify(
        {
            app_name = 'New User Tutorial',
            title = 'New User Tutorial',
            message = 'Try to open a few terminals and see what happens. mod+Enter to open a terminal.',
            timeout = 0,
            position = 'bottom_left'
        }
    ):connect_signal('destroyed', fourthTip)
end

local function secondTip()
    naughty.notify(
        {
            app_name = 'New User Tutorial',
            title = 'New User Tutorial',
            message = 'The default window tiling layout can be changed by pressing the icon below to the left of the clock.',
            timeout = 0,
            position = 'bottom_left'
        }
    ):connect_signal('destroyed', thirdTip)
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

local HOME = os.getenv('HOME')
local FILE = HOME .. '/.cache/tutorial_tos'
if require('lib.file').exists(FILE) then
    print('Tutorial has already been shown')
    func['status'] = false
    return func
end

print('Showing tutorial')
require('gears').timer.start_new(
    3,
    function()
        naughty.notify(
            {
                app_name = 'New User Tutorial',
                title = 'New User Tutorial',
                message = "Each letter in the word 'Awesomewm' represents a workspace.",
                timeout = 0,
                position = 'top_left'
            }
        ):connect_signal('destroyed', secondTip)
    end
)

func['status'] = true
return func
