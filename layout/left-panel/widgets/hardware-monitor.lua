--  _______                __                                 _______               __ __
-- |   |   |.---.-.----.--|  |.--.--.--.---.-.----.-----.    |   |   |.-----.-----.|__|  |_.-----.----.
-- |       ||  _  |   _|  _  ||  |  |  |  _  |   _|  -__|    |       ||  _  |     ||  |   _|  _  |   _|
-- |___|___||___._|__| |_____||________|___._|__| |_____|    |__|_|__||_____|__|__||__|____|_____|__|

-- ########################################################################
-- ########################################################################
-- ########################################################################

local function build(screen)
    local hardware_card = card('Hardware monitor')

    local cpu = require('layout.left-panel.widgets.cpu-meter')
    local ram = require('layout.left-panel.widgets.ram-meter')
    local temp = require('layout.left-panel.widgets.temperature-meter')
    local drive = require('layout.left-panel.widgets.harddrive-meter')
    local network_up = require('layout.left-panel.widgets.network-meter')(true, screen)
    local network_down = require('layout.left-panel.widgets.network-meter')(false, screen)
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
