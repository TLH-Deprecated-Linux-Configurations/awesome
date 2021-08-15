# Interface

<details><summary>Introduction</summary>
<p>
One particularly popular AwesomeWM configuration declares in a rebel tone that it is mouse drive, which puts it in opposition to the typical key driven pattern of usage that is employed by tiling window managers and the configurations of such found on Github. This configuration is not meant for puritans, it is meant for me and as I always say:
</p>
<blockquote> The only pattern is that there is no pattern</blockquote>
<p>
Which is absolutely the case with how I use my system, some days I want to use the keys, some days the mouse and the vast majority of days some constantly shifting mixture of the two. Sometimes I don't use the keys because I forgot the binding and have don't want to go through the process of looking it up (using <kbd>Mod4</kbd> + <kbd>F1</kbd>) so I opt instead to use the mouse, other times reaching for the mouse is too onerous or distracting so I hit the keys fast like a Nascar and go on with it.
</p>
<p>
So, the approach used in this configuration is to include both to the extent possible, which is not every single thing (for want of space on the bottom wibar if nothing else) but on the vast majority of the important stuff, like right and left wibars.
</p>
</details>

<details>
<summary>Wibars</summary>
<h3>Introduction</h3>
<p>
I used to use two wibars on screen at once, one on top and one bottom, but honestly that's a lot of screen space for wibars and it requires I use a lot more things to populate it, split the task list and tag list as well as other unpleasant ramifications prompting me to just use one wibar which I prefer on the bottom of the screen, revealed upon hovering the cursor towards the screen's bottom.
</p>
<h3>Bottom Bar</h3>
<p>The main system bar, you will be using the most often, is at the screen bottom and is hidden until you bring your cursor to that edge of the screen. On it you will find a usual selection of widgets arranged to highlight the configuration's unique aspects as well as still have the familiar feel you are used to from other systems</p>
<p>Buttons on the extreme left and right of the screen enable the two additional bars with respect to the edge of the screen trigger the same bar.</p>
<p>From the left, the next widget indicates which workspace, here called tag, you are presently on. Clicking the next letter in the sequence will bring you to that tag, for that screen as each screen has a different taglist. </p>
<p>Then are the window indicators displaying all open programs on that tag on that screen. Click one brings it into focus and right click will bring up a menu of all open windows to select between.</p>
<p>Then comes the wifi interface button, bluetooth interface button, battery applets if a battery is detected, layout selection button and clock. Clicking any of these will lead to an interface for the item to open up on screen in the ways you expect. The layout selector menu will vanish after a few seconds and is appearing for your ease of determining where in the layout list you are.</p>
<h3>Left Bar</h3>
<p>
Pressing the left arrow button on the bottom bar or <kbd>Mod4</kbd> + <kbd>g</kbd> will bring up the left wibar. On it are two sliders to control the volume and brightness. Below them are hardware monitors, displaying the relevant stats of the system's processor, memory, temperature, used storage, upload speed and download speed. Below that is an additional network widget, a button to open the screen configuration applet and a button triggering the exit screen. 
</p>
<h3>Right Bar</h3>
<p>The right bar is split into two separate functions, which can be switched between pressing the corresponding tab at the top of the bar. This bar is accessed by pressing the right arrown icon, or <kbd>Mod4</kbd> + <kbd>h</kbd></p>
<h4>Notifications</h4>
<p>The default starting tab for the right tab is a central location to view notifications after they have faded from your screen. Helpful if you miss the notification or want to review them in debugging contexts. </p>
<h4>Widgets</h4>
<p>This section contains standalone applets that perform small functions unworthy of more substantial treatment or redundant. They are links to social media sites, a COVID-19 tracker showing your nation's infections and deaths, a calculator and a calendar, which is also available if the user presses on the bottom bar's clock.</p>
</details>

<details>
<summary>System Dialogs</summary>
<h3>Screen Blur</h3>
<p>System dialogs, at least some of them, should also launch a screen dampener that makes the screen darker, allowing the user to better identify and focus on the launched dialog. This has rough edges still I need to iron out, which is done as they come up, so if you find one please open an issue of the Github repository so I know the situation and can address it. </p>
<h3>Exit Screen</h3>
<p>The exit screen is a system menu providing the user with options involving the power state of the system. Each of its options should be self explanatory, with only the last possibly being confusing. To be specific in that case, the BIOS option will restart the system and launch the hardware configuration options you likely had to utilize to boot a Linux distro on the machine initially (assuming a full install) </p>
</details>
<details>
<summary>Layouts</summary>
<h3>Introduction</h3>
<p>AwesomeWM is at its core a tiling window manager, it just adds in the best functionality of any tiling window manager I have used at handling windows that float. This being the case, it has several patterns intended to arrange the way new windows open on the screen, which in floating-only window management is not a concern. One of the achievements, to my mind, of this particular configuration is integrating several customized layouts into it that naturally fit into the overall layout system. 
Additionally, some of the default patterns are also enabled for those contexts when they are useful</p>

<h3>Split</h3>
<p>This is my most used layout personally, which has replaced the `mstab` layout from the `bling` library I was importing entirely for just that one function. Not finding the tab bar on top very useful (I have the taskbar for that) and somewhat obtuse for stylistic reasons, this was a welcome change eliminating a host of instabilities in the code base for this configuration.</p>
<p>This layout bisects the screen when a second window is open, then stacks additional windows on the right side. This I find is helpful to compare information from two screens without becoming microscopic if new windows open that prompt changes in responsiveness that may mean loosing your place and recognizes the reality **at extremely small sizes, no window is very useful**</p>
</details>
