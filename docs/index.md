# AwesomeWM Configuration Wiki

This configuration is the showcase and center that the Electric Tantra Linux system is situated around. Being the same configuration I use extensively, as well as organically, that I've tired of reassembling just picture so I've created an ISO to streamline the process, serving in its capacity in that perfect union of Shiva and Shakti that is the Electric Tantra. While words cannot encompass the meaning of this most secret of tantras the seeker must discover within, the rest of the project lends itself to documentation easily enough so this wiki will serve as diamond vimana for such.

<details style="width: 45%; float:left;" ><summary> About the Documentation Wiki </summary>
<p>This wiki should help you understand exactly how to utilize the window manager that is the underpinning of the Electric Tantra Linux, including a brief overview of the concepts that underlie its features and functionalities that I found it necessary to first understand in writing the configuration itself. This will not be an exhaustive treatment of the subject as you can find reference manuals for those purposes easily enough nor will every feature find its way into these documents as the configuration is in a state of flux, that I have tried to constrain myself from altering too much too quickly but am human and prone to error so sometimes wiki treatment of somethings will be overlooked. I apologize in advance. </p>

<p>The coming pages will introduce concepts that are important to understand in order to appreciate what this particular configuration is doing and why. I will assume you have a basic knowledge of Linux, but will still define certain key terms for the purposes of insuring the audience and I are on the same page regarding them. </p>
</details>

<details style="width: 45%; float:left;"><summary> About the Author </summary>
<p>
My name is Thomas Leon Highbaugh, the author of the Electric Tantra Linux and a Linux nerd of the worst sort who enjoys nothing more than making the sorts of attractive desktop layouts that I always wished were available on paid OSes I used before only to have found them here, in the Linux scrap heap. I also work in web development, employing the same questionable taste in making websites, which I make entirely on Linux in an environment configured to my precise taste and using the tools with configurations available to you on GitHub because its not like hiding those configurations would do anything but make it easier to loose them (and cause open source is good mmmkay?). 
 </p>

</details>

<details style="width: 45%; float:left;"><summary> Influences </summary>
<p>
Anyone embarking on the journey up Mordor that is AwesomeWM configurations should consider checking out the following configurations, if not using one as the basis for their configuration as is standard practice within the awfully named `ricing` community. The best configuration I have ever seen, the <b>TDE</b> one listed first below, is heavily itself based on the <b>Glorious Dotfiles</b>, there is no shame in adapting code to your needs just give the authors some credit. Below I have listed all of the configurations I have taken inspiration from, with some serving to contribute code to this project. Most importantly has been <b>TDE</b> which I have used as a basis and chiseled away at it like a block of granite, revealing my own configuration (which features legacy code from older variants of my configuration too and bits from other configurations listed below). This serves to satisfy any attribution required by the licenses associated with each, since I am not making money on this I doubt anyone plans to sue me over not including the entire license which is redundant and annoying in my humble opinion (except within the `lib` directory I included Meyers license since the code there I have not substantially modified and is his code as-is).
 </p>

 <h3>Primary Influences</h3>
<ul>
<li><b>TDE</b> - Tom Meyer's awesome configuration that served as the basis/most major of influences on the present configuration. Absolutely most functional and fully featured Awesome configuration available on Github, even though it has the most annoying logo I have ever seen (its painful seriously). Overall this is the most functional out-of-the-box configuration with the highest code quality of any I have used, even if I differ in my approach to several aspects of the code and have had a hell of a time adapting from it. Interestingly this is the only one that has any notion of a settings app, only one that interacts with `.conf` files as stores of the settings (which has been a real pain to strip out of the configuration because I know what settings I want for my system, I don't often change them but for a more general system it makes total sense to have) and overall, the comments are the most useful of any I have seen (they actually describe what is going on, what a thought).</li>
<li><b>Glorious Dotfiles</b> - inherited from Meyer's work. Great modular widgets and modules, terrible UI and questionable choices (titlebars on the left? really?). This configuration has been the source of considerable amounts of code for the other AwesomeWM configurations I have taken inspiration from, you might think of it as a progenitor to the others or that alot of the others are derivative configurations from this base. However, that might be understating the amount of work that even starting with this code base, the other authors and myself have had to do to get the code from this configuration to be useful on other systems than the original authors.  </li>

<li><b>Elenapan</b> - a great example of what can be done with awesome. Subdirectories are named some goofy things, but the code quality is generally high and the design of the thing looks the best of any awesome configuration overall. The author is also really responsive if you catch her on Reddit, and is very humble making it easy to communicate with her if you have questions about how her configuration works or want advise. Out of all of the configurations listed, she is probably the easiest to talk to for such purposes, somewhat like a college professor only polite. </li>
</ul>
<h3>Honorable Mentions</h3>
<ul>
<li><b>Awesome-Shell</b>  - recreation of ukde's look that effectively utilizes a single panel like this configuration</li>
<li><b>JavaCafe's Awesome</b> - I really like the appearance of this configuration, while differing with its author about some critical under-the-hood design decisions. He has recently moved to using NixOS, meaning his configurations are shifting towards Nix configurations entirely, so we will see how long until he so transitions his awesomewm configuration(which he says he will not be doing). His configuration, like TDE and Awesome Shell, all owe no small thanks to the Glorious Dotfiles configuration (as does this configuration obviously). </li>
</ul>
</details>

<div style="width: 45%; float:right; margin-left: 2.5%;">
<h2>Table of Contents</h2>
<ul>
<li><a href="./definitions.md">Definitions: Starting From A Common Point of Reference</a></li>
<li><a href="./usage.md">Usage</a></li>
<li><a href="./screen.md">Screen Elements</a></li>
<li><a href="./libraries.md">Libraries</a></li>
<li><a href="./externals.md">External Program Dependencies</a></li>
</ul>
</div>
