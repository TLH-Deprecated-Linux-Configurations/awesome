<h1>Awesome Window Manager Configuration</h1>

<p>
  This flying spaghetti code monster is my configuration of AwesomeWM manager,
  taken in small and large part from other configurations and libraries then
  welded together in a way I find pleasing and effective in accomplishing my
  daily needs with my systems. While an opinionated configuration of a truly
  excessive size, I have focused on its overall functionality and adaptation to
  my ever shifting patterns of use such that it is likely useful to others
  configuring their own AwesomeWM environment as an example if nothing else.
</p>

<details>
  <summary>Introduction</summary>
  <h2>Introduction</h2>
  <p>
    This is a configuration for Awesome Window Manager, a dynamic window manager
    that blends together the features of a floating and tiling window manager
    that is the primary GUI I use on my Linux systems. Unlike the traditional
    stacking, or floating, window managers most are accustomed to, Awesome can
    handle placing new windows on screen by tiling, or subdividing, the screen
    according to one of several patterns, which the user can change at will.
    Unlike many tiling window managers, Awesome has a robust means of handling
    having floating windows as well, which can be on screen with tiled windows
    simultaneously. Additionally, unlike almost any alternative, AwesomeWM
    provides an expansive, if mostly undocumented and disorganized, API to allow
    the user to customize and extend the window manager according to the user's
    wants, needs and whims. AwesomeWM is extended using the Lua language, which
    in most situations would be pretty slick and useful, but due to Awesome's
    development cycle moving at the pace of fossilization and its development
    team's insistence on using auto-generated docs that are practically
    unreadable in any language, this process is one of evaluating the work of
    others available on Github and welding together something functional and
    useful out of those examples and whatever you can divine out of its
    documentation or add in via more thoroughly documented Lua libraries and
    libraries specific to the AwesomeWM community. This repository is one such
    attempt at welding together something useful and as fully featured **as I
    want, or at least can tolerate maintaining**. Feel free to use what you
    would like from it, I have scrapped together useful bits from many sources
    (_see below_) and put together some solutions of my own that may or may not
    be helpful to others. Ultimately this configuration, as the centerpiece of
    my world as a Linux user, is the center also of my personal distro **The
    Electric Tantra Linux** (at least until I get around to forking and
    modifying InstantWM and InstantDE to my liking).
  </p>
</details>

<details>
  <summary>About the Code</summary>

  <h2>"What's With All the Comment Blocks"</h2>

Each file that I have either written myself or modified so heavily as to
essentially be my own work, even if in the sense that the monster was Dr.
Frankenstein's,follows a specific layout. **This is because otherwise these
files can be hard to read and the comment blocks help to parse the file into
appreciable chunks**. See the documentation for an example screenshot with a
more detailed explanation but essentially the files follow the following
format:

  <ul>
    <li>ASCII Art file Name Occupying 3 Lines</li>
    <li>Three line comment bar</li>
    <li>`require` statements pulling in necessary modules</li>
    <li>three line comment bar</li>
    <li>function, section or other meaningful chunk</li>
    <li>three line comment bar</li>
    <li>[several more chunks followed by comment bars]</li>
    <li>return statement</li>
  </ul>
  <p>
    Which you may think is a little over zealous or I chop things up in a way
    that doesn't help you, that is fine as we are each our own individual and
    prefer things our own way. I suggest you do at least something like this for
    your own understanding of what is going on in the code and keeping things
    neat and tidy in your own configuration according to your own methodology.
    Being honest with ourselves, the monolithic blocks of Lua that are common in
    the awesome community are hard to read, for others and for the author given
    any distance temporally from writing those abominable things.
  </p>

  <h2>Testing Changes</h2>
  <p>
    A handy little trick for those using the program "awmtt" to debug their
    changes to their configurations is creating a symlink from your
    <code>rc.lua</code> file to the test file expected by awmtt, which is
    <code>rc.lua.test</code>. To do this just enter the command below in the
    <code>$HOME/.config/awesome</code> directory:
  </p>
  <codeblock> $ ln -svf rc.lua rc.lua.test </codeblock>

  <h2>Work in Progress</h2>

  <p>
    There is still a lot left to do with this configuration, not the least of
    which involves detangling some of the configurations and significantly
    reducing the number of files by creating libraries out of what are presently
    subdirectories as well as eliminating spools of unnecessary code.
  </p>
</details>
<details>
  <summary>Gallery</summary>
  <h2>Gallery Coming Soon</h2>
</details>

<details>
  <summary>Inspirations</summary>
  <h2>Inspirations</h2>

  <h4>In No Particular Order</h4>
  <p>
    Here are some of the repositories I owe my eternal gratitude and
    appreciative awe to as these are the repositories that served as the models,
    code stock and examples that made Awesome's awful documentation more
    comprehensible and enabled me to achieve this level of functionality.
  </p>

  <ul>
    <li>
      <a href="https://github.com/JavaCafe01/awedots">Awedots by Javacafe</a>
    </li>

    <li>
      <a href="https://github.com/elenapan/dotfiles">dotfiles by elenapan</a>
    </li>

    <li>
      <a href="https://github.com/ODEX-TOS/tos-desktop-environment"
        >Whatever the hell it is Tom Meyers is actually working on</a
      >
    </li>

    <li>
      <a href="https://github.com/WillPower3309/awesome-dotfiles"
        >William McKinnon's AwesomeWM Configuration</a
      >
    </li>

    <li>
      <a href="https://github.com/manilarome/the-glorious-dotfiles"
        >manilarome's annoyingly titled dotfiles</a
      >
    </li>

    <li>
      <a href="https://github.com/szorfein/dotfiles">dotfiles of Szorfein</a>
    </li>

    <li><a href="https://github.com/BlingCorp/bling">The Bling Library</a></li>

    <li>
      <a href="https://github.com/Mofiqul/awesome-shell">awesome-shell</a>
    </li>

  </ul>
</details>
