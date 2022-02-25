# DEPENDENCIES

The following packages are the `Void Linux` required packages. For other distros, obviously there will be other package names, as these are approached in a highly idiosyncratic way in the `Void Linux` repositories.

| Package                              | Description                 |
| ------------------------------------ | --------------------------- |
| `awesome-git`                        | Must be built from source   |
| `xclip`                              | clipboard for font awesome  |
| `xautolock`                          | applying the lock screen    |
| `i3lock-color`                       | the lock screen application |
| `greenclip`                          | clipboard manager daemon    |
| `picom-ibhagwan`                     | Many compositing uses       |
| `upower`                             | Power management            |
| `gnome-keyring` & `libgnome-keyring` | Key Management              |
| `light`                              | backlight brightness        |
| `kitty`                              | terminal emulator           |
| `alsa`                               | volume control              |

## Considerations 

### Terminal 
I use kitty, though have been interested in tym because it is configured with lua (which I am comfortable with to say the least), nonetheless an error in my zsh configuration makes tmux painful to open in tym so we are sticking with kitty until that is solved. 

**Why Kitty?**

Kitty provides me with the best features of tmux (splitting the windows with a keybinding) without the additional complexity of extra configuration and it has many of the best features of various terminal emulators built right in, like unicode support, tabs, gpu based rendering to ease burden on your cpu, etc. No need for patches or settling for an inferior terminal. Plus the dev is a cool guy and the icon is cute.

## LuaRocks

These are more enhancements than dependencies, as the configuration will work fine without them and they probably are not contributing anything, but are installed anyway locally so while optional, they make life with lua a lot better. Many can be obtained with luarocks directly (`luarocks install x`) or your package manager. I like option 2 because it means being able to get packages for multiple lua versions more quickly but choice is yours. 

| Package     | Explanation                                                 |
| ----------- | ----------------------------------------------------------- |
| `lgi`       | Gnome GObject Introspection (whatever that hyperbole means) |
| `oocairo`   | Cairo support in lua                                        |
| `luasec`    | SSL/TSL integration                                         |
| `luaposix`  | eases shell-awesome integration somewhat                    |
| `lua-lpeg`  | pattern matching library                                    |
| `lua-cjson` | json interface library                                      |


