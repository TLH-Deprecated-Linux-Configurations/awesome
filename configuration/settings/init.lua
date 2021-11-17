--  _______         __   __   __
-- |     __|.-----.|  |_|  |_|__|.-----.-----.-----.
-- |__     ||  -__||   _|   _|  ||     |  _  |__ --|
-- |_______||_____||____|____|__||__|__|___  |_____|
--                                     |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- Obviously, this calls the other files in this directory, which itself is
-- called in rc.lua. These types of files make life easier and enable the
-- inclusion of large amounts of files within a neatly nested structure
-- without being as painful as would normally be necessary. Especially due
-- to the global var file removing the need for file headers to be a library
-- require block as a sort of preamble. I hated those, so I have tried to find
-- and remove them all.
-- ########################################################################
-- ########################################################################
-- ########################################################################
return {
    require(... .. ".apps"),
    require(... .. ".auto-start"),
    require(... .. ".bootup_configuration"),
    require(... .. ".garbage"),
    require(... .. ".global_var"),
    require(... .. ".lazy_load_boot"),
    require(... .. ".notifications"),
    require(... .. ".signals"),
    require(... .. ".state")
}
