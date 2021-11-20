--  ______ __ __               __
-- |      |  |__|.-----.-----.|  |_
-- |   ---|  |  ||  -__|     ||   _|
-- |______|__|__||_____|__|__||____|

--  _______ __                     __
-- |     __|__|.-----.-----.---.-.|  |.-----.
-- |__     |  ||  _  |     |  _  ||  ||__ --|
-- |_______|__||___  |__|__|___._||__||_____|
--             |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- inspired by the work of Jeff M. Hubbard &lt;jeffmhubbard@gmail.com&gt;
--
-- This is a better way, at least for me, to organize signals. I will port
-- everything over here that's client related in time.
-- ########################################################################
-- ########################################################################
-- ########################################################################
require("awful.autofocus")

local client = client
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- When new client is added.
--
client.connect_signal(
    "request::manage",
    function(c)
        awful.titlebar.show(c)
        require("configuration.client.signals.position_on_screen")(c)
        require("configuration.client.signals.center_over_parent")(c)
    end
)

-- When client requests a titlebar.
--
client.connect_signal(
    "request::titlebars",
    function(c)
        require("widgets.interface.titlebar")(c)
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- When mouse enters client area.
--
client.connect_signal(
    "mouse::enter",
    function(c)
        require("configuration.client.signals.sloppy_focus")(c)
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- When client recieves focus.
--
client.connect_signal(
    "focus",
    function(c)
        require("configuration.client.signals.dynamic_opacity").focus(c)
    end
)
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- When client loses focus.
--
client.connect_signal(
    "unfocus",
    function(c)
        require("configuration.client.signals.dynamic_opacity").unfocus(c)
    end
)
