--  _______         __   __
-- |   |   |.-----.|  |_|  |--.-----.--.--.-----.
-- |       ||  _  ||   _|    <|  -__|  |  |__ --|
-- |___|___||_____||____|__|__|_____|___  |_____|
--                                  |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
local keys = {
    browser = require("widget.interface.hotkeys_popup.keys.browser"),
    tmux = require("widget.interface.hotkeys_popup.keys.tmux"),
    qutebrowser = require("widget.interface.hotkeys_popup.keys.qutebrowser"),
    termite = require("widget.interface.hotkeys_popup.keys.termite"),
    bash = require("widget.interface.hotkeys_popup.keys.bash"),
    git = require("widget.interface.hotkeys_popup.keys.git")
}
return keys
