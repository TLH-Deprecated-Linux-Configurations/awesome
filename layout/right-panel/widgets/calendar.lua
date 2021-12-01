--  ______         __                 __                  ________ __     __               __
-- |      |.---.-.|  |.-----.-----.--|  |.---.-.----.    |  |  |  |__|.--|  |.-----.-----.|  |_
-- |   ---||  _  ||  ||  -__|     |  _  ||  _  |   _|    |  |  |  |  ||  _  ||  _  |  -__||   _|
-- |______||___._||__||_____|__|__|_____||___._|__|      |________|__||_____||___  |_____||____|
--                                                                           |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- simple widget to display the calendar on the right bar.
--  ########################################################################
-- ########################################################################
-- ########################################################################
-- Provides shapes
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
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- provides style to months, days, focused day
--
styles.month = {padding = dpi(5), bg_color = beautiful.bg_modal, shape = beautiful.btn_lg_shape}
styles.normal = {shape = beautiful.btn_lg_shape, padding = dpi(5), bg_color = beautiful.bg_modal}
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
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- provides styling for the cells
--

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
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- calendar
local cal =
    wibox.widget {
    date = os.date("*t"),
    font = beautiful.font .. " 20",
    fn_embed = decorate_cell,
    -- start_sunday = true,
    align = "center",
    valign = "center",
    widget = wibox.widget.calendar.month,
    bg_color = beautiful.bg_modal
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- widget for calendar
--
local calWidget =
    wibox.widget {
    {
        cal,
        border_color = beautiful.xcolor7 .. "66",
        widget = wibox.container.margin,
        margins = dpi(6),
        layout = wibox.layout.align.horizontal
    },
    expand = "none",
    bg = beautiful.bg_modal,
    widget = card,
    border_color = beautiful.xcolor7 .. "66",
    border_width = dpi(3)
}

return calWidget
