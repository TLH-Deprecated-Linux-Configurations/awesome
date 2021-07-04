# Using the Configuration

The easiest and most consistent way to appreciate this configuration as I do, is by trying out the Electric Tantra Linux either as a VM or Live USB. This insures you will have the prerequisite packages already installed, the components of the configuration in full working order and all of the advantages that come with my dotfiles in general and this configuration specifically. However, if you are not interested in such, just replace the contents of the `.config/awesome` directory with the content of this repository and refresh AwesomeWM. If you have installed all the prerequisites, it should load just fine (no promises, its fickle due to its size).

## General Design Consideration

I wanted to insure that this configuration could either be wholly mouse or keyboard driven, as lacking either makes for a less than optimal experience at exactly the wrong time. Thus the user can close windows by pressing the close button they know and love or by hitting <kbd>mod4</kbd> + <kbd>x</kbd>.

At present this is not 100%, some things will require keybindings to activate, others will require the mouse but by and large both should be available for all functionality and in time hopefully all will be (pull requests humbly appreciated)

## Prerequisite Packages

You will need to install the following packages, which are listed as they appear in the Arch Repositories and AUR. For other distros, we will have to await the possibility of someone using them to provide an adapted package list.

- awesome-git (aka the Development Branch of the AwesomeWM repository)
- feh
- xcape
- lua-coxpcall
- maim
- lua-socket
- lua-posix
- lua-cjson
- vicious
- lain-git
- awesome-freedesktop-git
- archlinux-xdg-menu
- archlinux-menus
- luarocks
- awmtt
- thunar
- thunar-dropbox
- bcompare-thunar
- thunarx-python
- thunar-custom-actions
- python-thunar-plugins-git
- thunar-archive-plugin
- thunar-media-tags-plugin
- thunar-volman
- thunar-secure-delete
- firefox
- rofi
- i3lock-color
- rofi-greenclip
- buku
- htop

## Keybindings

Keybindings are documented within the configuration, just press <kbd>mod4</kbd> + <kbd>F1</kbd> to display the list of keybindings with descriptions of their functionality.

Ultimately I have modified the default keybindings to achieve the following goals: - make more commonly used bindings less keys - add in functionality from other OSes I actually like (mod4 brings up application menu for instance) - remove useless bindings (I never have arbitrary lua functions I want to run in my window manager, why is that even a binding?) - easily access useful applications using <kbd>mod4</kbd> + <kbd>Fx</kbd>
