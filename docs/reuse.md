# Reuse and Modularity of Files

All in all, the intrepid will find that the files used here are relatively modular enough that they can be employed relatively easily outside of this configuration as desired. While this will not function as a library and turning it into one is a hassle I am not at present endeavoring to embark on the journey of, most components feature a local directory with their specific icons and other relevant files there within.

This began as a means of simplifying what was in the widget directory and has expanded from that point, primarily as a means of insuring that I knew where to look when problems arose in finishing up the configuration.

## The Big Exception

What is not modular about most/all of these files is that the typical import statements of the beginning of most files has been moved primarily into the `configuration/global_var` file as a means of simplifying writing the files. Meaning if you extract pieces of the file, unless you use a similar global variable scheme to me, will require adding these statements back into your files.
