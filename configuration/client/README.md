# Client Configurations 

This subdirectory holds the configurations for client windows managed by AwesomeWM according to my taste and needs specific to me. These files handle the mouse buttons and keys specific to client windows (calling in modalbindings from the `../keys/` subdirectory).

Because the most major functionality of the window manager by default is... the management of windows themselves, this particular directory has a lot going on in it. I have detailed below what that is, for your convenience and my own memory:

| File/Directory | What It Does                                                                                                     |
| -------------- | ---------------------------------------------------------------------------------------------------------------- |
| buttons        | Assigns mouse button bindings when over client window                                                            |
| init           | single file to call in non-keybinding functionality                                                              |
| keys           | Assigns keybindings for client windows                                                                           |
| rules          | rules applied to new client windows based on freedesktop characteristics (usually class), crossover with signals |
| signals        | event callbacks that are set off by various signals that fire when a client window is opened, closed, etc.       |