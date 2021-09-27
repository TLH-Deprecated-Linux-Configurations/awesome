local wibox = require('wibox')
local beautiful = require('beautiful')
local gears = require('gears')
local dpi = beautiful.xresources.apply_dpi
local header_font = beautiful.font .. ' 14'
local bg = beautiful.bg_modal
local bg_title = beautiful.bg_modal_title
local titled_card = function(title, height)
    local header =
        wibox.widget(
        {
            text = title,
            font = header_font,
            align = 'center',
            valign = 'center',
            widget = wibox.widget.textbox,
            border_color = beautiful.xcolor7 .. 'aa',
            bg = beautiful.xbackground .. 'dd',
            border_width = dpi(6),
            border_radius = dpi(12)
        }
    )
    local body_widget =
        wibox.widget(
        {
            wibox.widget.base.empty_widget(),
            shape = function(cr, rect_width, rect_height)
                gears.shape.partially_rounded_rect(cr, rect_width, rect_height, false, false, true, true, 6)
            end,
            widget = wibox.container.background,
            forced_height = height,
            bg = beautiful.xbackground .. 'cc'
        }
    )
    local widget =
        wibox.widget(
        {
            layout = wibox.layout.fixed.vertical,
            {
                bg = beautiful.xbackground .. 'cc',
                wibox.widget(
                    {
                        wibox.container.margin(header, dpi(10), dpi(10), dpi(10), dpi(10)),
                        bg = bg_title,
                        shape = function(cr, rect_width, rect_height)
                            gears.shape.partially_rounded_rect(cr, rect_width, rect_height, true, true, false, false, 6)
                        end,
                        widget = wibox.container.background
                    }
                ),
                layout = wibox.layout.fixed.vertical
            },
            body_widget,
            nil,
            bg = beautiful.xbackground .. 'cc',
            border_color = beautiful.xcolor0,
            border_width = dpi(12),
            border_radius = dpi(12)
        }
    )
    widget.update_title = function(updated_title)
        header.text = updated_title
    end
    widget.update_body = function(update_body)
        body_widget.widget = update_body
    end
    widget.update = function(updated_title, update_body)
        widget.update_title(updated_title)
        widget.update_body(update_body)
    end
    return widget
end
local bare_card = function()
    local body_widget =
        wibox.widget(
        {
            wibox.widget.base.empty_widget(),
            bg = beautiful.xbackground .. 'cc',
            border_color = beautiful.xcolor0,
            border_width = dpi(12),
            border_radius = dpi(12),
            shape = function(cr, rect_width, rect_height)
                gears.shape.partially_rounded_rect(cr, rect_width, rect_height, true, true, true, true, 6)
            end,
            widget = wibox.container.background
        }
    )
    body_widget.update_body = function(update_body)
        body_widget.widget = update_body
    end
    body_widget.update = function(_, update_body)
        body_widget.update_body(update_body)
    end
    return body_widget
end
return function(title, height)
    if title ~= nil then
        return titled_card(title, height)
    end
    return bare_card()
end
