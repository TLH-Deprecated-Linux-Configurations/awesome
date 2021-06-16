--[[
███╗   ██╗██╗ ██████╗███████╗
████╗  ██║██║██╔════╝██╔════╝
██╔██╗ ██║██║██║     █████╗
██║╚██╗██║██║██║     ██╔══╝
██║ ╚████║██║╚██████╗███████╗
╚═╝  ╚═══╝╚═╝ ╚═════╝╚══════╝
Author: mu-tex
License: MIT
Repository: https://github.com/mut-ex/awesome-wm-nice
Forked to fit TDE (transapancy support)
]] -- ============================================================
-- local ret, lib = pcall(require, "libs")
-- local debug = ret and lib.debug or function() end
-- => Awesome WM
-- ============================================================
local gears = require('gears')

local atooltip = awful.tooltip
local abutton = awful.button
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi

local mode = ''
local draw_mode = 'full'

local beautiful = require('beautiful')
local get_font_height = beautiful.get_font_height
local primary_color = beautiful.xcolor4
-- Widgets
local imagebox = wibox.widget.imagebox
local textbox = wibox.widget.textbox
-- Layouts
local wlayout = wibox.layout
local wlayout_align_horizontal = wlayout.align.horizontal
local wlayout_fixed_horizontal = wlayout.fixed.horizontal
local wlayout_flex_horizontal = wlayout.flex.horizontal
-- Containers
local wcontainer = wibox.container
local wcontainer_background = wcontainer.background
local wcontainer_constraint = wcontainer.constraint
local wcontainer_margin = wcontainer.margin
local wcontainer_place = wcontainer.place
-- Gears
local gsurface = require('gears.surface')
local gtimer = require('gears.timer')
local gtimer_weak_start_new = gtimer.weak_start_new
-- ------------------------------------------------------------

-- => Math + standard Lua methods
-- ============================================================
local math = math
local max = math.max
local abs = math.abs
local floor = math.floor
local pairs = pairs
local ipairs = ipairs

-- ------------------------------------------------------------

-- => LGI
-- ============================================================
local lgi = require('lgi')
local gdk = lgi.Gdk
local get_default_root_window = gdk.get_default_root_window
local pixbuf_get_from_surface = gdk.pixbuf_get_from_surface
local pixbuf_get_from_window = gdk.pixbuf_get_from_window
-- ------------------------------------------------------------

-- => nice
-- ============================================================
-- Colors
local colors = require('module.titlebar.colors')
local color_darken = colors.darken
local color_lighten = colors.lighten
local is_contrast_acceptable = colors.is_contrast_acceptable
local relative_luminance = colors.relative_luminance
-- Shapes
local shapes = require('module.titlebar.shapes')
local create_corner_top_left = shapes.create_corner_top_left
local create_edge_top_middle = shapes.create_edge_top_middle
local gradient = shapes.duotone_gradient_vertical
-- ------------------------------------------------------------

-- gdk.init({})

-- => Local settings
-- ============================================================
local double_click_jitter_tolerance = 4
local double_click_time_window_ms = 250
local stroke_inner_sides_lighten_mul = 0.4
local stroke_outer_top_darken_mul = 0.7
local title_color_dark = '#17191e'
local title_color_light = '#f4f4f7'
local title_unfocused_opacity = 0.7
local titlebar_gradient_c1_lighten = 1
local titlebar_gradient_c2_offset = 0.5

local function rel_lighten(lum) return lum * 90 + 10 end
local function rel_darken(lum) return -(lum * 70) + 100 end

