local hardware = require('lib.hardware-check')
local is_weak = hardware.isWeakHardware()
local beautiful = require('beautiful')

-- general conf is used by sentry (to opt out of it)
general = require('parser')(os.getenv('HOME') .. '/.config/awesome/electric-tantra/general.conf')

i18n = require('lib.i18n')
i18n.init('en')

awful = require('awful')
awful.screen.set_auto_dpi_enabled(true)

plugins = require('parser')(os.getenv('HOME') .. '/.config/awesome/electric-tantra/plugins.conf')
tags = require('parser')(os.getenv('HOME') .. '/.config/awesome/electric-tantra/tags.conf')
keys = require('parser')(os.getenv('HOME') .. '/.config/awesome/electric-tantra/keys.conf')
floating = require('parser')(os.getenv('HOME') .. '/.config/awesome/electric-tantra/floating.conf')

-- dynamic variables are defined here
-- update the value through this setter, making sure that the animation speed is disabled on weak hardware
_G.update_anim_speed = function(value)
    if general['weak_hardware'] == '1' or is_weak then
        _G.anim_speed = 0
        return
    end
    _G.anim_speed = value
end

_G.update_anim_speed(tonumber(general['animation_speed'] or '0.3'))

-- Theme
beautiful.init(require('theme'))
--plugins
require('widget.user-profile')
require('widget.social-media')
require('widget.sars-cov-2')
require('widget.calculator')
require('widget.calendar-widget')
