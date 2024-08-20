# `Lab-3d` Introduction to delimited file parsing operations for numerical and textual data
`Lab 3d` will give students practice with understanding and analyzing simple file parsing operations that rely on the `open-do` pattern that we introduced in the lecture.

## Data
To get a better idea of the performance of the [Bubble Sort algorithm](https://en.wikipedia.org/wiki/Bubble_sort), I used the [BenchmarkTools.jl package](https://github.com/JuliaCI/BenchmarkTools.jl) to do some benchmarking of the time required to sort a random array of integers. We collected the `mean` and `standard deviation` of the time needed to sort a random array of integers as a function of the length of the vector. We stored this data in the [Bubblesort.csv](data/Bubblesort.csv) file, which is an example `comma-separated value` file.

## Prerequisite 
Break up into teams of 2-3 people and take `5 min` to walk through all the files (starting with `Include.jl` in the `root` directory) in `Lab-3d`. At the end of `5 min`, we'll do a class Q&A to ensure everyone understands the purpose of each file.

## Tasks
Let's use three different methods to read the data in the [Bubblesort.csv](data/Bubblesort.csv) file and analyze the pros and cons of each approach. 

### Method 1: The `simplereadfile` function.
In `lab-3d`, we have implemented a `simplereadfile` function in the `Files.jl` file that uses the `open-do` pattern to read the [Bubblesort.csv](data/Bubblesort.csv) file. Execute the the `runme_simple_read.jl` script:

```julia
include("runme_simple_read.jl")
```

* What is the data type returned by the `simplereadfile` function?
* Can you break this function, e.g., by passing a file that doesn't exist? 
* What are the `pros` and `cons` of this approach?

### Method 2: The `betterreadfile` function.
In `lab-3d`, we have implemented a `betterreadfile` function in the `Files.jl` file that uses the `open-do` pattern to read the [Bubblesort.csv](data/Bubblesort.csv) file. However, the data gets returned in a different format in this case. Execute the `runme_better_read.jl` script:

```julia
include("runme_better_read.jl")
```

* What is the data type returned by the `betterreadfile` function?
* Can you break this function, e.g., by passing a file that doesn't exist or messing around the arguments?
* What are the `pros` and `cons` of this approach?

### Method 3: The `bestreadfile` function.
In `lab-3d`, we have implemented a `bestreadcsvfile` function in the `Files.jl` file that uses the [CSV.jl package](https://github.com/JuliaData/CSV.jl) to read the [Bubblesort.csv](data/Bubblesort.csv) file. This method returns the data as a `DataFrame` object, a special type exported from the [DataFrames.jl package](https://dataframes.juliadata.org/stable/). Execute the
`runme_best_read.jl` script:

```julia
include("runme_best_read.jl")
```

* What is the data type returned by the `betterreadfile` function?
* Can you break this function, e.g., by passing a file that doesn't exist or messing around the arguments?
* What are the `pros` and `cons` of this approach?
