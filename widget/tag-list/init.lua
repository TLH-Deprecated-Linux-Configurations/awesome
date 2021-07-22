--  __                __ __         __
-- |  |_.---.-.-----.|  |__|.-----.|  |_
-- |   _|  _  |  _  ||  |  ||__ --||   _|
-- |____|___._|___  ||__|__||_____||____|
--            |_____|
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local clickable_container = require("widget.clickable-container")

local modkey = require("configuration.keys.mod").modkey
local altkey = require("configuration.keys.mod").altkey

-- ########################################################################
-- ########################################################################
-- ########################################################################
--- Common method to create buttons.
local function create_buttons(buttons, object)
    if buttons then
        local btns = {}
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################

        for _, b in ipairs(buttons) do
            -- Create a proxy button object: it will receive the real
            -- press and release events
            local btn =
                awful.button {
                modifiers = b.modifiers,
                button = b.button,
                on_press = function()
                    b:emit_signal("press", object)
                end,
                on_release = function()
                    b:emit_signal("release", object)
                end
            }
            btns[#btns + 1] = btn
        end
        return btns
    end
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local function list_update(w, buttons, label, data, objects)
    -- update the widgets, creating them if needed
    w:reset()
    for i, o in ipairs(objects) do
        local cache = data[o]
        local ib, tb, bgb, tbm, ibm, l, bg_clickable
        if cache then
            ib = cache.ib
            tb = cache.tb
            bgb = cache.bgb
            tbm = cache.tbm
            ibm = cache.ibm
        else
            ib = wibox.widget.imagebox()
            tb = wibox.widget.textbox()
            bgb = wibox.container.background()
            tbm =
                wibox.widget {
                tb,
                left = dpi(7),
                right = dpi(7),
                widget = wibox.container.margin
            }
            ibm =
                wibox.widget {
                ib,
                margins = dpi(10),
                widget = wibox.container.margin
            }
            l = wibox.layout.flex.horizontal()
            bg_clickable = clickable_container()

            -- All of this is added in a fixed widget
            l:fill_space(true)
            --	l:add(ibm)
            l:add(tbm)
            bg_clickable:set_widget(l)

            -- And all of this gets a background
            bgb:set_widget(bg_clickable)

            bgb:buttons(create_buttons(buttons, o))

            data[o] = {ib = ib, tb = tb, bgb = bgb, tbm = tbm, ibm = ibm}
        end
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        local text, bg, bg_image, icon, args = label(o, tb)
        args = args or {}

        -- The text might be invalid, so use pcall.
        if text == nil or text == "" then
            tbm:set_margins(3)
        else
            if not tb:set_markup_silently(text) then
                tb:set_markup("<i>&lt;Invalid text&gt;</i>")
            end
        end
        bgb:set_bg(bg)
        if type(bg_image) == "function" then
            bg_image = bg_image(tb, o, nil, objects, i)
        end
        bgb:set_bgimage(bg_image)
        if icon then
            ib.image = icon
        else
            ibm:set_margins(0)
        end

        bgb.shape_border_width = 0
        bgb.shape_border_color = "00"

        w:add(bgb)
    end
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local tag_list = function(s)
    return awful.widget.taglist(
        s,
        awful.widget.taglist.filter.all,
        awful.util.table.join(
            awful.button(
                {},
                1,
                function(t)
                    t:view_only()
                end
            ),
            -- Seems like a great idea, until it fires randomly even without mod4 depressed. So I comment it out because
            -- I rarely use mod + a mouse anyway
            -- awful.button(
            --     {modkey, altkey},
            --     1,
            --     function(t)
            --         if _G.client.focus then
            --             _G.client.focus:move_to_tag(t)
            --             t:view_only()
            --         end
            --     end
            -- ),
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button(
                {modkey},
                3,
                function(t)
                    if _G.client.focus then
                        _G.client.focus:toggle_tag(t)
                    end
                end
            )
            --Absolutely NO SCROLLING MAKING THE TAGS CHANGE THAT IS THE MOST AWFUL PAIN IN MY *&^
        ),
        {},
        list_update,
        wibox.layout.fixed.horizontal()
    )
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
return tag_list
