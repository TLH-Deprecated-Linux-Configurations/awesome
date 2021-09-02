--  _______         __                        __
-- |    |  |.-----.|  |_.--.--.--.-----.----.|  |--.
-- |       ||  -__||   _|  |  |  |  _  |   _||    <
-- |__|____||_____||____|________|_____|__|  |__|__|

-- ########################################################################
-- ########################################################################
-- ########################################################################
local wibox = require('wibox')
local mat_slider = require('module.interface.progress_bar')
local icons = require('theme.icons')
local dpi = require('beautiful').xresources.apply_dpi
local filehandle = require('module.functions.file')
local gears = require('gears')
local common = require('lib.function.common')
local delayed_timer = require('lib.function.delayed-timer')
local beautiful = require('beautiful')

local functions = require('module.functions')
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
if filehandle.exists('/tmp/interface.txt') then
    interface = filehandle.string('/tmp/interface.txt'):gsub('\n', '')
end
local value_up =
    wibox.widget {
    markup = '...',
    font = beautiful.font .. ' 14',
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local value_down =
    wibox.widget {
    markup = '...',
    font = beautiful.font .. ' 14',
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
    print('Network download: ' .. download_text)
    print('Network upload: ' .. upload_text)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
delayed_timer(
    functions.network_poll,
    function()
        -- sanitizing the interface
        if interface == nil then
            interface = filehandle.string('/tmp/interface.txt'):gsub('\n', '')
            return
        end
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        counter = counter + 1

        local valueRX = filehandle.string('/sys/class/net/' .. interface .. '/statistics/rx_bytes'):gsub('\n', '')
        local valueTX = filehandle.string('/sys/class/net/' .. interface .. '/statistics/tx_bytes'):gsub('\n', '')
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        valueRX = tonumber(valueRX) or (last_rx + 1)
        valueTX = tonumber(valueTX) or (last_tx + 1)
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        local download = math.ceil((valueRX - last_rx) / functions.network_poll)
        local upload = math.ceil((valueTX - last_tx) / functions.network_poll)
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        if not (last_rx == 0) and not (last_tx == 0) then
            _draw_results(download, upload)
        end
        last_rx = valueRX
        last_tx = valueTX
    end,
    functions.netwok_startup_delay
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local widget_icon_up =
    wibox.widget {
    id = 'icon',
    image = icons.upload,
    forced_width = 36,
    forced_height = 36,
    widget = wibox.widget.imagebox
}

local function up(screen)
    network_slider_up =
        wibox.widget {
        read_only = true,
        widget = mat_slider,
        forced_height = 32,
        forced_width = 32
    }

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    network_meter_up =
        wibox.widget {
        {
            {
                widget_icon_up,
                value_up,
                spacing = dpi(0),
                layout = wibox.layout.flex.horizontal
            },
            top = dpi(2),
            bottom = dpi(2),
            left = dpi(0),
            right = dpi(0),
            widget = wibox.container.margin
        },
        shape = gears.shape.rounded_rect,
        bg = beautiful.bg_normal .. '77',
        shape_border_color = beautiful.bg_normal,
        shape_border_width = dpi(3),
        widget = wibox.container.background
    }
    return network_meter_up
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local widget_icon_down =
    wibox.widget {
    id = 'icon',
    image = icons.download,
    forced_width = 36,
    forced_height = 36,
    widget = wibox.widget.imagebox
}
local function down(screen)
    network_slider_down =
        wibox.widget {
        read_only = true,
        widget = mat_slider,
        forced_height = 32,
        forced_width = 32
    }

    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    network_meter_down =
        wibox.widget {
        {
            {
                widget_icon_down,
                value_down,
                spacing = dpi(0),
                layout = wibox.layout.flex.horizontal
            },
            top = dpi(2),
            bottom = dpi(2),
            left = dpi(0),
            right = dpi(0),
            widget = wibox.container.margin
        },
        shape = gears.shape.rounded_rect,
        bg = beautiful.bg_normal .. '77',
        shape_border_color = beautiful.bg_normal,
        shape_border_width = dpi(3),
        widget = wibox.container.background
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
