--  _______         __                        __
-- |    |  |.-----.|  |_.--.--.--.-----.----.|  |--.
-- |       ||  -__||   _|  |  |  |  _  |   _||    <
-- |__|____||_____||____|________|_____|__|  |__|__|

-- ########################################################################
-- ########################################################################
-- ########################################################################
local wibox = require("wibox")
local mat_list_item = require("widget.material.list-item")
local mat_slider = require("module.ui-components.progress_bar")
local mat_icon = require("widget.material.icon")
local icons = require("theme.icons")
local dpi = require("beautiful").xresources.apply_dpi
local filehandle = require("module.file")
local gears = require("gears")
local common = require("lib.function.common")
local delayed_timer = require("lib.function.delayed-timer")

local config = require("module.functions")
-- ########################################################################
-- ########################################################################
-- ########################################################################
local biggest_upload = 1
local biggest_download = 1

local last_rx = 0
local last_tx = 0
-- only run the networking poll every x seconds
local counter = 0
local interface
local network_slider_up
local network_slider_down
local network_meter_up
local network_meter_down
-- ########################################################################
-- ########################################################################
-- ########################################################################
if filehandle.exists("/tmp/interface.txt") then
    interface = filehandle.string("/tmp/interface.txt"):gsub("\n", "")
end
local value_up =
    wibox.widget {
    markup = "...",
    align = "center",
    valign = "center",
    font = "agave Nerd Font Mono Bold 14",
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local value_down =
    wibox.widget {
    markup = "...",
    align = "center",
    valign = "center",
    font = "agave Nerd Font Mono Bold 14",
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function _draw_results(download, upload)
    if download > biggest_download then
        biggest_download = download
    end

    if upload > biggest_upload then
        biggest_upload = upload
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local download_text = common.bytes_to_grandness(download)
    local upload_text = common.bytes_to_grandness(upload)
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    value_up:set_markup_silently(gears.string.xml_escape(upload_text))
    value_down:set_markup_silently(gears.string.xml_escape(download_text))
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    if network_slider_up then
        network_slider_up:set_value((upload / biggest_upload) * 100)
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    if network_slider_down then
        network_slider_down:set_value((download / biggest_download) * 100)
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    print("Network download: " .. download_text)
    print("Network upload: " .. upload_text)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
delayed_timer(
    config.network_poll,
    function()
        -- sanitizing the interface
        if interface == nil then
            interface = filehandle.string("/tmp/interface.txt"):gsub("\n", "")
            return
        end
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        counter = counter + 1

        local valueRX = filehandle.string("/sys/class/net/" .. interface .. "/statistics/rx_bytes"):gsub("\n", "")
        local valueTX = filehandle.string("/sys/class/net/" .. interface .. "/statistics/tx_bytes"):gsub("\n", "")
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        valueRX = tonumber(valueRX) or (last_rx + 1)
        valueTX = tonumber(valueTX) or (last_tx + 1)
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        local download = math.ceil((valueRX - last_rx) / config.network_poll)
        local upload = math.ceil((valueTX - last_tx) / config.network_poll)
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        if not (last_rx == 0) and not (last_tx == 0) then
            _draw_results(download, upload)
        end
        last_rx = valueRX
        last_tx = valueTX
    end,
    config.netwok_startup_delay
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function up(screen)
    network_slider_up =
        wibox.widget {
        read_only = true,
        forced_width = screen.geometry.width * 0.13,
        widget = mat_slider
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    network_meter_up =
        wibox.widget {
        wibox.widget {
            icon = icons.upload,
            size = dpi(24),
            widget = mat_icon
        },
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        wibox.widget {
            network_slider_up,
            wibox.container.margin(value_up, dpi(1), dpi(0), dpi(10), dpi(10)),
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal
        },
        widget = mat_list_item
    }
    return network_meter_up
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function down(screen)
    network_slider_down =
        wibox.widget {
        read_only = true,
        forced_width = screen.geometry.width * 0.13,
        widget = mat_slider
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    network_meter_down =
        wibox.widget {
        wibox.widget {
            icon = icons.download,
            size = dpi(24),
            widget = mat_icon
        },
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        wibox.widget {
            network_slider_down,
            wibox.container.margin(value_down, dpi(1), dpi(0), dpi(10), dpi(10)),
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal
        },
        widget = mat_list_item
    }
    return network_meter_down
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return function(bIsUpload, screen)
    if bIsUpload then
        return up(screen)
    end
    return down(screen)
end
