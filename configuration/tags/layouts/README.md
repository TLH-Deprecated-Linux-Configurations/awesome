# Configuration/Tags/layouts

These files create the custom layouts I use locally, as inspired by the noted
authors of other projects.

## FAQ About Custom Layout

`why not just use the original project it came from as a submodule or library`

- there are a few layers to this, so bare with me:
  - I don't want the additional complexity - bling is an awesome library full of
    great ideas and innovations, but frankly I don't want to have a split window
    without the top 40px for a `tabbar` I won't even use (even if it worked
    right) and would not need due to the tasklist on the bottom panel that is
    styled in a different way compared to other aspects of my UI and another
    source of headaches, all tied into the mbox layout. Though note, the split
    theme is more inspired by the `awesome-dovetail` project in its source code.
  - I have my own approach to certain key details of things that I like better,
    that's why I do it that way. This method mitigates much of the quirks that
    would drive me crazy about other approaches, so if I have cut those out of
    the rest of the configuration, doesn't it only make sense to do that here
    too?
  - In order to better understand/remember how code is working, which makes
    maintaining it later significantly easier, I like to use a specific system
    where I break up chunks of lua with three comment bars and (hopefully)
    describe it in a comment before the chunk begins. In order to know if a
    problem arises from a layout, it helps to have the layout's code also in
    conformance with that system.
- `How do I learn how to do this (or practically anything in Awesome)`

  - There is a pull request somewhere with a guide on layout creation that
    hasn't been added to Awesome's source code for a reason beyond me (or in
    reality, because there needs to be 2 approvals to merge code, when it
    probably should be 1 given the incredible time constraints on developers
    solving other problems than the ones the pull requests are solving).
  - However, the way I did this and the way to do anything with awesome is
    itself a multipart answer but is in essence:
    - **look at other configurations, pull ideas and code from them and make it
      work with your configuration**
    - **look at the documentation, see if anything is present there that would
      help** - but don't hold your breath as its probably not.
    - **look at the source code relating to the functionality you are working
      with, the comments sometimes offer better cues and the way it is written
      itself may provide you inspiration**
    - **ask the r/awesome subreddit, the devs check it periodically and are
      pretty helpful**.
  - **look at the guides for lua in general available, many other configurations
    are plagued by issues that were they to go over these would be solved**.

- `Will you make this available in a library?` Maybe in the future I will make a
  library out of some of the functionality I use that is seemingly missing
  elsewhere, but for now please just go ahread copy-paste the code into your own
  configuration. Maybe mention where you got it in the header of the file if you
  would be so kind but this is on Github for a reason so feel free.
