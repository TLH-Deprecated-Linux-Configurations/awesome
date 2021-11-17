--  ______ __ __               __
-- |      |  |__|.-----.-----.|  |_
-- |   ---|  |  ||  -__|     ||   _|
-- |______|__|__||_____|__|__||____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
-- calls the files relating to the client window's configuration. Awesome
-- doesn't always need this much, sometimes this is an arbitrary distinction
-- but it helps maage all of these files a bit more to make it and then have
-- this directory to isolate that which is specific to it.
-- ########################################################################
-- ########################################################################
-- ########################################################################
return {
    require(... .. ".screenposition"),
    require(... .. ".rules"),
    require(... .. ".remember-geometry"),
    require(... .. ".keys"),
    require(... .. ".buttons")
}
