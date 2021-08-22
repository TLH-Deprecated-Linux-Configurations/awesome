# Awesome Window Manager Configuration README.md

<!-- any screenshots go here with a heading -->

## Acknowledgements

- [Awedots by Javacafe](https://github.com/JavaCafe01/awedots)
- [dotfiles by elenapan](https://github.com/elenapan/dotfiles)
- [Whatever the hell it is Tom Meyers is actually working on](https://github.com/ODEX-TOS/tos-desktop-environment)
- [William McKinnon's AwesomeWM Configuration](https://github.com/WillPower3309/awesome-dotfiles)

## License

[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)
[MIT](https://choosealicense.com/licenses/mit/)

## Motivation

I have created this configuration (and borrowed bits and pieces of other configurations from all over the internet) primarily to achieve a functional workstation interface that is capable of running on anything from my high spec workstation to a Raspberry Pi4 while still not sacrificing on appearance and style. Overall, things I have tried to keep in mind and implement have been:

- Not keyboard or mouse centric - I have tried, though have not always noticed or been able, to implement everything as both a keybinding and as a button requiring only the mouse. This is because I am not consistent with these things, sometimes after already hitting a keyboard combo to rival mortal combat finishing moves, its easiest to just hit another one, other times I am using GIMP to tediously draw lines to finish out some image I am working on and keeping my hand on the mouse is better. It just depends! So I have tried to strip away the dogma of keyboard vs. mouse entirely and used a pattern that's more reflective of my usage that I think means a broad base of users will be able to use without needing to modify it too much (and will appreciate that the code is there and not causing lags).
- Transparency and Rounded Windows (As Needed) - Rounded corners I am dogmatic about, they just look a lot better than sharp ones and showcase how Linux _can_ get little details just right. Yet do all windows and applications need to blur their content with my wallpaper coming through, absolutely not! That is distracting and I don't add transparency to things like neovim or vscode, because I am working not drooling at my wallpaper. There's r/unixporn for that after all.
- **Keep It Organized, Stupid** - **KIOS** (said chaos) which is what you have if you forget what the acronym means. Having gone over a lot of very featureful code bases from which this has been perculated out of, I have come to really appreciate decent organization of a codebase. Consistency and clear ways of handling fringe cases are much better than a slipshod mess of files you can't even locate when you need them, let alone anyone else. We put these configurations on GitHub not just to brag, but to assist via examples, after all, so why not make it possible for potential users to use the thing by organizing the thing first and foremost.
- **File Headings Will Powers Style** - One really awesome trick I picked up came from Will McKinnon's configuration of Awesome. At the head of each file, he uses ASCII titles that make it remarkably easy to tell what you are looking at. I then extrapolated and started using comment bars to separate functional sections of the code so I could tell what specifically I am looking at and I hope this adds to its readability for those endeavoring to read and comprehend, if for no other reason than to serve as a less terse guide to some of the features of Awesome other than the abyss that is its API documentation. I figured a lot out the hard way, lucky you now you won't really have to. Thanks Will for inspiring me to take the quality of this code as serious as possible, absurdly by including file headers!
- **Useabilityporn > Unixporn** - These two unfortunately named subreddits are stand ins for the concepts that they represent. Posts on Unixporn, where the porn in the name came from, are supposed to be "beautiful" aka aesthetics are the primary concern. This certainly is a major step forward for Linux considering the defaults of many Desktop Environments are a little dated. Useabilityporn is more interested in the overall functionality of the system and how it contributes to a maximum overall workflow. This is where the power of Linux really is more interesting, as any Windows user could simply theme their start bar a bit and add a nice wallpaper and pass it off as a winning Unixporn post in reality if they hid the obvious give away logos and refused to give up their source code (like some do) but when what is being presented in the overall functionality of the system and not so much the appearance alone, the resulting code is going to naturally be of a higher and more useful quality (and hopefully come with less annoying wallpapers from crappy video game disappointments).
