# QuantumOptics.jl website

The whole **QuantumOptics.jl** website is created from different parts:
* **QuantumOptics.jl-examples** provides all the examples that are used and linked to in the documentation. They are created using jupyter notebooks and executed and converted to markdown with nbconvert. This markdown code is then copied to **QuantumOptics.jl-documentation**. Additionally, it provides the codesnippets that are used on the main page of the website.
* **QuantumOptics.jl-documentation** is written with markdown. [Documenter.jl](https://juliadocs.github.io/Documenter.jl) is used to integrate the docstrings from **QuantumOptics.jl** and to generate html code which includes the examples from **QuantumOptics.jl-examples**.
* **QuantumOptics.jl-benchmarks** generates json files containing the results of the benchmarks and provides the source code of the examples.

In this repository the following additional resources are defined:
* A common header used in every single page.
* A common navigation menu (on the top of each page).
* A common footer.
* The main page.
* **QuantumOptics.jl** code snippets which are shown in the main page.
* Citation page.
* Benchmark page presenting the data and source-code obtained from **QuantumOptics.jl-benchmarks**

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
* **Lato|Ubuntu+Mono**


A basic principle is that any code that is shown should be run and tested automatically before it is included.


## Directory layout

It is recommended to place all resources into the same directory, i.e.:

    |
    |--> ./QuantumOptics.jl
    |--> ./QuantumOptics.jl-examples
    |--> ./QuantumOptics.jl-documentation
    |--> ./QuantumOptics.jl-benchmarks
    |--> ./QuantumOptics.jl-website


## Software Requirements

* [Jekyll](https://jekyllrb.com)
* [Documenter.jl](https://juliadocs.github.io/Documenter.jl) (Can be installed with `julia> Pkg.add("Documenter")`)


## Build process

The complete build process of all resources and the website itself can be done with `julia makeall.jl`.

This script runs the following operations that can of course also be performed manually to obtain finer control over the build process:

* All git repositories are updated with `git pull`
* Convert notebooks in `QuantumOptics.jl-examples` into markdown files and copy them to `QuantumOptics.jl-documentation`.
* Build documentation in `QuantumOptics.jl-documentation` and copy them into `/src/documentation`.
* Copy results of benchmarks into `src/benchmark-data` and their source code into `src/_benchmarks_sourcecode`.
* Run code snippets (which then are shown in the main page) with `julia make.jl` in `src/_codesnippets`.

Finally, one uses jekyll to build website:
    * For development run jekyll interactively: `jekyll serve`
    * To just create it once: `jekyll build`
This will create the finished website in the `build` directory which then can be deployed to the server.
