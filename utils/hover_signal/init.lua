--  _______
-- |   |   |.-----.--.--.-----.----.
-- |       ||  _  |  |  |  -__|   _|
-- |___|___||_____|\___/|_____|__|

-- ------------------------------------------------- --
--- Takes a wibox.container.background and connects four signals to it
--  thanks to: https://github.com/Crylia/crylia-theme/blob/main/awesome/src/core/signals.lua
function Hover_signal(widget, bg, fg)
    local old_wibox,
        old_cursor,
        old_bg,
        old_fg

    local mouse_enter = function()
        if bg then
            old_bg = widget.bg
            if string.len(bg) == 7 then
                widget.bg = beautiful.bg_focus
            else
                widget.bg = beautiful.bg_button
            end
        end
        if fg then
            old_fg = colors.white
            widget.fg = colors.color1
        end
        local w = mouse.current_wibox
        if w then
            old_cursor,
                old_wibox = w.cursor, w
            w.cursor = 'hand1'
        end
    end

    local button_press = function()
        if bg then
            if bg then
                if string.len(bg) == 7 then
                    widget.bg = beautiful.bg_menu
                else
                    widget.bg = beautiful.bg_focus
                end
            end
        end
        if fg then
            widget.fg = colors.white
        end
    end

    local button_release = function()
        if bg then
            if bg then
                if string.len(bg) == 7 then
                    widget.bg = beautiful.bg_button
                else
                    widget.bg = beautiful.bg_focus
                end
            end
        end
        if fg then
            widget.fg = colors.white
        end
    end

    local mouse_leave = function()
        if bg then
            widget.bg = beautiful.bg_button
        end
        if fg then
            widget.fg = colors.white
        end
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
    end

    widget:disconnect_signal('mouse::enter', mouse_enter)

    widget:disconnect_signal('button::press', button_press)

    widget:disconnect_signal('button::release', button_release)

    widget:disconnect_signal('mouse::leave', mouse_leave)

    widget:connect_signal('mouse::enter', mouse_enter)

    widget:connect_signal('button::press', button_press)

    widget:connect_signal('button::release', button_release)

    widget:connect_signal('mouse::leave', mouse_leave)
end
