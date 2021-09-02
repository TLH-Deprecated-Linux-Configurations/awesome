# Reuse and Modularity of Files

All in all, the intrepid will find that the files used here are relatively modular enough that they can be employed relatively easily outside of this configuration as desired. While this will not function as a library and turning it into one is a hassle I am not at present endeavoring to embark on the journey of, most components feature a local directory with their specific icons and other relevant files there within.

This began as a means of simplifying what was in the widget directory and has expanded from that point, primarily as a means of insuring that I knew where to look when problems arose in finishing up the configuration.

## The Big Exception

What is not modular about most/all of these files is that the typical import statements of the beginning of most files has been moved primarily into the `configuration/global_var` file as a means of simplifying writing the files. Meaning if you extract pieces of the file, unless you use a similar global variable scheme to me, will require adding these statements back into your files.

If you are doing all of your configuring on a vanilla vim install, this will be a bit more problematic (though less frustrating if you test with AWMTT) but any modern editor or syntax highlighter should be able to point out the undeclared globals in the files you adapt, which you can find references to in the global variables file of course, which if its another file in this configuration, its path will of course be there for your reference.
