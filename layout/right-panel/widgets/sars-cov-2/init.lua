--  ______ _______ ___ ___ _______ _____       ____   ______
-- |      |       |   |   |_     _|     \     |_   | |  __  |
-- |   ---|   -   |   |   |_|   |_|  --  |     _|  |_|__    |
-- |______|_______|\_____/|_______|_____/     |______|______|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- just a simple parsing of API data in a little informational widget about
-- the virus which need not be named, out of morbid curiousity
-- ########################################################################
-- ########################################################################
-- ########################################################################
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local split = require("widget.functions.common").split
local card = require("widget.interface.card")
local HOME = os.getenv("HOME")
local PATH_TO_ICONS = HOME .. "/.config/awesome/layout/right-panel/widgets/sars-cov-2/icons/"
local beautiful = require("beautiful")
local covid_card = card("Domestic Covid-19 Cases")
-- ########################################################################
-- ########################################################################
-- ########################################################################
local covid_deceases =
    wibox.widget {
    text = ("No internet connection..."),
    font = beautiful.font .. " 10",
    align = "left",
    valign = "center",
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local covid_deaths =
    wibox.widget {
    text = ("Can't retreive deaths."),
    font = beautiful.font .. " 10",
    align = "left",
    valign = "center",
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
watch(
    [[bash -c "curl -s https://corona-stats.online/$(curl https://ipapi.co/country/)?minimal=true | sed -r 's/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g'"]],
    3600,
    function(_, stdout)
        local array = split(split(stdout, "\n")[2], "%s*")
        local infected = ("Infected: ") .. (array[4] or ("unknown"))
        local death = ("Deaths: ") .. (array[7] or ("unknown"))
        covid_deceases.text = infected
        covid_deaths.text = death
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local covid_icon_widget =
    wibox.widget {
    {
        id = "icon",
        image = PATH_TO_ICONS .. "corona" .. ".svg",
        resize = true,
        forced_height = dpi(45),
        forced_width = dpi(45),
        widget = wibox.widget.imagebox
    },
    layout = wibox.layout.fixed.horizontal
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local body =
    wibox.widget {
    expand = "none",
    layout = wibox.layout.fixed.horizontal,
    {
        wibox.widget {
            covid_icon_widget,
            margins = dpi(4),
            haligh = "center",
            valign = "center",
            widget = wibox.container.margin
        },
        margins = dpi(2),
        top = dpi(8),
        widget = wibox.container.margin
    },
    {
        {
            layout = wibox.layout.align.vertical,
            covid_deceases,
            covid_deaths,
            haligh = "center",
            valign = "center"
        },
        margins = dpi(2),
        top = dpi(12),
        widget = wibox.container.margin
    }
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
covid_card.update_title(("Domestic Covid-19 Cases"))
covid_card.update_body(body)

return covid_card
