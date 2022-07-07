--  _______ __                     __
-- |     __|__|.-----.-----.---.-.|  |
-- |__     |  ||  _  |     |  _  ||  |
-- |_______|__||___  |__|__|___._||__|
--             |_____|
-- ------------------------------------------------- --
-- These daemons are props to elenapan.
-- https://github.com/elenapan/dotfiles
pcall(require, 'signal.battery')
pcall(require, 'signal.brightness')
pcall(require, 'signal.cpu')
pcall(require, 'signal.disk')
pcall(require, 'signal.network')
pcall(require, 'signal.ram')
pcall(require, 'signal.temp')
pcall(require, 'signal.volume')
pcall(require, 'signal.playerctl')
collectgarbage('collect')
