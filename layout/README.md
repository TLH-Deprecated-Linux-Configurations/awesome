# Layout 

This subdirectory contains that relate to drawing the bar on the bottom, taking its name from the screen's layout. 

Specifically, the widgets and modules in this directory pertain to the creation of a bottom bar, with its associated portions in the form of widgets that are displayed on it. 

## Just One Bar, Now With Menus 

I used to keep control panel items and the notification queue on distinct, pop-over bars that would be called with a key or button press, but have moved to placing these on popup menus instead, which I feel a slightly cleaner and a lot less of a stylistic nightmare. 

## Why Not [insert bar people using i3/sway like at the moment]

Unix philosophy is do one thing a do it well, sure and for 99% of things that is awesome but I am ok with Awesome doing too many things and none of them well for the following reasons:
    - **Most of those bars suck** - there is less functionality in the overwhelming majority of bars as compared to what comes in the `wibox` library for awesome
    - **I am already working with lua on everything else** - the additional subdirectory to handle the configuration of the bar is hardly as onerous as keeping that piece of my configuration separately. I like the idea of keeping my window manager and GUI interface within one configuration, am already convinced of Lua's power and like the `wibox` functionality well enough to use it. 
    - **What's cool on Unixporn is not the point** - not to knock the community too much (its mods are lame, on a serious power-trip and have bad taste, its not the community's fault) but this is meant as **my configuration that I find useful as my daily driver** what is cool is not usually what is useful. Thus I am not going to use whatever bar is cool this week at expense of the functionality, ease of configuration, general placement within my configuration, etc. 

## Not Auto-Hiding?

At the moment I am not auto-hiding the bar, primarily because it does not take up enough screen real estate to justify that buggy nightmare. I have in the past hide the bottom bar and required a key combo or hovering on the bottom most pixel to acheive 