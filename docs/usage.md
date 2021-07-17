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

Ultimately I have modified the default keybindings to achieve the following goals:

- make more commonly used bindings require few keys depressed at the same time (<kbd>mod</kbd> + <kbd>r</kbd> for refresh, dropping the shift)
- add in functionality from other OSes I actually like (mod4 brings up application menu for instance)
- remove useless bindings (I never have arbitrary lua functions I want to run in my window manager, why is that even a binding?)
- easily access useful applications using <kbd>mod4</kbd> + <kbd>Fx</kbd> for programs I use often, like Firefox or Thunar
- when possible, include both a keyboard driven and a mouse driven means of accomplishing a task. 
    This is a hugely important aspect of the configuration for my usage, sometimes I want to use the keyboard and sometimes the mouse. Which I use is dependent on a litany of factors but lacking either option just frustrates me and I want to keep the window manager out of my way as much as possible in that I don't want to have to check key bindings randomly when I am opening a program or loose access to something because the button is broken for whatever reason. As my grandfather always said, `Two is one and one is none`! 

## Tags

Using Gnome, XFCE, Plasma, etc I never once like using the workspaces features (and still don't when I sometimes have need to use them like after a fresh install before installing my dotfiles) as they make for a sluggish user experience and are somewhat harder to access in the mainly mouse driven world of the typical user. However, when using 
`awesomewm` it has almost no performance effect and so I find this functionality imperative to keeping all my work organized and thus have the configuration set up accordingly. 

While I like my font well enough, having the tag bar be 1-9 just wasn't very appealing to me, and being that the only alternatives require dynamic tagging (see below), I opted to use the suggestion of the `awesomewm` wiki's recipe for having it spell out `awesomewm` instead. Maybe its not as cool to the people who care about that, but I think it looks good enough and am aiming for maximizing my productivity over making something other people think is cool (while I don't mind that either). 

### Why No Dynamic Tagging ?! All the Cool Kids are Doing It

I hate dynamic tagging, seriously hate it. In such an arrangement all of my windows of one type end up on one tag, which means the multiple thousands of times a day that I have firefox open and a terminal with `nvim` next to it is something prohibited by default. That's counter-productive for me, even if it lends itself to far better looking tag bars. So I am not doing it that way. 

No it won't make me more productive. Yes I can just use separate screens with the various windows I need open, but that's still a pain because when I want the terminal open I don't want to have to move tags too
