local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local mat_list_item = require("widget.material.list-item")
local signals = require("module.settings.signals")
local card = require("module.ui-components.card")
local checkbox = require("module.ui-components.checkbox")
local HOME = os.getenv("HOME")
local beautiful = require("beautiful")
local PATH_TO_ICONS = HOME .. "/.config/awesome/widget/notification-center/icons/"

_G.dont_disturb = false

local disturb_card = card()
local box

local dont_disturb_text =
    wibox.widget {
    text = "Do Not Disturb",
    font = beautiful.font .. " 12",
    align = "left",
    widget = wibox.widget.textbox
}

local function update_disturb(state)
    -- luacheck: ignore dont_disturb
    dont_disturb = state
    if box then
        box.update(state)
    end
    signals.emit_do_not_disturb(dont_disturb)
end

box =
    checkbox(
    false,
    function(checked)
        update_disturb(checked)
    end
)

local dont_disturb_icon =
    wibox.widget {
    {
        image = PATH_TO_ICONS .. "dont-disturb" .. ".svg",
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}

signals.connect_do_not_disturb(
    function(bDoNotDisturb)
        if dont_disturb == bDoNotDisturb then
            return
        end

        update_disturb(bDoNotDisturb)
    end
)

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

disturb_card.update_body(dont_disturb_wrap)

return wibox.container.margin(disturb_card, dpi(15), dpi(15))
