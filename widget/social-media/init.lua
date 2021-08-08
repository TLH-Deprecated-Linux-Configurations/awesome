--  _______              __         __      _______           __ __
-- |     __|.-----.----.|__|.---.-.|  |    |   |   |.-----.--|  |__|.---.-.
-- |__     ||  _  |  __||  ||  _  ||  |    |       ||  -__|  _  |  ||  _  |
-- |_______||_____|____||__||___._||__|    |__|_|__||_____|_____|__||___._|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local card = require("module.interface.card")

local beautiful = require("beautiful")

local clickable_container = require("widget.clickable-container")
local HOME = os.getenv("HOME")
local PATH_TO_ICONS = HOME .. "/.config/awesome/widget/social-media/icons/"
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Generate widget with background
local genWidget = function(widgets)
    return wibox.widget {
        {
            widgets,
            bg = beautiful.bg_modal,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 12)
            end,
            widget = wibox.container.background
        },
        margins = dpi(10),
        widget = wibox.container.margin
    }
end
-- ########################################################################
-- ########################################################################
-- ########################################################################
local social_card = card("Social Media", dpi(60))

local reddit_widget =
    wibox.widget {
    {
        id = "icon",
        image = PATH_TO_ICONS .. "reddit.svg",
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local reddit_button = clickable_container(wibox.container.margin(reddit_widget, dpi(3), dpi(3), dpi(3), dpi(3)))
reddit_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn.easy_async_with_shell(
                    "xdg-open https://reddit.com",
                    function(_)
                    end,
                    1
                )
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local github_widget =
    wibox.widget {
    {
        id = "icon",
        image = PATH_TO_ICONS .. "github_alt.svg",
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local github_button = clickable_container(wibox.container.margin(github_widget, dpi(3), dpi(3), dpi(3), dpi(3)))
github_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn.easy_async_with_shell(
                    "xdg-open https://github.com/Thomashighbaugh",
                    function(_)
                    end,
                    1
                )
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local twitter_widget =
    wibox.widget {
    {
        id = "icon",
        image = PATH_TO_ICONS .. "twitter.svg",
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local twitter_button = clickable_container(wibox.container.margin(twitter_widget, dpi(3), dpi(3), dpi(3), dpi(3)))
twitter_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn.easy_async_with_shell(
                    "xdg-open https://twitter.com",
                    function(_)
                    end,
                    1
                )
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local instagram_widget =
    wibox.widget {
    {
        id = "icon",
        image = PATH_TO_ICONS .. "instagram.svg",
        widget = wibox.widget.imagebox,
        resize = true
    },
    layout = wibox.layout.align.horizontal
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local instagram_button = clickable_container(wibox.container.margin(instagram_widget, dpi(3), dpi(3), dpi(3), dpi(3)))
instagram_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn.easy_async_with_shell(
                    "xdg-open https://instagram.com",
                    function(_)
                    end,
                    1
                )
            end
        )
    )
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local social_layout =
    wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(25),
    genWidget(github_button),
    genWidget(reddit_button),
    genWidget(twitter_button),
    genWidget(instagram_button)
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local body =
    wibox.widget {
    {
        expand = "none",
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            nil
        },
        social_layout,
        {
            layout = wibox.layout.fixed.horizontal,
            nil
        }
    },
    margins = dpi(5),
    widget = wibox.container.margin
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
social_card.update_body(body)

return social_card
