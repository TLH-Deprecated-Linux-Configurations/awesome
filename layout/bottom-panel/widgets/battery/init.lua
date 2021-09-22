--  ______         __   __
-- |   __ \.---.-.|  |_|  |_.-----.----.--.--.
-- |   __ <|  _  ||   _|   _|  -__|   _|  |  |
-- |______/|___._||____|____|_____|__| |___  |
--                                     |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Declarations not made global
--
local config = require 'module.functions'
local widget_icon_dir = HOME .. '/.config/awesome/layout/bottom-panel/widgets/battery/icons/'
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Return the button itself
--
local return_button = function()
    local battery_imagebox =
        wibox.widget {
        nil,
        {
            id = 'icon',
            image = widget_icon_dir .. 'battery-standard' .. '.png',
            widget = wibox.widget.imagebox,
            resize = true
        },
        nil,
        expand = 'none',
        layout = wibox.layout.align.vertical
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Battery Percentage Text
    local battery_percentage_text =
        wibox.widget {
        id = 'percent_text',
        text = '100%',
        font = beautiful.font .. ' 14',
        align = 'center',
        valign = 'center',
        visible = false,
        widget = wibox.widget.textbox
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Widget Definition
    --
    local battery_widget =
        wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(0),
        battery_imagebox,
        battery_percentage_text,
        bg=beautiful.xcolor8
        }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Button Definition and Margins
    --
    local battery_button = clickable_container(wibox.container.margin(battery_widget, dpi(10), dpi(10), dpi(10), dpi(10)))
    local battery_tooltip =
        awful.tooltip {
        objects = {battery_button},
        text = 'None',
        mode = 'outside',
        align = 'right',
        margin_leftright = dpi(12),
        margin_topbottom = dpi(12),
        margins = dpi(16),
        font = beautiful.font .. ' 10',
        preferred_positions = {'right', 'left', 'top', 'bottom'}
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Get battery info script
    --
    local get_battery_info = function()
        awful.spawn.easy_async_with_shell(
            'upower -i $(upower -e | grep BAT)',
            function(stdout)
                if not stdout:match '%W' then
                    battery_tooltip:set_text 'No battery detected!'
                    return
                end
                -- Remove new line from the last line
                battery_tooltip:set_text(stdout:sub(1, -2))
            end
        )
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Update tooltip on startup
    --
    get_battery_info()
    -- Update tooltip on hover
    --
    battery_widget:connect_signal(
        'mouse::enter',
        function()
            get_battery_info()
        end
    )
    local last_battery_check = os.time()
    local notify_critcal_battery = true
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local function show_battery_warning()
        naughty.notification {
            icon = widget_icon_dir .. 'battery-alert.png',
            app_name = 'System notification',
            title = 'System notification',
            message = 'I pity the fool who does not plugin in their laptop because it is about to die sucka.',
            urgency = 'critical'
        }
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Update Battery (else why even have this widget?)
    --
    local update_battery = function(status)
        status = status:gsub('%\n', '%\n')
        local percentage = file.string '/sys/class/power_supply/BAT0/capacity'
        -- some hardware counts from BAT1
        if percentage == '' or percentage == nil then
            percentage = file.string '/sys/class/power_supply/BAT1/capacity'
        end

        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- Percentage Regularization (the joys of programming)
        --
        local battery_percentage = tonumber(percentage) or 0
        print('Battery percentage: ' .. percentage)
        battery_widget.spacing = dpi(5)
        battery_percentage_text.visible = true
        battery_percentage_text:set_text(battery_percentage .. '%')
        local icon_name = 'battery'
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        -- If Discharging, sets icons
        --
        if status:match 'Discharging' then
            if battery_percentage >= 0 and battery_percentage < 10 then
                icon_name = icon_name .. '-' .. 'alert-red'
                if os.difftime(os.time(), last_battery_check) > 300 or notify_critcal_battery then
                    last_battery_check = os.time()
                    notify_critcal_battery = false
                    show_battery_warning()
                end
            elseif battery_percentage > 10 and battery_percentage < 20 then
                icon_name = icon_name .. '-' .. '10'
            elseif battery_percentage >= 20 and battery_percentage < 30 then
                icon_name = icon_name .. '-' .. '20'
            elseif battery_percentage >= 30 and battery_percentage < 50 then
                icon_name = icon_name .. '-' .. '30'
            elseif battery_percentage >= 50 and battery_percentage < 60 then
                icon_name = icon_name .. '-' .. '50'
            elseif battery_percentage >= 60 and battery_percentage < 80 then
                icon_name = icon_name .. '-' .. '60'
            elseif battery_percentage >= 80 and battery_percentage < 90 then
                icon_name = icon_name .. '-' .. '80'
            elseif battery_percentage >= 90 and battery_percentage < 100 then
                icon_name = icon_name .. '-' .. '90'
            elseif battery_percentage == 100 then
                icon_name = icon_name .. '-fully-charged'
            end
        elseif status:match 'charging' or status:match 'fully' then
            if battery_percentage > 0 and battery_percentage < 20 then
                icon_name = icon_name .. '-' .. status .. '-' .. '10'
            elseif battery_percentage >= 20 and battery_percentage < 30 then
                icon_name = icon_name .. '-' .. status .. '-' .. '20'
            elseif battery_percentage >= 30 and battery_percentage < 50 then
                icon_name = icon_name .. '-' .. status .. '-' .. '30'
            elseif battery_percentage >= 50 and battery_percentage < 60 then
                icon_name = icon_name .. '-' .. status .. '-' .. '50'
            elseif battery_percentage >= 60 and battery_percentage < 80 then
                icon_name = icon_name .. '-' .. status .. '-' .. '60'
            elseif battery_percentage >= 80 and battery_percentage < 90 then
                icon_name = icon_name .. '-' .. status .. '-' .. '80'
            elseif battery_percentage >= 90 and battery_percentage < 100 then
                icon_name = icon_name .. '-' .. status .. '-' .. '90'
            elseif battery_percentage == 100 then
                icon_name = icon_name .. '-fully-charged'
            end
        end
        battery_imagebox.icon:set_image(gears.surface.load(widget_icon_dir .. icon_name .. '.png'))
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    -- Timer Defintiion
    --
    gears.timer {
        timeout = config.battery_timeout,
        call_now = true,
        autostart = true,
        callback = function()
            local status = file.string '/sys/class/power_supply/BAT0/status'
            if status == '' then
                -- possibility that the manufacturer starts counting from 1
                status = file.string '/sys/class/power_supply/BAT1/status'
            end
            -- ########################################################################
            -- ########################################################################
            -- ########################################################################
            -- If no output or battery detected
            --
            if status == '' then
                battery_widget.spacing = dpi(0)
                battery_percentage_text.visible = false
                battery_tooltip:set_text('No battery detected!')
                battery_imagebox.icon:set_image(gears.surface.load(widget_icon_dir .. 'battery-unknown' .. '.png'))
                return
            end
            update_battery(status)
        end
    }
    return battery_button
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return return_button
