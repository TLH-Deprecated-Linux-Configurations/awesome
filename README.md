# awesomwm

## Work In Progress

This configuration is being adapted from the TDE, which is essentially an over complicated AwesomeWM configuration for another Arch variant called [TomOS](https://tos.odex.be/) (**no relation**).
I am modifying the source code of that repo rather intensely, making it suit my purposes and arranging it in a more useful albeit less snazzy, format for inclusion within the Electric
Tantra Linux. Due to the original form's basis being derived from the 'Glorious Dotfiles', another questionably named giant in Awesome WM configurations, a lot of the baggage from that repo's
idiosyncracies is making for a complicated and painful adaptation process that requires I use a version control else have to restart more often than I can tolerate.

## "What's With All the Comment Blocks"

Each file that I have either written myself or modified so heavily as to essentially be my own work, even if in the sense that the monster was Dr. Frankenstein's,follows a specific layout. **This is because otherwise these files can be hard to read and the comment blocks help to parse the file into appreciable chunks**. The layout I have derived for the typical file conforms to the diagram below

```lua
--  _______ _______ ______ _______ _______      _______        __        _______ __ __   __
-- |   _   |     __|      |_     _|_     _|    |   _   |.----.|  |_     |_     _|__|  |_|  |.-----.
-- |       |__     |   ---|_|   |_ _|   |_     |       ||   _||   _|      |   | |  |   _|  ||  -__|
-- |___|___|_______|______|_______|_______|    |___|___||__|  |____|      |___| |__|____|__||_____|

-- ################################################
-- ################################################
-- ################################################
initialization = require("some files")
-- ################################################
-- ################################################
-- ################################################
local widget = function(widget)
   return lua.is.garbage {
    widget,
    text="Lua is so awful it hurts",

   }
```

Which you may think is a little over zealous or I chop things up in a way that doesn't help you,which is fine. I suggest you do at least something like this for your own understanding of what is going on in the code and keeping things neat and tidy in your own configuration according to your own methodology.
