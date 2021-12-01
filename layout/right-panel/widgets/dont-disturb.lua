--  _____  _______ _____
-- |     \|    |  |     \
-- |  --  |       |  --  |
-- |_____/|__|____|_____/
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Do not disturb, which will block out the notifications awesome displays
-- if set on (hopefully, I rarely use this)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Set State Default
--

_G.dont_disturb = false
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Create card for the widget
local disturb_card = card()
local box
-- ########################################################################
-- ########################################################################
-- ########################################################################
local dont_disturb_text =
    wibox.widget {
    text = "Pause Notifications",
    font = beautiful.font .. " 10",
    align = "left",
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function update_disturb(state)
    -- luacheck: ignore dont_disturb
    dont_disturb = state
    if box then
        box.update(state)
    end
    signals.emit_do_not_disturb(dont_disturb)
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
box =
    checkbox(
    false,
    function(checked)
        update_disturb(checked)
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local dont_disturb_icon =
    wibox.widget {
    {
        image = icons.moon,
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
signals.connect_do_not_disturb(
    function(bDoNotDisturb)
        if dont_disturb == bDoNotDisturb then
            return
        end

        update_disturb(bDoNotDisturb)
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- set contents into widget
local content =
    wibox.widget {
    {
        wibox.container.margin(dont_disturb_icon, dpi(12), dpi(12), dpi(5), dpi(5)),
        dont_disturb_text,
        layout = wibox.layout.fixed.horizontal
    },
    nil,
    {
        box,
        layout = wibox.layout.fixed.horizontal
    },
    layout = wibox.layout.align.horizontal
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- wrap widget for displat on the right bar
--
local dont_disturb_wrap =
    wibox.widget {
    wibox.widget {
        {
            content,
            margins = dpi(10),
            widget = wibox.container.margin
        },
        widget = wibox.container.background
    },
    widget = mat_list_item
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- add content to the bar
--
disturb_card.update_body(dont_disturb_wrap)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- return widget with margins
--
return wibox.container.margin(disturb_card, dpi(15), dpi(15))
