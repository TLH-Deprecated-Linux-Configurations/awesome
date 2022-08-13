--  _______
-- |   _   |.-----.-----.-----.
-- |       ||  _  |  _  |__ --|
-- |___|___||   __|   __|_____|
--          |__|  |__|
-- ------------------------------------------------- --
-- NOTE: this assigns the applications defined in settings
-- to the default table, which is then called elsewhere.
local settings = require("settings")

return {
  default = settings.default_programs
}
