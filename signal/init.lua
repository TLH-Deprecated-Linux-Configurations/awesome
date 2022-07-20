--  _______ __                     __
-- |     __|__|.-----.-----.---.-.|  |
-- |__     |  ||  _  |     |  _  ||  |
-- |_______|__||___  |__|__|___._||__|
--             |_____|
-- ------------------------------------------------- --
-- These daemons are props to elenapan.
-- https://github.com/elenapan/dotfiles
if hardware.hasBattery() == true then
    pcall(require, 'signal.battery')
end

-- ------------------------------------------------- --

if hardware.hasWifi() == true then
    pcall(require, 'signal.network')
end
-- ------------------------------------------------- --s

if hardware.hasSound() == true then
    pcall(require, 'signal.volume')
end
-- ------------------------------------------------- --
pcall(require, 'signal.brightness')
pcall(require, 'signal.cpu')
pcall(require, 'signal.disk')
pcall(require, 'signal.ram')
pcall(require, 'signal.temp')

collectgarbage('collect')
