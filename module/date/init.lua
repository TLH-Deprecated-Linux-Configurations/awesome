--  _____         __
-- |     \.---.-.|  |_.-----.
-- |  --  |  _  ||   _|  -__|
-- |_____/|___._||____|_____|
-- ------------------------------------------------- --
-- Variable assignment
local width = dpi(375)
-- ------------------------------------------------- --
-- Bluetooth Center template widget
local date = function(s)
    -- ------------------------------------------------- --
    s.date =
        wibox(
        {
            y = s.geometry.y,
            x = s.geometry.x + dpi(1200),
            visible = false,
            ontop = true,
            screen = mouse.screen,
            type = "splash",
            height = dpi(200),
            width = width,
            bg = beautiful.bg_normal,
            shape = beautiful.client_shape_rounded_lg,
            fg = colors.white
        }
    )
    local date_day =
        wibox.widget {
        font = "Nineteen Ninety Seven Bold 11",
        format = "%A",
        valign = "center",
        widget = wibox.widget.textclock
    }

    local date_month =
        wibox.widget {
        font = "Nineteen Ninety Seven Bold 11",
        format = "%d %B",
        valign = "center",
        widget = wibox.widget.textclock
    }
    -- ------------------------------------------------- --
    function date_toggle()
        if s.date.visible == false then
            s.date.visible = true
        elseif s.date.visible == true then
            s.date.visible = false
        end
    end

    -- ------------------------------------------------- --
    -- off signal
    awesome.connect_signal(
        "date:toggle:off",
        function()
            s.date.visible = false
        end
    )
    -- ------------------------------------------------- --
    -- toggle signal
    awesome.connect_signal(
        "date:toggle",
        function()
            date_toggle()
        end
    )
    -- ------------------------------------------------- --
    -- putting it all together
    s.date:setup {
        wibox.widget {
            spacing = dpi(15),
            date_day,
            nil,
            date_month,
            layout = wibox.layout.fixed.vertical
        },
        layout = wibox.layout.fixed.horizontal
    }
end
return date
