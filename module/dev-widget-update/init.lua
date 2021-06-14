-- this function should get called when the user want to start the development of the widgets

_G.dev_widget_started = false
_G.dev_widget_init = function()
    require('module.dev-widget-update.updater')
    _G.dev_widget_started = true
end

_G.dev_widget_side_view_started = false

_G.dev_widget_side_view_init = function()
    require('module.dev-widget-update.side-updater')
    _G.dev_widget_side_view_started = true
end
