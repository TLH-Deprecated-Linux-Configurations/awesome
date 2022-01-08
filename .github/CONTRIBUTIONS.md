# Contribution Guide

If you decide to help, first of all thank you. Your efforts are greatly
appreciated and I am happy to have the assistance.

This guide will give you a description of how I format the work done here and
then log that work, which would be helpful if you followed as well as I will
otherwise spend time doing this myself if you do not (but in all but the most
fringe cases, I will definitely merge your work).

## Files Themselves

[Please Refer Here for More Information About Styling Individual Files](/.github/DOCS/STYLE.md)
[Please Refer Here for Information about the Directory Structure](/.github/DOCS/DIRECTORY_STRUCTURE.md)

## Changes

All changes get logged to the CHANGELOG, as I remember to log them at least,
which is found [here](/.github/CHANGELOG.md). No particular method of changelog
is being used and I am open to suggestions as at present it is freeform notes
categorized into the following topics that are somewhat self-explanatory:
`ADDED`, `CHANGED`, `REMOVED` & `FIXED` with a final `NOTES` section where I
remind/inform my future self of the context and things I have tried but didn't
work out (which eats a lot of time sometimes as you probably can imagine)

---

## Comparison to AwesomeWM Contributions

Unlike Tom Meyers' work,
[available here for reference](https://github.com/ODEX-TOS/tos-desktop-environment/),
I do institute the same form of source code or documentation as the project that
this project configures. There are manifold reasons here, detailed below, though
I will first make a point of illuminating **that in the context of the window
manager itself, I think this method is highly functional and amazingly
effceint** and that **I have no problem whatsoever with that methodology but
seek just prefer doing my own thing for my ease of understanding the code
later**. `AwesomeWM` is a C+Lua project spread over numerous files and
maintained by numerous individuals. This project is a Lua (mostly) configuration
of `awesomewm` spread over numerous files but maintained solely by me, Thomas
Leon Highbaugh, thus there is a radically different pressure on it, hence me
eschewing the replication of the source projects comments or replication of its
documentation.

**Rationale for Not Using `AwesomeWM`'s Documentation/Commentary Style**

- **Different Consumption Patterns** - I am not writing modules intended for
  consumption via a window manager API, thus I need not separate out the
  parameters I am making available to potential users. Instead modules made
  locally are consumed locally, which I hope others find helpful and am even
  willing to help them adapt into their own configurations but not intended to
  be used the same way.
- **Goals** - My commentary is intended to make _it easier for me to read the
  code in a few months_, not generate documentation. Therefore it makes imposing
  the source project's commentary style on my writing onerous without obvious
  benefit. Meyers' work intends to achieve a more similar goal to the original
  project, for instance, so this is different for him. I totally get that, wish
  him the best in the process and deeply appreciate his work (in particular) but
  simply do not share that goal as well.
-

---

## Code of Conduct

I am not a babysitter, nor am I primary school teacher, both for good reasons.
While I refuse to adopt any heavy-handed hard-boiled ethical code for
contributing to this project or organization in general, I nonetheless will not
tolerate and will block anyone using this project to act unprofessionally _as I
deem it so_, being an average reasonable person with a thorough and fair set of
notions of what _unprofessional_ is and what it looks like when people are such.

If I must adopt a firm set of legal hyperbole for this purpose, I will, but
until then let this serve as an informal indictation of how unwilling I am to
deal with as much before I search out and institute a draconian set of artifical
ethics.

---
