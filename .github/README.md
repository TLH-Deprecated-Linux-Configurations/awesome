# Awesome Window Manager Configuration

1. [Awesome Window Manager Configuration](#awesome-window-manager-configuration)

   1. [Introduction](#introduction)
   2. ["What's With All the Comment Blocks"](#whats-with-all-the-comment-blocks)
   3. [Testing Changes](#testing-changes)
   4. [Eternally Work in Progress](#eternally-work-in-progress)
   5. [Gallery Coming Soon](#gallery-coming-soon)
   6. [Neumorphic Design](#neumorphic-design)
   7. [Inspirations](#inspirations)

This flying spaghetti code monster is my configuration of AwesomeWM manager,
taken in small and large part from other configurations and libraries then
welded together in a way I find pleasing and effective in accomplishing my daily
needs with my systems. While an opinionated configuration of a truly excessive
size, I have focused on its overall functionality and adaptation to my ever
shifting patterns of use such that it is likely useful to others configuring
their own AwesomeWM environment as an example/template if nothing else.

**_To me_**, sharing this code for others to use as they see fit is what open
sourced technology is all about and I firmly believe that _a rising tide lifts
all ships in harbor_ Just the same, this is not set up as a library, so adapting
pieces of it will require you to put in the elbow grease, especially since I use
a config wide method of including libraries and modules since that is a little
easier than repeating the same`local awful = require("awful")` &
`local beautiful = require("beautiful")` at the start of each file.

---

## Introduction

This is a configuration for Awesome Window Manager, a dynamic window manager
that blends together the features of a floating and tiling window manager that
is the primary GUI I use on my Linux systems. Unlike the traditional stacking,
or floating, window managers most are accustomed to, Awesome can handle placing
new windows on screen by tiling, or subdividing, the screen according to one of
several patterns, which the user can change at will. Unlike many tiling window
managers, Awesome has a robust means of handling having floating windows as
well, which can be on screen with tiled windows simultaneously. Additionally,
unlike almost any alternative, AwesomeWM provides an expansive, if mostly
undocumented and disorganized, API to allow the user to customize and extend the
window manager according to the user's wants, needs and whims. AwesomeWM is
extended using the Lua language, which in most situations would be pretty slick
and useful, but due to Awesome's development cycle moving at the pace of
fossilization and its development team's insistence on using auto-generated docs
that are practically unreadable in any language, this process is one of
evaluating the work of others available on Github and welding together something
functional and useful out of those examples and whatever you can divine out of
its documentation or add in via more thoroughly documented Lua libraries and
libraries specific to the AwesomeWM community. This repository is one such
attempt at welding together something useful and as fully featured **as I want,
or at least can tolerate maintaining**. Feel free to use what you would like
from it, I have scrapped together useful bits from many sources (_see below_)
and put together some solutions of my own that may or may not be helpful to
others. Ultimately this configuration, as the centerpiece of my world as a Linux
user, is the center also of my personal distro **The Electric Tantra Linux** (at
least until I get around to forking and modifying InstantWM and InstantDE to my
liking).

---

## "What's With All the Comment Blocks"

Each file that I have either written myself or modified so heavily as to
essentially be my own work, even if in the sense that the monster was Dr.
Frankenstein's work,follows a specific layout. **This is because otherwise these
files can be hard to read and the comment blocks help to parse the file into
appreciable chunks**.Essentially the files follow the following format:

- ASCII Art file Name Occupying 3 Lines
- Three line comment bar
- `require` statements pulling in necessary modules
- three line comment bar
- function, section or other meaningful chunk
- three line comment bar
- several more chunks followed by comment bars
- return statement

Which you may think is a little over zealous or I chop things up in a way that
doesn't help you, that is fine as we are each our own individual and prefer
things our own way. I suggest you do at least something like this for your own
understanding of what is going on in the code and keeping things neat and tidy
in your own configuration according to your own methodology. Being honest with
ourselves, the monolithic blocks of Lua that are common in the awesome community
are hard to read, for others and for the author given any distance temporally
from writing those abominable things.

## Testing Changes

If you do plan to adapt this to your own purposes, I would advise you use the
tool `awmtt` which is easy enough to find on Github but I use a copy I keep in
my [local scripts](https://github.com/Thomashighbaugh/bin)

A handy little trick for those using the program "awmtt" to debug their changes
to their configurations is creating a symlink from your `rc.lua` file to the
test file expected by awmtt, which is `rc.lua.test`. To do this just enter the
command below in the `$HOME/.config/awesome` directory:

```bash
$ ln -svf rc.lua rc.lua.test
```

## Eternally Work in Progress

Upon the first release, which is upcoming still at the time of writing, there
will still be some work left that if you want to help by contributing pull
requests,please do it is much appreciated. A list of work to do is at the top of
the `CHANGELOG.md` file found in the `.github` directory. There you will also
find the contribution guide, which I would appreciate if you read as such will
save us both time and energy if you followed as I would not need to then
reformat anything, but either way I would still be happy for the help.

Regardless if you donate your arms or not to the collosal effort this
configuration is for me at least, know that this is my personal environment and
as such, due not to want of decisiveness but instead ever more exacting taste in
various aspects of my desktop, it is constantly subject to my tinkering and
radical rewriting tangents if I feel so compelled. While the hope is mitigating
this latter potential to the greatest potential possible, it is not a precluded
possiblity and I advise you plan your use of this code accordingly.

## Gallery Coming Soon

## Skeduomorphic Design

After getting enraged in the way all Linux users know only too well and
attempting to deduce if Neumorphism was possible in a `AwesomeWM` configuration
(its not actually possible in an Xorg environment as you can't differenate the
shadow colors on half of the sides of an object, Wayland I don't know and
honestly with the state of Wayland today, I don't really care either). The
result discovering that I could relatively easily produce the much more tasteful
precursor thereof relatively simply using a gradient applied as a background
using the builtin Cairo support Awesome's API exposes with a relatively cryptic
entry in its documentation about. The key to the appearance of skeduomorphism is
to pick a color (for the background of an object) and use a linear gradient that
places at the zero the color you choose and then a darker shade of that exact
same color at 1 position (or vice versa). Then to make the object appear to be a
button with its own dimensions (what Skeduomorphism is doing), one must simply
should add a dark border around the object that is thin.

To give you a sense of what this appears as in code check out the below examples
from this configuration's source code.

```lua
-- from theme/default-theme.lua
-- this applies the background at the root of the effect
theme.bg_normal = 'linear:0,0:0,21:0,#484d5e:1,#272A34'
theme.bg_focus = 'linear:0,0:0,21:0,#555e70:1,#323643'
-- ################################################################
-- ################################################################
-- ################################################################
-- from module/clickable-container.lua
   local container =
        wibox.widget {
        widget,
        widget = wibox.container.background,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 4)
        end,
        bg = beautiful.bg_focus,
        border_width = dpi(2),
        border_color = '#1b1d2488'
    }
```

---

## Inspirations

#### In No Particular Order

Here are some of the repositories I owe my eternal gratitude and appreciative
awe to as these are the repositories that served as the models, code stock and
examples that made Awesome's awful documentation more comprehensible and enabled
me to achieve this level of functionality.

- [Awedots by Javacafe](https://github.com/JavaCafe01/awedots)
- [dotfiles by elenapan](https://github.com/elenapan/dotfiles)
- [Tom Meyers' TDE, part of TOS](https://github.com/ODEX-TOS/tos-desktop-environment)
- [William McKinnon's AwesomeWM Configuration](https://github.com/WillPower3309/awesome-dotfiles)
- [manilarome's annoyingly titled dotfiles](https://github.com/manilarome/the-glorious-dotfiles)
- [dotfiles of Szorfein](https://github.com/szorfein/dotfiles)
- [The Bling Library](https://github.com/BlingCorp/bling)
- [awesome-shell](https://github.com/Mofiqul/awesome-shell)
