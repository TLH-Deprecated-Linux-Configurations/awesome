--  ______ _______ ___ ___ _______ _____       ____   ______
-- |      |       |   |   |_     _|     \     |_   | |  __  |
-- |   ---|   -   |   |   |_|   |_|  --  |     _|  |_|__    |
-- |______|_______|\_____/|_______|_____/     |______|______|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local watch = require('awful.widget.watch')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi
local split = require('lib.function.common').split
local card = require('module.interface.card')
local HOME = os.getenv('HOME')
local PATH_TO_ICONS = HOME .. '/.config/awesome/layout/right-panel/widgets/sars-cov-2/icons/'
local beautiful = require('beautiful')
local covid_card = card('Covid-19 cases in your country')
-- ########################################################################
-- ########################################################################
-- ########################################################################
local covid_deceases =
    wibox.widget {
    text = ('No internet connection...'),
    font = beautiful.font .. ' 16',
    align = 'left',
    valign = 'center',
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
local covid_deaths =
    wibox.widget {
    text = ("Can't retreive deaths."),
    font = beautiful.font .. ' 10',
    align = 'left',
    valign = 'center',
    widget = wibox.widget.textbox
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
watch(
    [[bash -c "curl -s https://corona-stats.online/$(curl https://ipapi.co/country/)?minimal=true | sed -r 's/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g'"]],
    3600,
    function(_, stdout)
        local array = split(split(stdout, '\n')[2], '%s*')
        local infected = ('Infected: ') .. (array[4] or ('unknown'))
        local death = ('Deaths: ') .. (array[7] or ('unknown'))
        covid_deceases.text = infected
        covid_deaths.text = death
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
watch(
    [[curl -s https://ipapi.co/country_name]],
    3600,
    function(_, stdout)
        covid_card.update_title(('Covid-19 cases in ') .. stdout)
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
local covid_icon_widget =
    wibox.widget {
    {
        id = 'icon',
        image = PATH_TO_ICONS .. 'corona' .. '.svg',
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
    expand = 'none',
    layout = wibox.layout.fixed.horizontal,
    {
        wibox.widget {
            covid_icon_widget,
            margins = dpi(4),
            widget = wibox.container.margin
        },
        margins = dpi(5),
        widget = wibox.container.margin
    },
    {
        {
            layout = wibox.layout.fixed.vertical,
            covid_deceases,
            covid_deaths
        },
        margins = dpi(4),
        widget = wibox.container.margin
    }
}
-- ########################################################################
-- ########################################################################
-- ########################################################################
covid_card.update_body(body)

return covid_card
