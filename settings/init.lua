--  _______         __   __   __
-- |     __|.-----.|  |_|  |_|__|.-----.-----.-----.
-- |__     ||  -__||   _|   _|  ||     |  _  |__ --|
-- |_______||_____||____|____|__||__|__|___  |_____|
--                                     |_____|
-- ------------------------------------------------- --

return {
    theme = 'vice',
    background = '1.png',
    default_programs = {
        terminal = 'kitty',
        terminal_editor = 'code-oss',
        editor = 'nvim',
        browser = 'firefox',
        file_manager = 'thunar',
        terminal_file_manager = 'ranger',
        lock = config_dir .. 'bin/blur.sh',
        email = 'neomutt',
        chat = 'discord',
        screenshot = config_dir .. 'bin/snapshot.sh area'
    },
    profile_picture = 'user.png',
    window_gaps = 4,
    window_border_size = 2,
    dirs = {
        downloads = HOME .. '/Downloads',
        pictures = HOME .. '/Pictures',
        music = HOME .. '/Music',
        wallpapers = HOME .. '/.config/awesome/themes/wallpapers'
    },
    require(... .. '.garbage_collection')
}
