--  _______                __                                 _______               __ __
-- |   |   |.---.-.----.--|  |.--.--.--.---.-.----.-----.    |   |   |.-----.-----.|__|  |_.-----.----.
-- |       ||  _  |   _|  _  ||  |  |  |  _  |   _|  -__|    |       ||  _  |     ||  |   _|  _  |   _|
-- |___|___||___._|__| |_____||________|___._|__| |_____|    |__|_|__||_____|__|__||__|____|_____|__|

-- ########################################################################
-- ########################################################################
-- ########################################################################

local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local card = require('module.card')
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function build(screen)
    local hardware_card = card('Hardware monitor')

    local cpu = require('widget.cpu.cpu-meter')
    local ram = require('widget.ram.ram-meter')
    local temp = require('widget.temperature.temperature-meter')
    local drive = require('widget.harddrive.harddrive-meter')
    local network_up = require('widget.network.network-meter')(true, screen)
    local network_down = require('widget.network.network-meter')(false, screen)
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local body =
        wibox.widget {
        cpu,
        ram,
        temp,
        drive,
        network_up,
        network_down,
        layout = wibox.layout.fixed.vertical
    }
    hardware_card.update_body(body)
    return wibox.container.margin(hardware_card, dpi(20), dpi(20), dpi(20), dpi(20))
end

return build
