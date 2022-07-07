--         __                               __   __
-- .-----.|  |.---.-.--.--.-----.----.----.|  |_|  |
-- |  _  ||  ||  _  |  |  |  -__|   _|  __||   _|  |
-- |   __||__||___._|___  |_____|__| |____||____|__|
-- |__|             |_____|
-- ------------------------------------------------- --
--  https://github.com/BlingCorp/bling.git
-- taken directly from their playerctl implementation,
-- but under my control and of a definite version also
-- under my control.
-- ------------------------------------------------- --
local backend = require(... .. '.backend')
local playerctl = {}
local instance = nil
-- ------------------------------------------------- --
local function new()
	return backend.lib(
		{
			update_on_activity = true,
			player = {'spotify', 'mpd', '%any'},
			debounce_delay = 1
		}
	)
end

if not instance then
	instance = new()
end
return instance
