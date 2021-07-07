--  _______         __   __   __
-- |     __|.-----.|  |_|  |_|__|.-----.-----.-----.
-- |__     ||  -__||   _|   _|  ||     |  _  |__ --|
-- |_______||_____||____|____|__||__|__|___  |_____|
--                                     |_____|
--  _______ __                 __
-- |   _   |  |--.-----.--.--.|  |_
-- |       |  _  |  _  |  |  ||   _|
-- |___|___|_____|_____|_____||____|

-- ########################################################################
-- Initialization #########################################################
-- ########################################################################
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local execute = require("module.hardware.hardware-check").execute
local bytes_to_grandness = require("lib.function.common").bytes_to_grandness
local signals = require("module.settings.signals")
local hardware = require("module.hardware.hardware-check")
local seperator_widget = require("module.ui-components.separator")
local card = require("module.ui-components.card")

local dpi = beautiful.xresources.apply_dpi
local icons = require("theme.icons")

-- ########################################################################
-- Settings ###############################################################
-- ########################################################################
local m = dpi(10)
local settings_index = dpi(40)
local settings_width = dpi(1100)
local settings_nw = dpi(260)

-- ########################################################################
-- Widget #################################################################
-- ########################################################################
-- returns the total widget and text widget holding the normal name
local function generate_setting_panel(title)
    local typeWidget =
        wibox.widget {
        widget = wibox.widget.textbox,
        text = title,
        font = beautiful.title_font
    }
    local name =
        wibox.widget {
        widget = wibox.widget.textbox,
        text = "Unknown",
        font = beautiful.font,
        fg = beautiful.fg_normal .. "AA"
    }
    local container = card()
    container.forced_width = settings_width - (settings_nw * 2)
    container.forced_height = settings_index

    container.update_body(
        wibox.widget {
            layout = wibox.layout.align.horizontal,
            {layout = wibox.container.margin, left = m, typeWidget},
            {layout = wibox.container.margin, left = m, wibox.widget.base.empty_widget()},
            {layout = wibox.container.margin, right = m, name}
        }
    )
    return wibox.container.margin(container, dpi(10), dpi(10), dpi(10), dpi(10)), name
end

return function()
    local view = wibox.container.margin()
    view.left = m
    view.right = m

    local title = wibox.widget.textbox("About")
    title.font = beautiful.title_font
    title.forced_height = settings_index + m + m

    local close = wibox.widget.imagebox(icons.close)
    close.forced_height = settings_index
    close:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                function()
                    if root.elements.settings then
                        root.elements.settings.close()
                    end
                end
            )
        )
    )

    local logo = wibox.widget.imagebox(icons.logo)

    local separator = seperator_widget(settings_index / 1.5)

    local container = wibox.layout.fixed.vertical()
    local device_name, device_text = generate_setting_panel("Name")

    signals.connect_username(
        function(value)
            device_text.text = value
        end
    )

    local memory_name, memory_text = generate_setting_panel("Memory")

    signals.connect_ram_total(
        function(value)
            memory_text.text = bytes_to_grandness(value, 1)
        end
    )

    local _, threads, _processor_name = hardware.getCpuInfo()
    local processor_name, processor_text = generate_setting_panel("Processor")
    processor_text.text = _processor_name

    local processor_cores, processor_cores_text = generate_setting_panel("Processor Core Count")
    processor_cores_text.text = tostring(threads)

    local graphics_name, graphics_text = generate_setting_panel("Graphics")
    -- gathered from https://github.com/dylanaraps/neofetch/blob/master/neofetch#L2401
    local value, _ =
        execute(
        'lspci -mm | awk -F \'\\"|\\" \\"|\\\\(\' \'/"Display|"3D|"VGA/ {a[$0] = $1 " " $3 " " $4} END {for(i in a) {if(!seen[a[i]]++) print a[i]}}\' | head -n1'
    )
    graphics_text.text = value

    local disk_name, disk_text = generate_setting_panel("Disk capacity")

    signals.connect_disk_space(
        function(payload)
            print("Updating disk space")
            disk_text.text = payload
        end
    )

    local display_freq_name, display_freq_text = generate_setting_panel("Display refresh rate")

    display_freq_text.text = tostring(hardware.getDisplayFrequency()) .. " Hz"

    local os_name_name, os_name_text = generate_setting_panel("OS Name")
    os_name_text.text = "the Electric Tantra Linux"

    signals.connect_distro(
        function(payload)
            os_name_text.text = payload
        end
    )

    local os_type_name, os_type_text = generate_setting_panel("OS Type")
    local out, _ = execute("uname -m")
    os_type_text.text = out

    local windowing_system_name, windowing_system_text = generate_setting_panel("Windowing system")
    -- TDE currently only supports X11
    windowing_system_text.text = "X11"

    require("widget.settings.info-gather")

    container:add(device_name)

    container:add(separator)

    container:add(memory_name)
    container:add(processor_name)
    container:add(processor_cores)
    container:add(graphics_name)
    container:add(disk_name)
    container:add(display_freq_name)

    container:add(separator)

    container:add(os_name_name)
    container:add(os_type_name)
    container:add(windowing_system_name)

    view:setup {
        layout = wibox.container.background,
        {
            layout = wibox.layout.align.vertical,
            {
                layout = wibox.layout.align.horizontal,
                nil,
                wibox.container.margin(
                    {
                        layout = wibox.container.place,
                        title
                    },
                    settings_index * 2
                ),
                close
            },
            {
                layout = wibox.container.place,
                valign = "top",
                halign = "center",
                logo
            },
            {
                layout = wibox.container.place,
                valign = "top",
                halign = "center",
                wibox.container.margin(container, 0, 0, 0, m * 3)
            }
        }
    }

    return view
end