-- remove transparency from a hex color
local function untransparant(color)
    if tonumber(color:sub(2, 7), 16) < tonumber('200000', 16) then
        return '#17191e'
    end
    if not (#color) == 9 then return color end
    return color:sub(1, 7)
end
-- ------------------------------------------------------------

local nice = {
    MB_LEFT = 1,
    MB_MIDDLE = 2,
    MB_RIGHT = 3,
    MB_SCROLL_UP = 4,
    MB_SCROLL_DOWN = 5
}

-- => Defaults
-- ============================================================
local _private = {}
_private.max_width = 0
_private.max_height = 0

-- Titlebar
_private.titlebar_height = dpi(22)
_private.titlebar_radius = dpi(9)
_private.titlebar_color = '#17191e'
_private.titlebar_margin_left = 0
_private.titlebar_margin_right = 0
_private.titlebar_font = beautiful.font .. ' 11'
_private.titlebar_items = {
    left = {'floating', 'ontop', 'sticky'},
    middle = 'title',
    right = {'minimize', 'maximize', 'close'}
}
_private.context_menu_theme = {
    bg_focus = beautiful.xcolor5,
    bg_normal = '#00000044',
    border_color = '#00000075',
    border_width = 20,
    -- fg_focus = "#fefefa",
    -- fg_normal = "#fefefa",
    font = 'agave Nerd Font Mono Bold  11',
    height = dpi(45),
    width = dpi(450)
}
_private.no_titlebar_maximized = false
_private.mb_move = nice.MB_LEFT
_private.mb_contextmenu = nice.MB_RIGHT
_private.mb_resize = nice.MB_MIDDLE
_private.mb_win_shade_rollup = nice.MB_SCROLL_UP
_private.mb_win_shade_rolldown = nice.MB_SCROLL_DOWN

-- Titlebar Items
_private.button_size = dpi(10)
_private.button_margin_horizontal = 5
-- _private.button_margin_vertical
_private.button_margin_top = 5
-- _private.button_margin_bottom = 0
-- _private.button_margin_left = 0
-- _private.button_margin_right = 0
_private.tooltips_enabled = true
_private.tooltip_messages = {
    close = i18n.translate('close'),
    minimize = i18n.translate('minimize'),
    maximize_active = i18n.translate('unmaximize'),
    maximize_inactive = i18n.translate('maximize'),
    floating_active = i18n.translate('enable tiling mode'),
    floating_inactive = i18n.translate('enable floating mode'),
    ontop_active = i18n.translate("don't keep above other windows"),
    ontop_inactive = i18n.translate('keep above other windows'),
    sticky_active = i18n.translate('disable sticky mode'),
    sticky_inactive = i18n.translate('enable sticky mode')
}
_private.close_color = beautiful.xcolor1
_private.minimize_color = beautiful.xcolor3
_private.maximize_color = beautiful.xcolor2
_private.floating_color = beautiful.xcolor6
_private.ontop_color = beautiful.xcolor5
_private.sticky_color = beautiful.xcolor4
-- ------------------------------------------------------------

-- => Saving and loading of color rules
-- ============================================================
local t = require('module.titlebar.table')
-- luacheck: ignore 142 143
table.save = t.save
-- luacheck: ignore 142 143
table.load = t.load

-- Load the color rules or create an empty table if there aren't any
local config_dir = os.getenv('HOME') .. '/.cache/awesome'
local color_rules_filename = 'color_rules'
local color_rules_filepath = config_dir .. '/titlebar/' .. color_rules_filename
_private.color_rules = table.load(color_rules_filepath) or {}

-- Saves the contents of _private.color_rules table to file
local function save_color_rules()
    table.save(_private.color_rules, color_rules_filepath)
end

-- Adds a color rule entry to the color_rules table for the given client and saves to file
local function set_color_rule(c, color)
    if c.instance == nil then return end
    _private.color_rules[c.instance] = color or
                                           _private.context_menu_theme.bg_normal
    save_color_rules()
end

-- Fetches the color rule for the given client instance
local function get_color_rule(c) return _private.color_rules[c.instance] end
-- ------------------------------------------------------------

-- Returns the hex color for the pixel at the given coordinates on the screen
local function get_pixel_at(x, y)
    local pixbuf = pixbuf_get_from_window(get_default_root_window(), x, y, 1, 1)
    local bytes = pixbuf:get_pixels()
    return '#' ..
               bytes:gsub('.', function(c)
            return ('%02x'):format(c:byte())
        end)
end

-- Determines the dominant color of the client's top region
local function get_dominant_color(client)
    local color
    local pb
    local bytes
    local tally = {}
    local content = gsurface(client.content)
    local cgeo = client:geometry()
    local x_offset = 2
    local y_offset = 2
    local x_lim = floor(cgeo.width / 2)
    for x_pos = 0, x_lim, 2 do
        for y_pos = 0, 8, 1 do
            pb = pixbuf_get_from_surface(content, x_offset + x_pos,
                                         y_offset + y_pos, 1, 1)
            if pb == nil then
                return _private.context_menu_theme.bg_normal
            end
            bytes = pb:get_pixels()
            color = '#' ..
                        bytes:gsub('.', function(c)
                    return ('%02x'):format(c:byte())
                end)
            if not tally[color] then
                tally[color] = 1
            else
                tally[color] = tally[color] + 1
            end
        end
    end
    mode = nil
    local mode_c = 0
    for kolor, kount in pairs(tally) do
        if kount > mode_c then
            mode_c = kount
            mode = kolor
        end
    end
    color = mode
    set_color_rule(client, color)
    print('Found color of client:  ' .. color)
    return color
end

-- Returns a color that is analogous to the last color returned
-- To make sure that the "randomly" generated colors look cohesive, only the first color is truly random, the rest are generated by offsetting the hue by +33 degrees
local next_color = colors.rand_hex()
local function get_next_color()
    local prev_color = next_color
    next_color = colors.rotate_hue(prev_color, 33)
    return prev_color
end

-- Returns (or generates) a button image based on the given params
local function create_button_image(name, is_focused, event, is_on)
    local focus_state = is_focused and 'focused' or 'unfocused'
    local key_img
    -- If it is a toggle button, then the key has an extra param
    if is_on ~= nil then
        local toggle_state = is_on and 'on' or 'off'
        key_img = ('%s_%s_%s_%s'):format(name, toggle_state, focus_state, event)
    else
        key_img = ('%s_%s_%s'):format(name, focus_state, event)
    end
    -- If an image already exists, then we are done
    if _private[key_img] then return _private[key_img] end
    -- The color key just has _color at the end
    local key_color = key_img .. '_color'
    -- If the user hasn't provided a color, then we have to generate one
    if not _private[key_color] then
        local key_base_color = name .. '_color'
        -- Maybe the user has at least provided a base color? If not we just pick a pseudo-random color
        local base_color = _private[key_base_color] or get_next_color()
        _private[key_base_color] = base_color
        local button_color = base_color
        local H = colors.hex2hsv(base_color)
        -- Unfocused buttons are desaturated and darkened (except when they are being hovered over)
        if not is_focused and event ~= 'hover' then
            button_color = colors.hsv2hex(H, 0, 50)
        end
        -- Then the color is lightened if the button is being hovered over, or darkened if it is being pressed, otherwise it is left as is
        button_color =
            (event == 'hover') and colors.lighten(button_color, 45) or
                (event == 'press') and colors.darken(button_color, 45) or
                button_color
        -- Save the generate color because why not lol
        _private[key_color] = button_color
    end
    local button_size = _private.button_size
    -- If it is a toggle button, we create an outline instead of a filled shape if it is in off state
    -- _private[key_img] = (is_on ~= nil and is_on == false) and
    --                         shapes.circle_outline(
    --                             _private[key_color], button_size,
    --                             _private.button_border_width) or
    --                         shapes.circle_filled(
    --                             _private[key_color], button_size)
    _private[key_img] = shapes.circle_filled(_private[key_color], button_size)
    return _private[key_img]
end

-- Creates a titlebar button widget
local function create_titlebar_button(c, name, button_callback, property)
    local button_img = imagebox(nil, false)
    if _private.tooltips_enabled then
        local tooltip = atooltip {
            timer_function = function()
                return _private.tooltip_messages[name ..
                           (property and
                               (c[property] and '_active' or '_inactive') or '')]
            end,
            delay_show = 0.1,
            margins_leftright = 12,
            margins_topbottom = 6,
            timeout = 0.25,
            align = 'bottom_right'
        }
        tooltip:add_to_object(button_img)
    end
    local is_on, is_focused
    local event = 'normal'
    local function update()
        is_focused = c.active
        -- If the button is for a property that can be toggled
        if property then
            is_on = c[property]
            button_img.image = create_button_image(name, is_focused, event,
                                                   is_on)
        else
            button_img.image = create_button_image(name, is_focused, event)
        end
    end
    -- Update the button when the client gains/loses focus
    c:connect_signal('unfocus', update)
    c:connect_signal('focus', update)
    -- If the button is for a property that can be toggled, update it accordingly
    if property then c:connect_signal('property::' .. property, update) end
    -- Update the button on mouse hover/leave
    button_img:connect_signal('mouse::enter', function()
        event = 'hover'
        update()
    end)
    button_img:connect_signal('mouse::leave', function()
        event = 'normal'
        update()
    end)
    -- The button is updated on both click and release, but the call back is executed on release
    button_img.buttons = abutton({}, nice.MB_LEFT, function()
        event = 'press'
        update()
    end, function()
        if button_callback then
            event = 'normal'
            button_callback()
        else
            event = 'hover'
        end
        update()
    end)
    button_img.id = 'button_image'
    update()
    return wibox.widget {
        widget = wcontainer_place,
        {
            widget = wcontainer_margin,
            top = _private.button_margin_top or _private.button_margin_vertical or
                _private.button_margin,
            bottom = _private.button_margin_bottom or
                _private.button_margin_vertical or _private.button_margin,
            left = _private.button_margin_left or
                _private.button_margin_horizontal or _private.button_margin,
            right = _private.button_margin_right or
                _private.button_margin_horizontal or _private.button_margin,
            {
                button_img,
                widget = wcontainer_constraint,
                height = _private.button_size,
                width = _private.button_size,
                strategy = 'exact'
            }
        }
    }
end

local function get_titlebar_mouse_bindings(c)
    -- Add functionality for double click to (un)maximize, and single click and hold to move
    local clicks = 0
    local tolerance = double_click_jitter_tolerance
    local buttons = {
        abutton({}, _private.mb_move, function()
            local cx, cy = _G.mouse.coords().x, _G.mouse.coords().y
            local delta = double_click_time_window_ms / 1000
            clicks = clicks + 1
            if clicks == 2 then
                local nx, ny = _G.mouse.coords().x, _G.mouse.coords().y
                -- The second click is only counted as a double click if it is within the neighborhood of the first click's position, and occurs within the set time window
                if abs(cx - nx) <= tolerance and abs(cy - ny) <= tolerance then
                    c.maximized = not c.maximized
                end
            else
                c:activate{context = 'titlebar', action = 'mouse_move'}
            end
            -- Start a timer to clear the click count
            gtimer_weak_start_new(delta, function() clicks = 0 end)
        end), abutton({}, _private.mb_contextmenu, function()
            local menu_items = {}
            local function add_item(text, callback)
                menu_items[#menu_items + 1] = {text, callback}
            end
            add_item('Auto detect Window Decoration color', function()
                c._nice_base_color = untransparant(get_dominant_color(c))
                set_color_rule(c, c._nice_base_color)
                _private.add_window_decorations(c)
            end)
            add_item('Color Picker', function()
                _G.mousegrabber.run(function(m)
                    if m.buttons[1] then
                        c._nice_base_color = get_pixel_at(m.x, m.y)
                        set_color_rule(c, c._nice_base_color)
                        _private.add_window_decorations(c)
                        return false
                    end
                    return true
                end, 'crosshair')
            end)
            add_item('Cancel', function() end)
            if c._nice_right_click_menu then
                c._nice_right_click_menu:hide()
            end
            c._nice_right_click_menu = awful.menu {
                items = menu_items,
                theme = _private.context_menu_theme
            }
            c._nice_right_click_menu:show()
        end), abutton({}, _private.mb_resize, function()
            c:activate{context = 'mouse_click', action = 'mouse_resize'}
        end)
    }

    return buttons
end

-- Returns a titlebar widget for the given client
local function create_titlebar_title(c)
    local client_color = c._nice_base_color

    local title_widget = wibox.widget {
        align = 'center',
        ellipsize = 'middle',
        opacity = c.active and 1 or title_unfocused_opacity,
        valign = 'center',
        widget = textbox
    }

    local function update()
        local text_color = is_contrast_acceptable(title_color_light,
                                                  client_color) and
                               title_color_light or title_color_dark
        title_widget.markup =
            ("<span foreground='%s' font='%s'>%s</span>"):format(text_color,
                                                                 _private.titlebar_font,
                                                                 gears.string
                                                                     .xml_escape(
                                                                     c.name))
    end
    c:connect_signal('property::name', update)
    c:connect_signal('unfocus', function()
        title_widget.opacity = title_unfocused_opacity
    end)
    c:connect_signal('focus', function() title_widget.opacity = 1 end)
    update()
    local titlebar_font_height = get_font_height(_private.titlebar_font)
    local leftover_space = _private.titlebar_height - titlebar_font_height
    local margin_vertical = leftover_space > 1 and leftover_space / 2 or 0
    return {
        title_widget,
        widget = wcontainer_margin,
        top = margin_vertical,
        bottom = margin_vertical
    }
end

-- Returns a titlebar item
local function get_titlebar_item(c, name)
    if name == 'close' then
        return create_titlebar_button(c, name, function() c:kill() end)
    elseif name == 'maximize' then
        return create_titlebar_button(c, name, function()
            c.maximized = not c.maximized
        end, 'maximized')
    elseif name == 'minimize' then
        return create_titlebar_button(c, name, function()
            c.minimized = true
        end)
    elseif name == 'ontop' then
        return create_titlebar_button(c, name,
                                      function() c.ontop = not c.ontop end,
                                      'ontop')
    elseif name == 'floating' then
        return create_titlebar_button(c, name, function()
            c.floating = not c.floating
            if c.floating then c.maximized = false end
        end, 'floating')
    elseif name == 'sticky' then
        return create_titlebar_button(c, name, function()
            c.sticky = not c.sticky
            return c.sticky
        end, 'sticky')
    elseif name == 'title' then
        return create_titlebar_title(c)
    end
end

-- Creates titlebar items for a given group of item names
local function create_titlebar_items(c, group)
    if not group then return nil end
    if type(group) == 'string' then return get_titlebar_item(c, group) end
    local titlebar_group_items = wibox.widget {
        layout = wlayout_fixed_horizontal
    }
    local item
    for _, name in ipairs(group) do
        item = get_titlebar_item(c, name)
        if item then titlebar_group_items:add(item) end
    end
    return titlebar_group_items
end
-- ------------------------------------------------------------

-- Shows the window contents
function _private.shade_roll_down(c)
    if not c._nice_window_shade_up then return end
    c:geometry{x = c._nice_window_shade.x, y = c._nice_window_shade.y}
    c:activate()
    c._nice_window_shade.visible = false
    c._nice_window_shade_up = false
end

-- Hides the window contents
function _private.shade_roll_up(c)
    if c._nice_window_shade_up then return end
    local w = c._nice_window_shade
    local geo = c:geometry()
    w.x = geo.x
    w.y = geo.y
    w.width = geo.width
    c.minimized = true
    w.visible = true
    w.ontop = true
    c._nice_window_shade_up = true
end

-- Toggles the window shade state
function _private.shade_toggle(c)
    c.minimized = not c.minimized
    c._nice_window_shade.visible = c.minimized
end

-- Puts all the pieces together and decorates the given client
function _private.add_window_decorations(c)
    local client_color = c._nice_base_color
    -- Closures to avoid repetition
    local lighten = function(amount)
        return color_lighten(client_color, amount)
    end
    local darken =
        function(amount) return color_darken(client_color, amount) end
    -- > Color computations
    local luminance = relative_luminance(client_color)
    local lighten_amount = rel_lighten(luminance)
    local darken_amount = rel_darken(luminance)
    -- Inner strokes
    local stroke_color_inner_top = lighten(lighten_amount)
    local stroke_color_inner_sides = lighten(lighten_amount *
                                                 stroke_inner_sides_lighten_mul)
    -- Outer strokes
    local stroke_color_outer_top = darken(darken_amount *
                                              stroke_outer_top_darken_mul)
    local stroke_color_outer_sides = darken(darken_amount)
    local titlebar_height = _private.titlebar_height
    local background_fill_top = gradient(lighten(titlebar_gradient_c1_lighten),
                                         client_color, titlebar_height, 0,
                                         titlebar_gradient_c2_offset)
    -- The top left corner of the titlebar
    local corner_top_left_img = create_corner_top_left {
        background_source = background_fill_top,
        color = client_color,
        height = titlebar_height,
        radius = _private.titlebar_radius,
        stroke_offset_inner = 1.5,
        stroke_width_inner = 1,
        stroke_offset_outer = 0.5,
        stroke_width_outer = 1,
        stroke_source_inner = gradient(stroke_color_inner_top,
                                       stroke_color_inner_sides, titlebar_height),
        stroke_source_outer = gradient(stroke_color_outer_top,
                                       stroke_color_outer_sides, titlebar_height)
    }
    -- The top right corner of the titlebar
    local corner_top_right_img = shapes.flip(corner_top_left_img, 'horizontal')

    -- The middle part of the titlebar
    local top_edge = create_edge_top_middle {
        background_source = background_fill_top,
        color = client_color,
        height = titlebar_height,
        stroke_color_inner = stroke_color_inner_top,
        stroke_color_outer = stroke_color_outer_top,
        stroke_offset_inner = 1.25,
        stroke_offset_outer = 0.5,
        stroke_width_inner = 2,
        stroke_width_outer = 1,
        width = _private.max_width
    }
    -- Create the titlebar
    local titlebar = awful.titlebar(c, {
        size = titlebar_height,
        bg = 'transparent'
    })
    -- Arrange the graphics
    titlebar.widget = {
        imagebox(corner_top_left_img, true),
        {
            {
                {
                    create_titlebar_items(c, _private.titlebar_items.left),
                    widget = wcontainer_margin,
                    left = _private.titlebar_margin_left
                },
                {
                    create_titlebar_items(c, _private.titlebar_items.middle),
                    buttons = get_titlebar_mouse_bindings(c),
                    layout = wlayout_flex_horizontal
                },
                {
                    create_titlebar_items(c, _private.titlebar_items.right),
                    widget = wcontainer_margin,
                    right = _private.titlebar_margin_right
                },
                layout = wlayout_align_horizontal
            },
            widget = wcontainer_background,
            bgimage = top_edge
        },
        imagebox(corner_top_right_img, false),
        layout = wlayout_align_horizontal
    }

    if _private.no_titlebar_maximized then
        c:connect_signal('property::maximized', function()
            if c.maximized and client.focus then
                local curr_screen_workarea = client.focus.screen.workarea
                awful.titlebar.hide(c)
                c.shape = nil
                c:geometry{
                    x = curr_screen_workarea.x,
                    y = curr_screen_workarea.y,
                    width = curr_screen_workarea.width,
                    height = curr_screen_workarea.height
                }
            else
                awful.titlebar.show(c)
                -- Shape the client
                c.shape = shapes.rounded_rect {
                    tl = _private.titlebar_radius,
                    tr = _private.titlebar_radius,
                    bl = 4,
                    br = 4
                }
            end
        end)
    end

    -- Clean up
    collectgarbage('collect')
end

local function update_max_screen_dims()
    local max_height, max_width = 0, 0
    for s in _G.screen do
        max_height = max(max_height, s.geometry.height)
        max_width = max(max_width, s.geometry.width)
    end
    _private.max_height = max_height * 1.5
    _private.max_width = max_width * 1.5
end

local function validate_mb_bindings()
    local action_mbs = {
        'mb_move', 'mb_contextmenu', 'mb_resize', 'mb_win_shade_rollup',
        'mb_win_shade_rolldown'
    }
    local mb_specified = {false, false, false, false, false}
    local mb
    local mb_conflict_test
    for _, action_mb in ipairs(action_mbs) do
        mb = _private[action_mb]
        if mb then
            assert(mb >= 1 and mb <= 5, 'Invalid mouse button specified!')
            mb_conflict_test = mb_specified[mb]
            if not mb_conflict_test then
                mb_specified[mb] = action_mb
            else
                error(
                    ('%s and %s can not be bound to the same mouse button'):format(
                        action_mb, mb_conflict_test))
            end
        end
    end
end

function nice.initialize(args)
    update_max_screen_dims()
    _G.screen.connect_signal('list', update_max_screen_dims)
    local crush = require('gears.table').crush
    local table_args = {
        titlebar_items = true,
        context_menu_theme = true,
        tooltip_messages = true
    }
    if args then
        for prop, value in pairs(args) do
            if table_args[prop] == true then
                crush(_private[prop], value)
            elseif prop == 'titlebar_radius' then
                value = max(3, value)
                _private[prop] = value
            else
                _private[prop] = value
            end
        end
    end

    validate_mb_bindings()

    local function full(s)
        for _, c in pairs(s.clients) do
            if #s.tiled_clients >= 0 and
                (c.floating or c.first_tag.layout.name == 'floating') then
                awful.titlebar.show(c, 'top')
                c.shape = function(cr, w, h)
                    gears.shape.rectangle(cr, w, h)
                end
            elseif #s.tiled_clients == 1 and c.fullscreen == true then
                awful.titlebar.show(c, 'top')
                c.shape = function(cr, w, h)
                    gears.shape.rectangle(cr, w, h)
                end
            elseif #s.tiled_clients >= 1 and c.fullscreen == true then
                awful.titlebar.show(c, 'top')
                c.shape = function(cr, w, h)
                    gears.shape.rectangle(cr, w, h)
                end
            elseif #s.tiled_clients >= 1 and c.maximized == true then
                if c.maximized then
                    awful.titlebar.show(c, 'top')
                    c.shape = function(cr, w, h)
                        gears.shape.rectangle(cr, w, h)
                    end
                end
            elseif #s.tiled_clients == 1 and c.first_tag.layout.name ==
                'dwindle' then
                awful.titlebar.hide(c, 'top')
                c.shape = function(cr, w, h)
                    gears.shape.rectangle(cr, w, h)
                end
            elseif #s.tiled_clients > 1 and c.first_tag.layout.name == 'dwindle' then
                awful.titlebar.show(c, 'top')
                c.shape = function(cr, w, h)
                    gears.shape.rectangle(cr, w, h)
                end
            elseif #s.tiled_clients == 1 and c.first_tag.layout.name == 'tile' then
                awful.titlebar.hide(c, 'top')
                c.shape = function(cr, w, h)
                    gears.shape.rectangle(cr, w, h)
                end
            elseif #s.tiled_clients > 1 and c.first_tag.layout.name == 'tile' then
                awful.titlebar.show(c, 'top')
                c.shape = function(cr, w, h)
                    gears.shape.rectangle(cr, w, h)
                end
            end
        end
    end

    local function fast(s)
        for _, c in pairs(s.clients) do
            c.titlebars_enabled = c.titlebars_enabled or true
            if (not c.titlebars_enabled) or c.requests_no_titlebar then
                awful.titlebar.hide(c, 'top')
                c.shape = function(cr, w, h)
                    gears.shape.rectangle(cr, w, h)
                end
            elseif (c.floating or c.first_tag.layout.name == 'floating') then
                awful.titlebar.show(c, 'top')
                c.shape = function(cr, w, h)
                    gears.shape.rectangle(cr, w, h)
                end
            else
                awful.titlebar.hide(c, 'top')
                c.shape = function(cr, w, h)
                    gears.shape.rectangle(cr, w, h)
                end
            end
        end
    end

    local function none(s)
        for _, c in pairs(s.clients) do
            awful.titlebar.hide(c, 'top')
            c.shape = function(cr, w, h)
                gears.shape.rectangle(cr, w, h)
            end
        end
    end

    _G.client.connect_signal('request::titlebars', function(c)
        if c.requests_no_titlebar then
            awful.titlebar.hide(c, 'top')
            return
        end
        -- Callback
        c._cb_add_window_decorations = function()
            gtimer_weak_start_new(0.25, function()
                c._nice_base_color = untransparant(
                                         get_dominant_color(c) or
                                             _private.context_menu_theme
                                                 .bg_normal)
                set_color_rule(c, c._nice_base_color)
                _private.add_window_decorations(c)
                c:disconnect_signal('request::activate',
                                    c._cb_add_window_decorations)
            end)
        end -- _cb_add_window_decorations
        -- Check if a color rule already exists...
        local base_color = get_color_rule(c)
        if base_color then
            -- If so, use that color rule
            c._nice_base_color = base_color
            _private.add_window_decorations(c)
        else
            -- Otherwise use the default titlebar temporarily
            c._nice_base_color = _private.titlebar_color
            _private.add_window_decorations(c)
            -- Connect a signal to determine the client color and then re-decorate it
            c:connect_signal('request::activate', c._cb_add_window_decorations)
        end
        -- Shape the client
        c.shape = shapes.rounded_rect {
            tl = _private.titlebar_radius,
            tr = _private.titlebar_radius,
            bl = 4,
            br = 4
        }
    end)

    _G.screen.connect_signal('arrange', function(s)
        if draw_mode == 'full' then
            full(s)
        elseif draw_mode == 'none' then
            none(s)
        else
            fast(s)
        end
    end)
end

_G.client.connect_signal('property::floating', function(c)
    if c.floating then awful.placement.centered(c) end
    if c.titlebars_enabled and not c.requests_no_titlebar then
        awful.titlebar.show(c, 'top')
    else
        awful.titlebar.hide(c, 'top')
    end
end)

-- Show the titlebar if it's not maximized layout or floating layout
_G.tag.connect_signal('property::layout', function(tag)
    local clients = tag:clients()
    for _, c in pairs(clients) do
        if (c.first_tag.layout.name ~= 'max' and c.first_tag.layout.name ~=
            'floating') and not c.requests_no_titlebar then
            awful.titlebar.show(c, 'top')
        else
            awful.titlebar.hide(c, 'top')
        end
    end
end)

return setmetatable(nice,
                    {__call = function(_, ...) return nice.initialize(...) end})
