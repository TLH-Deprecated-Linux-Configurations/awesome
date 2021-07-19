--  __   __ __   __         __
-- |  |_|__|  |_|  |.-----.|  |--.---.-.----.-----.
-- |   _|  |   _|  ||  -__||  _  |  _  |   _|__ --|
-- |____|__|____|__||_____||_____|___._|__| |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- External Library Handling
local awful = require("awful")
local gears = require("gears")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
-- ########################################################################
-- ########################################################################
-- ########################################################################
local prrect = function(radius, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
    end
end

-- ########################################################################
-- ########################################################################
-- ########################################################################
-- TODO clean this up 
-- {{{ Enable THICC Title Bars only while Floating
client.connect_signal("property::floating", function(c)
    local b = false;
    if c.first_tag ~= nil then
        b = c.first_tag.layout.name == "floating"
    end
    if c.floating or b then
        awful.titlebar.show(c)
    else
        if not c.bling_tabbed then
            awful.titlebar.show(c)
        end
    end
end)
-- ########################################################################
-- ########################################################################
-- ########################################################################
client.connect_signal("manage", function(c)
    if c.floating or c.first_tag.layout.name == "floating" then
        awful.titlebar.show(c)
    else
        if not c.bling_tabbed then
            awful.titlebar.show(c)
        end
    end
end)
-- ########################################################################
-- ########################################################################
-- ########################################################################
tag.connect_signal("property::layout", function(t)
    local clients = t:clients()
    for k, c in pairs(clients) do
        if c.floating or c.first_tag.layout.name == "floating" then
            awful.titlebar.show(c)
        else
            if not c.bling_tabbed then
                awful.titlebar.show(c)
            end
        end
    end
end)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- {{ Helper to create mult tb buttons
local function create_title_button(c)
    local tb_color = wibox.widget {
        forced_width = dpi(25),
        forced_height = dpi(25),
        bg = beautiful.xbackground .. "00",
        shape = gears.shape.rounded_rect,
        widget = wibox.container.background
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local tb = wibox.widget {
        tb_color,
        width = 25,
        height = 25,
        bg = beautiful.xbackground .. "00",
        strategy = "min",
        layout = wibox.layout.constraint
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local function update()
        if client.focus == c then
            tb_color.bg = beautiful.xbackground .. "00"
        else
            tb_color.bg = beautiful.xbackground .. "00"
        end
    end
    update()
    c:connect_signal("focus", update)
    c:connect_signal("unfocus", update)

    tb:connect_signal("mouse::enter", function()
        tb_color.bg = beautiful.xbackground .. "00"
    end)

    tb:connect_signal("mouse::leave", function()
        tb_color.bg = beautiful.xbackground .. "00"
    end)

    tb.visible = true
    return tb
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local buttons = gears.table.join(awful.button({}, 1, function()
        c:emit_signal("request::activate", "titlebar", {
            raise = true
        })
        if c.maximized == true then
            c.maximized = false
        end
        awful.mouse.client.move(c)
    end), awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", {
            raise = true
        })
        awful.mouse.client.resize(c)
    end), awful.button({}, 2, function()
        local c = mouse.object_under_pointer()
        c:kill()
    end), -- Side button up - toggle floating
    awful.button({}, 9, function()
        local c = mouse.object_under_pointer()
        client.focus = c
        -- awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
        c.floating = not c.floating
    end), -- Side button down - toggle ontop
    awful.button({}, 8, function()
        local c = mouse.object_under_pointer()
        client.focus = c
        c.ontop = not c.ontop

    end))
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local l_reverse_corner = wibox.widget {
        bg = beautiful.xcolor0,
        shape = prrect(6, false, false, true, false),
        widget = wibox.container.background
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local r_reverse_corner = wibox.widget {
        bg = beautiful.xcolor0,
        shape = prrect(6, false, false, false, true),
        widget = wibox.container.background
    }
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    local function update()
        if client.focus == c then
            -- Changed This
            l_reverse_corner.bg = beautiful.xbackground .. '00'
            r_reverse_corner.bg = beautiful.xbackground .. '00'
        else
            l_reverse_corner.bg = beautiful.xbackground .. '00'
            r_reverse_corner.bg = beautiful.xbackground .. '00'
        end
    end
    -- ########################################################################
    -- ########################################################################
    -- ########################################################################
    update()
    c:connect_signal("focus", update)
    c:connect_signal("unfocus", update)

    awful.titlebar(c, {
        position = "top",
        size = beautiful.titlebar_size
    }):setup{
        {
            {
                awful.titlebar.widget.floatingbutton(c),

                buttons = buttons,
                layout = wibox.layout.flex.horizontal
            },
            margins = dpi(0),
            widget = wibox.container.margin
        },

        { -- Middle
            -- awful.titlebar.widget.iconwidget(c),

            { -- Title
                align = 'center',

                widget = awful.titlebar.widget.titlewidget(c),
                color = beautiful.xcolor7
            },

            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        },
        {
            {
                {
                    l_reverse_corner,
                    bg = beautiful.xbackground,
                    shape = gears.rectangle,
                    widget = wibox.container.background
                },
                width = 0,
                height = 0,
                strategy = "exact",
                layout = wibox.layout.constraint
            },
            {
                {
                    {
                        {
                            awful.titlebar.widget.minimizebutton(c),
                            awful.titlebar.widget.maximizedbutton(c),
                            --  awful.titlebar.widget.stickybutton(c),
                            --   awful.titlebar.widget.ontopbutton(c),
                            awful.titlebar.widget.closebutton(c),
                            layout = wibox.layout.flex.horizontal,
                            margins = 0

                        },
                        margins = dpi(0),
                        spacing = dpi(12),
                        padding = dpi(6),
                        left = dpi(24),
                        right = dpi(0),
                        widget = wibox.container.margin
                    },
                    bg = beautiful.xbackground,
                    shape = prrect(beautiful.border_radius, true, true, false, false),

                    widget = wibox.container.background
                },

                top = dpi(0),
                widget = wibox.container.margin
            },
            {
                {
                    r_reverse_corner,
                    bg = beautiful.xbackground,
                    shape = gears.rectangle,
                    widget = wibox.container.background
                },
                width = 0,
                height = 0,
                strategy = "exact",
                layout = wibox.layout.constraint
            },

            top = dpi(2),
            right = dpi(2),
            -- widget = wibox.container.margin
            layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- EOF ------------------------------------------------------------------------

