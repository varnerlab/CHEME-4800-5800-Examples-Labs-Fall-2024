# `Lab-3b`: Introduction to simple sorting algorithms using `for` loops
The objective of `lab-3b` is to give students practice with understanding and analyzing simple sorting algorithms that rely on `for` loops and conditional comparisons to order the elements of ordered collections such as [arrays](https://docs.julialang.org/en/v1/base/arrays/). In this lab, we will focus on two simple sorting algorithms:

* [Bubble sort](https://www.youtube.com/watch?v=uJLwnsLn0_Q) is a simple sorting algorithm that repeatedly steps through the arrays, compares adjacent elements, and swaps them if they are in the wrong order, i.e., if the first element is larger than the second element. The worst-case time complexity of [Bubble sort](https://www.youtube.com/watch?v=uJLwnsLn0_Q) is $\mathcal{O}(n^2)$, where $n$ is the number of elements in the unsorted list. 
* [Insertion sort](https://www.youtube.com/watch?v=nKzEJWbkPbQ) performs shift operations to sort a random list into ascending order. The worst-case time complexity of [Insertion sort](https://www.youtube.com/watch?v=nKzEJWbkPbQ) is $\mathcal{O}(n^2)$, where $n$ is the number of elements in the unsorted list.

Both of these approaches are much less efficient on large arrays than advanced algorithms such as [quicksort](https://en.wikipedia.org/wiki/Quicksort), [heapsort](https://en.wikipedia.org/wiki/Heapsort), or [merge sort](https://en.wikipedia.org/wiki/Merge_sort). However, they are simple to understand and implement and are useful for small data sets or data sets that are nearly sorted.

## Prerequisite
Watch the [Bubble sort video](https://www.youtube.com/watch?v=uJLwnsLn0_Q), then break up into teams of 2-3 people and take `5 min` to walk through all the files (starting with `Include.jl` in the `root` directory) in `Lab-3b`. 

### Tasks
* `TODO`: Once you understand all the codes (or at least the purpose of each file), take `15 min` to complete the implementation of the `bubble_sort` function in the `Compute.jl` file. Don't overthink this: it's only `3` lines of code! You can execute the `testme_bubble_sort.jl` script to test your implementation.
    * Is the `random_input_array` sorted after calling the `bubble_sort` function? 

```julia
include("testme_bubble_sort.jl")
```

* `TODO`: After completing the `bubble_sort` function, take `5 min` to implement the `bubble_sort!` function in the `Compute.jl` file. Hint: this is the same logic as the non-mutating version! To test your implementation, you can execute the `testme_mutating_bubble_sort.jl` script.
    * Is the `random_input_array` sorted after calling the `bubble_sort!` function? 

```julia
include("testme_mutating_bubble_sort.jl")
```

* `Fun time`: Let's listen to `bubble_sort` as it sorts the `random_input_array` by calling the `runme_bubble_sort_with_sound.jl` script: 

```julia
include("runme_bubble_sort_with_sound.jl")
```
