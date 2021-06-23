--    _______ __                 __
--  |   _   |  |--.-----.--.--.|  |_
--  |       |  _  |  _  |  |  ||   _|
--  |___|___|_____|_____|_____||____|
-- ########################################################################
-- Initialization #########################################################
-- ########################################################################
local beautiful = require('beautiful')
local gears = require('gears')

local wibox = require('wibox')

local naughty = require('naughty')
local dpi = require('beautiful').xresources.apply_dpi

local clickable_container = require('widget.material.clickable-container')

local icons = require('theme.icons')

local config = require('configuration.functions')
local animate = require('lib.animations').createAnimObject
local signals = require('module.signals')

local height = dpi(320)
local width = dpi(480)
local theme = require('theme.icons')
local HOME = os.getenv('HOME')

local icon = HOME .. '/.config/awesome/widget/about/icons/info.svg'

local aboutPage
local aboutBackdrop
-- ########################################################################
-- Widget #################################################################
-- ########################################################################
screen.connect_signal(
    'request::desktop_decoration',
    function(s)
        -- Create the box

        aboutPage =
            wibox {
            bg = beautiful.bg_normal .. 'bb',
            visible = false,
            ontop = true,
            type = 'normal',
            height = height,
            width = width,
            x = s.geometry.x + s.geometry.width / 2 - (width / 2),
            y = s.geometry.y + s.geometry.height / 2 - (height / 2),
            shape = function(cr, shapeWidth, shapeHeight)
                gears.shape.rounded_rect(cr, shapeWidth, shapeHeight, 12)
            end
        }

        screen.connect_signal(
            'removed',
            function(removed)
                if s == removed then
                    aboutPage.visible = false
                    aboutPage = nil
                end
            end
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        signals.connect_refresh_screen(
            function()
                print('Refreshing about page')

                if not s.valid or aboutPage == nil then
                    return
                end

                -- the action center itself
                aboutPage.x = s.geometry.x + s.geometry.width / 2 - (width / 2)
                aboutPage.y = s.geometry.y + s.geometry.height / 2 - (height / 2)
            end
        )
        -- ########################################################################
        -- ########################################################################
        -- ########################################################################
        signals.connect_background_theme_changed(
            function(new_theme)
                aboutPage.bg = new_beautiful.bg_focus .. beautiful.background_transparency
            end
        )

        aboutBackdrop =
            wibox {
            ontop = true,
            visible = false,
            screen = s,
            bg = '#00000000',
            type = 'dock',
            x = s.geometry.x,
            y = s.geometry.y,
            width = s.geometry.width,
            height = s.geometry.height - dpi(38)
        }
    end
)

local grabber =
    awful.keygrabber {
    keybindings = {
        awful.key {
            modifiers = {},
            key = 'Escape',
            on_press = function()
                aboutBackdrop.visible = false
                animate(
                    _G.anim_speed,
                    aboutPage,
                    {y = aboutPage.screen.geometry.y - aboutPage.height},
                    'outCubic',
                    function()
                        aboutPage.visible = false
                    end
                )
            end
        }
    },
    -- Note that it is using the key name and not the modifier name.
    stop_key = 'Escape',
    stop_event = 'release'
}
-- ########################################################################
-- Controls ###############################################################
-- ########################################################################
local function toggleAbout()
    aboutBackdrop.visible = not aboutBackdrop.visible
    aboutPage.visible = not aboutPage.visible
    if aboutPage.visible then
        grabber:start()
        aboutPage.y = aboutPage.screen.geometry.y - aboutPage.height
        animate(
            _G.anim_speed,
            aboutPage,
            {y = aboutPage.screen.geometry.y + aboutPage.screen.geometry.height / 2 - (aboutPage.height / 2)},
            'outCubic'
        )
    else
        grabber:stop()
        aboutPage.visible = true
        animate(
            _G.anim_speed,
            aboutPage,
            {y = aboutPage.screen.geometry.y - aboutPage.height},
            'outCubic',
            function()
                aboutPage.visible = false
            end
        )
    end
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
aboutBackdrop:buttons(
    awful.util.table.join(
        awful.button(
            {},
            1,
            function()
                toggleAbout()
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local widget =
    wibox.widget {
    {
        id = 'icon',
        image = icon,
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local browserWidget =
    wibox.widget {
    {
        id = 'icon',
        image = icons.logo,
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}

local widget_button = clickable_container(wibox.container.margin(widget, dpi(7), dpi(7), dpi(6), dpi(6)))
widget_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                print('Showing Who Is To Blame')
                toggleAbout()
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local browserOpen = clickable_container(browserWidget, dpi(8), dpi(8), dpi(8), dpi(8))
browserOpen:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                print("Opening the developer's portfolio site in your browser")
                awful.spawn.easy_async_with_shell('$BROWSER https://thomasleonhighbaugh.me')
                toggleAbout()
                naughty.notify(
                    {
                        title = "Who's Responsible for this Mess?",
                        message = "Opened the developer's portfolio homepage",
                        timeout = 10,
                        position = 'top_right'
                    }
                )
            end
        )
    )
)

aboutPage:setup {
    expand = 'none',
    {
        browserOpen,
        wibox.widget {
            text = config.aboutText,
            font = 'agave Nerd Font Mono Bold  10',
            align = 'center',
            widget = wibox.widget.textbox
        },
        layout = wibox.layout.fixed.horizontal,
        shape = function(cr, shapeWidth, shapeHeight)
            gears.shape.rounded_rect(cr, shapeWidth, shapeHeight, 12)
        end
    },
    -- The real background color
    bg = beautiful.bg_normal,
    -- The real, anti-aliased shape
    shape = function(cr, shapeWidth, shapeHeight)
        gears.shape.rounded_rect(cr, shapeWidth, shapeHeight, 12)
    end,
    widget = wibox.container.background()
}

return widget_button
