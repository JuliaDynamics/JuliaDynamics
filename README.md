# JuliaDynamics website

In this repository the following additional resources are defined:
* A common header used in every single page.
* A common navigation menu (on the top of each page).
* A common footer.
* The main page.
* **JuliaDynamics.jl** code snippets which are shown in the main page.
* Citation page.

[Jekyll](https://jekyllrb.com) is used to generate the (static) website from all different parts.

The website itself uses the following technologies:

JavaScript libraries:
* **jquery.js**
* **Require.js**
* **Bootstrap.js** for the layout.
* **MathJax.js** for representing latex formulas.
* **highlight.js** to dynamically highlight the source code.
* **Chart.js** for the interactive benchmark plots.

CSS:
* **Bootstrap.css**
* **font-awesome**
* **Lato|Ubuntu+Mono** font

A basic principle is that any code that is shown should be run and tested automatically before it is included.

## Software Requirements

* [Jekyll](https://jekyllrb.com)

## Build process

The complete build process of all resources and the website itself can be done with `julia makeall.jl`.

This script runs the following operations that can of course also be performed manually to obtain finer control over the build process:

* Copy results of benchmarks into `src/benchmark-data` and their source code into `src/_benchmarks_sourcecode`.
* Run code snippets (which then are shown in the main page) with `julia make.jl` in `src/_codesnippets`.

Finally, one uses jekyll to build website:
    * For development run jekyll interactively: `jekyll serve`
    * To just create it once: `jekyll build`
This will create the finished website in the `build` directory which then can be deployed to the server.
