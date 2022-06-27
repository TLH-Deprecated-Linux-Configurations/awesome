--  ______               __                         __
-- |   __ \.-----.-----.|  |--.--------.---.-.----.|  |--.-----.
-- |   __ <|  _  |  _  ||    <|        |  _  |   _||    <|__ --|
-- |______/|_____|_____||__|__|__|__|__|___._|__|  |__|__|_____|
-- ------------------------------------------------- --
-- File system bookmarks
local function create_bookmark(name, path)
    local original_color = colors.white
    local hover_color = colors.colorC

    local bookmark = wibox.widget.textbox()
    bookmark.font = 'Nineteen Ninety Seven Bold 14'
    bookmark.text = name
    bookmark.align = 'center'
    bookmark.valign = 'center'

    -- Buttons
    bookmark:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                function()
                    awful.spawn.with_shell(settings.file_manager .. ' ' .. path)
                    dashboard_hide()
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.spawn.with_shell(settings.terminal .. " -e 'ranger' " .. path)
                    dashboard_hide()
                end
            )
        )
    )

    -- Hover effect
    bookmark:connect_signal(
        'mouse::enter',
        function()
            bookmark.bg = colors.colorB
            bookmark.fg = colors.black
        end
    )

    return bookmark
end

local bookmarks =
    wibox.widget {
    {
        {
            {
                create_bookmark('HOME', '$HOME'),
                create_bookmark('DOWNLOADS', settings.dirs.downloads),
                create_bookmark('MUSIC', settings.dirs.music),
                create_bookmark('PICTURES', settings.dirs.pictures),
                create_bookmark('WALLPAPERS', settings.dirs.wallpapers),
                spacing = dpi(10),
                layout = wibox.layout.fixed.vertical
            },
            widget = wibox.container.background,
            bg = beautiful.bg_focus
        },
        widget = wibox.container.margin,
        margins = dpi(5)
    },
    widget = wibox.container.background,
    bg = beautiful.bg_normal
}

return bookmarks
