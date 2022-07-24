# Client Signals 

The `init.lua` file contains the callbacks and other adjustments made at the firing of client signals by calling the functionality contained within. This enables the isolation of the logic of each of these callbacks and thus enables me to better debug and manage these callbacks if/when the need arises. 

Each file's name does a decent job explaining its functionality but in case there is any ambiguity, below I have ennumerated the functiona provided by each:

| File                   | Functionality                                                                                                                                               |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| center_mouse_on_client | moves the mouse to the center of the focused client in situations such as closing a client or opening a new one                                             |
| center_over_parent     | without being full window swallowing, it insures context menus open on the same screen and over the parent                                                  |
| floating_geometry      | Provides functionality relating to the geometry of floating windows, between resets of awesome or setting the client as tiled then returning it to floating |
| floating_properties    | properties specific to floating windows                                                                                                                     |
| fullscreen_shape       | makes fullscreen and maximized windows square as rounded corners would make little sense for either                                                         |
| position_on_screen     | prevents clients from spawning off screen or in some other inaccessible position.                                                                           |
| sloppy_focus           | changes focus to where the mouse is located **without raising the window** because that's a nightmare.                                                      |