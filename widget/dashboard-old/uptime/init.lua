--  _______         __   __
-- |   |   |.-----.|  |_|__|.--------.-----.
-- |   |   ||  _  ||   _|  ||        |  -__|
-- |_______||   __||____|__||__|__|__|_____|
--          |__|
-- ------------------------------------------------- --
-- Uptime command
local uptime_command = 'uptime -p'
-- ------------------------------------------------- --
local uptime =
    wibox.widget {
    font = beautiful.font .. ' 22',
    text = 'Loading your uptime data now...',
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
local uptime_update_interval = 3600
awful.widget.watch(
    uptime_command,
    uptime_update_interval,
    function(widget, stdout)
        -- Remove trailing whitespaces
        stdout = stdout:gsub('^%w%w(.-)%s*$', '%1')
        uptime.text = ' ' .. stdout
    end
)
-- ------------------------------------------------- --
local uptime_widget =
    wibox.widget {
    {
        {
            {
                {
                    forced_height = dpi(100),
                    forced_width = dpi(500),
                    widget = wibox.container.margin,
                    margins = dpi(12),
                    uptime
                },
                layout = wibox.layout.align.horizontal,
                expand = 'none'
            },
            margins = dpi(0),
            widget = wibox.container.margin
        },
        widget = wibox.container.background,
        bg = beautiful.bg_button
    },
    margins = dpi(0),
    widget = wibox.container.margin
}
-- ------------------------------------------------- --
return uptime_widget
