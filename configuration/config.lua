--  ______               ___ __
-- |      |.-----.-----.'  _|__|.-----.
-- |   ---||  _  |     |   _|  ||  _  |
-- |______||_____|__|__|__| |__||___  |
--                              |_____|
-- ########################################################################
-- ########################################################################
-- ########################################################################
return {
    widget = {
        email = {
            -- Email address
            address = '',
            -- App password
            app_password = '',
            -- Imap server
            imap_server = 'imap.gmail.com',
            -- Port
            port = '993'
        },
        weather = {
            -- API Key
            key = '',
            -- City ID
            city_id = '',
            -- Units
            units = 'metric',
            -- Update in N seconds
            update_interval = 1200
        },
        network = {
            -- Wired interface
            wired_interface = 'enp1s0',
            -- Wireless interface
            wireless_interface = 'wlp3s0'
        },
        clock = {
            -- Clock widget format
            military_mode = false
        },
        screen_recorder = {
            -- Default record dimension
            resolution = '1920x1080',
            -- X,Y coordinate
            offset = '0,0',
            -- Enable audio by default
            audio = false,
            -- Recordings directory
            save_directory = '$(xdg-user-dir VIDEOS)/Recordings/',
            -- Mic level
            mic_level = '20',
            -- FPS
            fps = '30'
        }
    },
    module = {
        auto_start = {
            -- Will create notification if true
            debug_mode = false
        }
    }
}
