# `Lab 2b`: Introduction to Functions, Scope and Error Handling
In `Lab-2b`, we will introduce the concept of a `function` in Julia, see how our codes will be organized, and discuss concepts such as `scope` and `error handling.` 

## Prerequisite 
Break up into teams of 2-3 people and take `5 min` to walk through all the files (starting with `Include.jl` in the `root` directory) in `Lab-2b`. At the end of `5 min`, we'll do a class Q&A to ensure everyone understands the purpose of each file.

## Tasks
__Task 1__: Open a new terminal window in `VSCode`, and start the `Julia REPL` from the `root` directory of the `Lab-2b` using the `julia --project=.` command. At the `julia>` prompt, include the `Include.jl` file using the `include(...)` function: 

```julia
include("Include.jl");
```

_Discussion_: You should see an error message called a `stack trace.` It gives us a lot of information about what happened, where the error occurred, and potentially how to fix it.
* How do we fix this? Enter the package manager by typing `]` at the `julia>` prompt, and then add the required packages (or directly follow the instructions in the `stack trace`).

__Task 2__: Create an instance of a `Normal` distribution with `μ = 0.25` and `σ = 2.5` using the `build(...)` function. Store the instance in a variable called `d`:

```julia
d = build(Normal, μ = 0.25, σ = 2.5);
```

For more information on the `Normal` distribution, see [here](https://juliastats.org/Distributions.jl/stable/univariate/#Distributions.Normal).
* `Check`: What is the type of `d`? Use the [typeof function](https://docs.julialang.org/en/v1/base/base/#Core.typeof) to check the type of `d`.
* `Error case`: What happens if you try to create an instance of a `Normal` distribution with `μ = 0.25` and `σ = -2.5`? Try it and see what happens.

__Task 3__: Generate `number_of_samples = 100` samples from the `Normal` distribution `d` by issuing the command:
    
```julia
x = sample(d);
```

* `Fun`: Visualize the samples `x` using the [histogram function](https://docs.julialang.org/en/v1/stdlib/Statistics/#Statistics.histogram) from the [UnicodePlots package](https://github.com/JuliaPlots/UnicodePlots.jl.git) (old school text plotting). 
    * Change the number of samples in the sample function and the number of bins in the histogram using the `nbins` keyword argument.
* `Check`: What is the type of `x`? Use the [typeof function](https://docs.julialang.org/en/v1/base/base/#Core.typeof) to check the type of `x.`
* `Error case`: What happens if we pass in a negative value for the `number_of_samples` argument? Try it and see.
* `Error case`: What happens if we pass in a non-integer value for the `number_of_samples` argument? Try it and see.
* `Error case`: What happens if we pass in a non-numeric value for `number_of_samples`? Try it and see what happens.

_Discussion_: Let's explore some of the properties of the `x` variable, and the `sample(...)` function:
* How `big` (number of elements) is `x`? Use the [length function](https://docs.julialang.org/en/v1/base/strings/#Base.length-Tuple{AbstractString}) to check its size. 
* How `big` (how much memory in bytes) does `x` occupy? Use the [sizeof function](https://docs.julialang.org/en/v1/base/base/#Base.sizeof-Tuple{Type}) to check its memory footprint. Do you think this makes sense?
    * Let's get a second opinion; use the [varinfo function](https://docs.julialang.org/en/v1/stdlib/InteractiveUtils/#InteractiveUtils.varinfo) to summarize the variables in the current `scope`.
* Why didn't we have to (initially) pass in a value for the `number_of_samples` argument in the `sample(...)` function?

__Task 4__: Compute the sample mean $\hat{\mu}$ and sample standard deviation $\hat{\sigma}$ of the `x` variable using the [mean](https://docs.julialang.org/en/v1/stdlib/Statistics/#Statistics.mean) and [std](https://docs.julialang.org/en/v1/stdlib/Statistics/#Statistics.std) functions, exported from the [Statistics module](https://docs.julialang.org/en/v1/stdlib/Statistics/#Statistics).
* `Check`: Was the sample mean $\hat{\mu}$ (and sample standard deviation $\hat{\sigma}$) close to the true mean $\mu$? and standard deviation $\sigma$?
    * If not, how can we fix this?
* `Question`: Why didn't we download and install the `Statistics` module, e.g., using [Pkg](https://pkgdocs.julialang.org/v1/) before issuing the `using Statistics` command in the `Include.jl` file?
    * Check out the [Julia standard library](https://docs.julialang.org/en/v1/).
