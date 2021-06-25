-- .--------.-----.-----.--.--.
-- |        |  -__|     |  |  |
-- |__|__|__|_____|__|__|_____|

-- ########################################################################
-- ########################################################################
-- ########################################################################
local gears = require('gears')
local beautiful = require('beautiful')
local apps = require('configuration.apps')
local hotkeys_popup = require('awful.hotkeys_popup').widget

local mousedrag = nil
local started = false
-- ########################################################################
-- ########################################################################
-- ########################################################################
if not (general['disable_desktop'] == '1') then
    mousedrag = require('module.mousedrag')
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local terminal = apps.default.terminal
local web_browser = os.getenv('BROWSER') or apps.default.web_browser
local file_manager = apps.default.file_manager
local text_editor = apps.default.editor
local editor_cmd = terminal .. ' -e ' .. (os.getenv('EDITOR') or 'nvim')
-- ########################################################################
-- ########################################################################
-- ########################################################################
beautiful.menu_font = 'agave Nerd Font Mono Bold 12'
beautiful.menu_height = 34
beautiful.menu_width = 180
beautiful.menu_bg_focus = beautiful.bg_focus -- add a bit of transparency
beautiful.menu_bg_normal = beautiful.bg_normal .. '44'
beautiful.menu_submenu = '➤'
beautiful.menu_border_width = 20
beautiful.menu_border_color = beautiful.bg_normal .. '44'
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Create a launcher widget and a main menu
local myawesomemenu = {
    {
        i18n.translate('Hotkeys'),
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end
    },
    {i18n.translate('Edit config'), editor_cmd .. ' ' .. awesome.conffile},
    {i18n.translate('Restart'), awesome.restart},
    {
        i18n.translate('Quit'),
        function()
            awesome.quit()
        end
    }
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Screenshot menu
local screenshot = {
    {
        i18n.translate('Full'),
        function()
            awful.spawn.easy_async_with_shell(
                apps.bins.full_screenshot,
                function(out)
                    print('Full screenshot\n' .. out)
                end
            )
        end
    },
    {
        i18n.translate('Area'),
        function()
            awful.spawn.easy_async_with_shell(
                apps.bins.area_screenshot,
                function(out)
                    print('Area screenshot\n' .. out)
                end
            )
        end
    }
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local freedesktop = require('freedesktop')
local menubar = require('menubar')
-- ########################################################################
-- ########################################################################
-- ########################################################################
local mymainmenu =
    freedesktop.menu.build(
    {
        -- Not actually the size, but the quality of the icon
        icon_size = 64,
        before = {
            {i18n.translate('Terminal'), terminal, menubar.utils.lookup_icon('utilities-terminal')},
            {i18n.translate('Web browser'), web_browser, menubar.utils.lookup_icon('webbrowser-app')},
            {i18n.translate('File Manager'), file_manager, menubar.utils.lookup_icon('system-file-manager')},
            {i18n.translate('Text Editor'), text_editor, menubar.utils.lookup_icon('accessories-text-editor')}
            -- other triads can be put here
        },
        after = {
            {'Awesome', myawesomemenu},
            {i18n.translate('Screenshot'), screenshot},
            {
                i18n.translate('End Session'),
                function()
                    print('Showing exit screen')
                    _G.exit_screen_show()
                end,
                menubar.utils.lookup_icon('system-shutdown')
            }
            -- other triads can be put here
        }
    }
)
awful.widget.launcher({image = beautiful.awesome_icon, menu = mymainmenu})
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Embed mouse bindings
root.buttons(
    gears.table.join(
        awful.button(
            {},
            3,
            function()
                mymainmenu:toggle()
            end
        ),
        awful.button(
            {},
            1,
            function()
                mymainmenu:hide()
                if not (general['disable_desktop'] == '1') then
                    mousedrag.start()
                    started = true
                end
            end,
            function()
                if not (general['disable_desktop'] == '1') and started then
                    mousedrag.stop()
                end
            end
        )
    )
)
