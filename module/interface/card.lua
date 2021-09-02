--  ______                __
-- |      |.---.-.----.--|  |
-- |   ---||  _  |   _|  _  |
-- |______||___._|__| |_____|

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Creates a new card widget
--    -- card with a title and body
--    local card = lib.card("title")
--    card.update_body(lib.textbox("body"))

local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi
-- ########################################################################
-- ########################################################################
-- ########################################################################
local header_font = beautiful.font .. " 14"
local bg = beautiful.bg_modal
local bg_title = beautiful.bg_modal_title
-- ########################################################################
-- ########################################################################
-- ########################################################################
local titled_card = function(title, height)
    local header =
        wibox.widget {
        text = title,
        font = header_font,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
        border_color = beautiful.xcolor0,
        bg = beautiful.xbackground .. "99",
        border_width = dpi(3),
        border_radius = dpi(12)
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################

    local body_widget =
        wibox.widget {
        wibox.widget.base.empty_widget(),
        shape = function(cr, rect_width, rect_height)
            gears.shape.partially_rounded_rect(cr, rect_width, rect_height, false, false, true, true, 6)
        end,
        widget = wibox.container.background,
        forced_height = height,
        bg = beautiful.xbackground .. "99"
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local widget =
        wibox.widget {
        layout = wibox.layout.fixed.vertical,
        {
            bg = beautiful.xbackground .. "99",
            wibox.widget {
                wibox.container.margin(header, dpi(10), dpi(10), dpi(10), dpi(10)),
                bg = bg_title,
                shape = function(cr, rect_width, rect_height)
                    gears.shape.partially_rounded_rect(cr, rect_width, rect_height, true, true, false, false, 6)
                end,
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.vertical
        },
        body_widget,
        nil,
        bg = beautiful.xbackground .. "99",
        border_color = beautiful.xcolor0,
        border_width = dpi(3),
        border_radius = dpi(12)
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    --- Update the title of the card
    -- @tparam string title The title of the card
    -- @staticfct update_title
    -- @usage -- This will change the title to hello
    -- card.update_title("hello")
    widget.update_title = function(updated_title)
        header.text = updated_title
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    --- Update the body of the card
    -- @tparam widget body The widget to put in the body of the card
    -- @staticfct update_body
    -- @usage -- This will change the body to world
    -- card.update_body(lib.textbox("world"))
    widget.update_body = function(update_body)
        body_widget.widget = update_body
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    --- Update the title and body
    -- @tparam string title The title of the card
    -- @tparam widget body The widget to put in the body of the card
    -- @staticfct update
    -- @usage -- This will change the title to "hello" and the body to "world"
    -- card.update("hello", lib.textbox("world"))
    widget.update = function(updated_title, update_body)
        widget.update_title(updated_title)
        widget.update_body(update_body)
    end
    return widget
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local bare_card = function()
    local body_widget =
        wibox.widget {
        wibox.widget.base.empty_widget(),
        bg = beautiful.xbackground .. "99",
        border_color = beautiful.xcolor0,
        border_width = dpi(3),
        border_radius = dpi(12),
        shape = function(cr, rect_width, rect_height)
            gears.shape.partially_rounded_rect(cr, rect_width, rect_height, true, true, true, true, 6)
        end,
        widget = wibox.container.background
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    --- Update the body of the card
    -- @tparam widget body The widget to put in the body of the card
    -- @staticfct update_body
    -- @usage -- This will change the body to world
    -- card.update_body(lib.textbox("world"))
    body_widget.update_body = function(update_body)
        body_widget.widget = update_body
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    --- Update the title and body
    -- @tparam string title The title of the card
    -- @tparam widget body The widget to put in the body of the card
    -- @staticfct update
    -- @usage -- This will change the title to "hello" and the body to "world"
    -- card.update("hello", lib.textbox("world"))
    body_widget.update = function(_, update_body)
        body_widget.update_body(update_body)
    end
    return body_widget
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Create a new card widget
-- @tparam[opt] string title Sets the title of the card
-- @tparam[opt] number size The height of the card
-- @treturn widget The card widget
-- @staticfct card
-- @usage -- This will create a card with the title hello
-- -- card with the title hello
-- local card = lib.card("hello")
return function(title, height)
    if title ~= nil then
        return titled_card(title, height)
    end
    return bare_card()
end
