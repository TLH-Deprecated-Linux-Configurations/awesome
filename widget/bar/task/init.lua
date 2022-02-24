--  _______               __
-- |_     _|.---.-.-----.|  |--.
--   |   |  |  _  |__ --||    <
--   |___|  |___._|_____||__|__|

--  _____   __         __
-- |     |_|__|.-----.|  |_
-- |       |  ||__ --||   _|
-- |_______|__||_____||____|
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
--- Common method to create buttons.
--
local function create_buttons(buttons, object)
    if buttons then
        local btns = {}
        for _, b in ipairs(buttons) do
            -- Create a proxy button object: it will receive the real
            -- press and release events, and will propagate them to the
            -- button object the user provided, but with the object as
            -- argument.
            --
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
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- Update the widgets, creating them if needed
--
local function list_update(w, buttons, label, data, objects)
    w:reset()

    for i, o in ipairs(objects) do
        local cache = data[o]
        local ib, cb, tb, cbm, bgb, tbm, ibm, tt, l, ll, bg_clickable
        if cache then
            ib = cache.ib
            tb = cache.tb
            bgb = cache.bgb
            tbm = cache.tbm
            ibm = cache.ibm
            tt = cache.tt
        else
            ib = wibox.widget.imagebox()
            tb = wibox.widget.textbox()
            cb =
                wibox.widget {
                {
                    {
                        image = config_dir .. "theme/icons/titlebar/dhumavati/close-alt.png",
                        config_dir = filesystem.get_configuration_dir(),
                        resize = true,
                        widget = wibox.widget.imagebox
                    },
                    margins = dpi(4),
                    widget = wibox.container.margin
                },
                widget = wibox.container.background
            }

            -- Close Button
            --
            cb.shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 3)
            end

            cbm =
                wibox.widget {
                -- 4, 8 ,12 ,12 -- close button
                cb,
                left = dpi(2),
                right = dpi(2),
                top = dpi(2),
                bottom = dpi(2),
                widget = wibox.container.margin
            }
            cbm:buttons(
                gears.table.join(
                    awful.button(
                        {},
                        1,
                        nil,
                        function()
                            o:kill()
                        end
                    )
                )
            )
            -- Tying it all togehter
            --
            bg_clickable = clickable_container()
            bgb = wibox.container.background()
            tbm =
                wibox.widget {
                tb,
                left = dpi(4),
                right = dpi(4),
                widget = wibox.container.constraint()
            }
            tbm.width = dpi(84)

            -- Size the application's icon
            --
            ibm =
                wibox.widget {
                ib,
                left = dpi(6),
                right = dpi(6),
                top = dpi(6),
                bottom = dpi(6),
                widget = wibox.container.margin
            }
            l = wibox.layout.fixed.horizontal()
            ll = wibox.layout.fixed.horizontal()

            -- All of this is added in a fixed widget
            --
            l:fill_space(true)
            l:add(ibm)
            l:add(tbm)
            ll:add(l)
            ll:add(cbm)

            bg_clickable:set_widget(ll)
            -- And all of this gets a background
            --
            bgb:set_widget(bg_clickable)

            l:buttons(create_buttons(buttons, o))

            -- Tooltip to display whole title, if it was truncated
            --
            tt =
                awful.tooltip(
                {
                    objects = {tb},
                    mode = "outside",
                    align = "bottom",
                    delay_show = 1
                }
            )

            data[o] = {
                ib = ib,
                tb = tb,
                bgb = bgb,
                tbm = tbm,
                ibm = ibm,
                tt = tt
            }
            local cache = data[o]
        end

        local text, bg, bg_image, icon, args = label(o, tb)

        args = args or {}

        -- The text might be invalid, so use pcall.
        --
        if text == nil or text == "" then
            tbm:set_margins(4)
        else
            -- Truncate when title is too long
            local text_only = text:match(">(.-)<")
            tb:set_markup_silently(text)

            if (utf8.len(text_only) > 16) then
                text = text:gsub(">(.-)<", ">" .. string.sub(text_only, 1, utf8.offset(text_only, 16) - 1) .. "...<")
                tt:set_text(text_only)
                tt:add_to_object(tb)
            else
                tt:remove_from_object(tb)
            end
            tb:set_text(text_only)
            tb:set_markup_silently("<b><i>" .. text .. "</i></b>")
        end
        if type(bg_image) == "function" then
            bg_image = bg_image(tb, o, nil, objects, i)
        end
        bgb:set_bgimage(bg_image)
        if icon then
            ib.image = gears.surface(icon)
        else
            ibm:set_margins(0)
        end

        bgb.shape = args.shape
        bgb.shape_border_width = args.shape_border_width
        bgb.shape_border_color = args.shape_border_color

        w:add(bgb)
    end
end
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local tasklist_buttons =
    awful.util.table.join(
    awful.button(
        {},
        1,
        function(c)
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end
                -- This will also un-minimize
                -- the client, if needed
                c:emit_signal("request::activate")
                c:raise()
            end
        end
    ),
    awful.button(
        {},
        2,
        function(c)
            c:kill()
        end
    ),
    -- Using the mouse wheel for this is
    -- insanely frustrating, so the scroll
    -- buttons are used instead
    --
    awful.button(
        {},
        8,
        function()
            awful.client.focus.byidx(1)
        end
    ),
    awful.button(
        {},
        9,
        function()
            awful.client.focus.byidx(-1)
        end
    )
)
-- ------------------------------------------------- --
-- ------------------------------------------------- --
-- ------------------------------------------------- --
local task_list = function(s)
    return awful.widget.tasklist(
        s,
        awful.widget.tasklist.filter.currenttags,
        tasklist_buttons,
        {},
        list_update,
        wibox.layout.fixed.horizontal()
    )
end

return task_list
