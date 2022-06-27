--  _______
-- |   |   |.-----.-----.--.--.
-- |       ||  -__|     |  |  |
-- |__|_|__||_____|__|__|_____|
-- ------------------------------------------------- --
-- Mostly the work of the copyright holders
-- (c) 2016, Luke Bonham
-- (c) 2014, Harvey Mittens
-- ------------------------------------------------- --
local apps = require('settings')
local io,
    pairs,
    string,
    table,
    os = io, pairs, string, table, os

-- Expecting a wm_name of awesome omits too many applications and tools
menu_utils.wm_name = ''

-- Menu table
local menu = {}

-- Determines if a path points to a directory, by checking if it can be read
-- (which is `nil` also for empty files) and if its size is not 0.
-- @author blueyed
-- @param path the path to check
menu.is_dir = function(path)
    local f = io.open(path)
    return f and not f:read(0) and f:seek('end') ~= 0 and f:close()
end

-- Remove non existent paths in order to avoid issues
local existent_paths = {}
for k, v in pairs(menu_gen.all_menu_dirs) do
    if menu.is_dir(v) then
        table.insert(existent_paths, v)
    end
end
menu_gen.all_menu_dirs = existent_paths

-- Determines whether an table includes a certain element
-- @param tab a given table
-- @param val the element to search for
-- @return true if the given string is found within the search table; otherwise, false if not
menu.has_value = function(tab, val)
    for index, value in pairs(tab) do
        if val:find(value) then
            return true
        end
    end
    return false
end

-- Use MenuBar parsing utils to build a menu for Awesome
-- @return awful.menu
menu.build = function(args)
    local args = args or {}
    local icon_size = args.icon_size
    local before = args.before or {}
    local after = args.after or {}
    local skip_items = args.skip_items or {}
    local sub_menu = args.sub_menu or false

    local result = {}
    local _menu = awful_menu({items = before})

    menu_gen.generate(
        function(entries)
            -- Add category icons
            for k, v in pairs(menu_gen.all_categories) do
                table.insert(result, {k, {}, v.icon})
            end

            -- Get items table
            for k, v in pairs(entries) do
                for _, cat in pairs(result) do
                    if cat[1] == v.category then
                        if not menu.has_value(skip_items, v.name) then
                            table.insert(cat[2], {v.name, v.cmdline, v.icon})
                        end
                        break
                    end
                end
            end

            -- Cleanup things a bit
            for i = #result, 1, -1 do
                local v = result[i]
                if #v[2] == 0 then
                    -- Remove unused categories
                    table.remove(result, i)
                else
                    --Sort entries alphabetically (by name)
                    table.sort(
                        v[2],
                        function(a, b)
                            return string.byte(a[1]) < string.byte(b[1])
                        end
                    )
                    -- Replace category name with nice name
                    v[1] = menu_gen.all_categories[v[1]].name
                end
            end

            -- Sort categories alphabetically also
            table.sort(
                result,
                function(a, b)
                    return string.byte(a[1]) < string.byte(b[1])
                end
            )

            -- Add menu item to hold the generated menu
            if sub_menu then
                result = {{sub_menu, result}}
            end

            -- Add items to menu
            for _, v in pairs(result) do
                _menu:add(v)
            end
            for _, v in pairs(after) do
                _menu:add(v)
            end
        end
    )

    -- Set icon size
    if icon_size then
        for _, v in pairs(menu_gen.all_categories) do
            v.icon = icon_theme():find_icon_path(v.icon_name, icon_size)
        end
    end

    -- Hold the menu in the module
    menu.menu = _menu

    return _menu
end

-- Create a launcher widget and a main menu
awesome_menu = {
    {
        'Hotkeys',
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end,
        icons.keyboard
    },
    {
        'Edit config',
        'nvim ' .. awesome.conffile,
        icons.text_editor
    },
    {
        'Restart',
        awesome.restart,
        icons.restart
    },
    {
        'Quit',
        function()
            awesome.quit()
        end,
        icons.power
    }
}

local default_app_menu = {
    {
        'File Manager',
        apps.default_programs.file_manager,
        icons.file_manager
    },
    {
        'Web browser',
        apps.default_programs.browser,
        icons.web_browser
    },
    {
        'Terminal',
        apps.default_programs.terminal,
        icons.terminal
    },
    {
        'Text Editor',
        apps.default_programs.editor,
        icons.text_editor
    }
}

-- Screenshot menu
local screenshot_menu = {
    {
        'Full',
        function()
            gears.timer.start_new(
                0.1,
                function()
                    awful.spawn.easy_async_with_shell(gfs .. 'bin/snapshot full')
                end
            )
        end,
        menubar.utils.lookup_icon('accessories-screenshot')
    },
    {
        'Area',
        function()
            gears.timer.start_new(
                0.1,
                function()
                    awful.spawn.easy_async_with_shell(gfs .. 'bin/snapshot area')
                end,
                menubar.utils.lookup_icon('accessories-screenshot')
            )
        end,
        menubar.utils.lookup_icon('accessories-screenshot')
    }
}

local tools_menu = {
    {
        'Awesome',
        awesome_menu,
        icons.awesome
    },
    {
        'Take a Screenshot',
        screenshot_menu,
        menubar.utils.lookup_icon('accessories-screenshot')
    },
    {
        'End Session',
        function()
            awesome.emit_signal('module::exit_screen:show')
        end,
        menubar.utils.lookup_icon('system-shutdown')
    }
}

mymainmenu =
    freedesktop.menu.build(
    {
        -- Not actually the size, but the quality of the icon
        icon_size = dpi(96),
        before = default_app_menu,
        after = tools_menu
    }
)

mylauncher = awful.widget.launcher({image = beautiful.awesome_icon, menu = mymainmenu})
