--  ______         __                 __                  ________ __     __               __
-- |      |.---.-.|  |.-----.-----.--|  |.---.-.----.    |  |  |  |__|.--|  |.-----.-----.|  |_
-- |   ---||  _  ||  ||  -__|     |  _  ||  _  |   _|    |  |  |  |  ||  _  ||  _  |  -__||   _|
-- |______||___._||__||_____|__|__|_____||___._|__|      |________|__||_____||___  |_____||____|
--                                                                           |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local clickable_container = require("widget.interface.clickable-container")
local dpi = require("beautiful").xresources.apply_dpi

awesome.register_xproperty("WM_CLASS", "string")

local styles = {}
local function rounded_shape(size, partial)
    if partial then
        return function(cr, width, height)
            gears.shape.rectangle(cr, width + 5, height, 11)
        end
    else
        return function(cr, width, height)
            gears.shape.rectangle(cr, width, height, size)
        end
    end
end
styles.month = {padding = dpi(5), bg_color = "radial:960,540,20:960,540,500:0,#22262daa:0.2,#3c3f4c88:0.65,#17191e88:1,#272a3488", shape = beautiful.btn_lg_shape}
styles.normal = {shape = beautiful.btn_lg_shape, padding = dpi(5)}
styles.focus = {
    fg_color = beautiful.xcolor15, -- Current day Color
    markup = function(t)
        return "<b>" .. t .. "</b>"
    end,
    shape = beautiful.btn_lg_shape
}
styles.header = {
    fg_color = beautiful.xcolor7, -- Month Name Color
    markup = function(t)
        return "<b>" .. t .. "</b>"
    end,
    shape = rounded_shape(10)
}
styles.weekday = {
    fg_color = beautiful.xcolor7, -- Day Color
    markup = function(t)
        return "<b>" .. t .. "</b>"
    end,
    shape = rounded_shape(5)
}

local function decorate_cell(widget, flag, date)
    if flag == "monthheader" and not styles.monthheader then
        flag = "header"
    end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    local d = {
        year = date.year,
        month = (date.month or 1),
        day = (date.day or 1)
    }
    local weekday = tonumber(os.date("%w", os.time(d)))
    local ret =
        wibox.widget {
        {
            widget,
            margins = (props.padding or 2) + (props.border_width or 2),
            widget = wibox.container.margin
        },
        fg = props.fg_color or beautiful.xcolor7,
        widget = wibox.container.background
    }
    return ret
end

local cal =
    wibox.widget {
    date = os.date("*t"),
    font = beautiful.font .. " 20",
    fn_embed = decorate_cell,
    -- start_sunday = true,
    align = "center",
    valign="center",
    widget = wibox.widget.calendar.month,
    bg_color = "radial:960,540,10:0,0,10:0,##17191ecc:0.34,#2f303d88:0.65,#17191e88:1,#22262d88"
}

local calWidget =
    wibox.widget {
    {cal, 
    border_color = beautiful.xcolor7 .. "66", 
    widget = wibox.container.margin,
        margins= dpi(6),
        layout = wibox.layout.align.horizontal,
    },
    expand = "none",
    bg = "radial:960,540,20:960,540,500:0,#22262daa:0.2,#3c3f4c88:0.65,#17191e88:1,#272a3488",
    widget = card,
    border_color = beautiful.xcolor7 .. '66',
    border_width = dpi(3)
}

local popup =
    awful.popup {
    ontop = true,
    visible = false,
    position = "bottom",
    shape = gears.shape.rounded_rect,
    offset = {y = -35},
    border_width = 1,
    border_color = beautiful.xcolor0 .. "33",
    bg = beautiful.xcolor0 .. "00",
    widget = calWidget
}
popup:set_xproperty("WM_CLASS", "calendar")

popup:buttons(
    awful.util.table.join(
        awful.button(
            {},
            4,
            function()
                local a = cal:get_date()
                a.month = a.month + 1
                cal:set_date(nil)
                cal:set_date(a)
                popup:set_widget(calWidget)
            end
        ),
        awful.button(
            {},
            5,
            function()
                local a = cal:get_date()
                a.month = a.month - 1
                cal:set_date(nil)
                cal:set_date(a)
                popup:set_widget(calWidget)
            end
        )
    )
)

function cal_toggle()
    if popup.visible then
        -- to faster render the calendar refresh it and just hide
        cal:set_date(nil) -- the new date is not set without removing the old one
        cal:set_date(os.date("*t"))
        popup:set_widget(nil) -- just in case
        popup:set_widget(calWidget)
        popup.visible = not popup.visible
    else
        awful.placement.bottom_right(popup, {margins = {bottom = 45, right = 15}, parent = awful.screen.focused()})

        popup.visible = true
    end
end

return calWidget
