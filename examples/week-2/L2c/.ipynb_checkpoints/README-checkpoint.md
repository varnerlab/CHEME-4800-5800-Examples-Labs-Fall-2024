# `Lab 2d`: Introduction to Structs, Conditional Evaluation and Testing
The objective of `lab-2d` is to give you practice with [Structs](https://docs.julialang.org/en/v1/base/base/#struct), [functions](https://docs.julialang.org/en/v1/base/base/#function) and [conditional evaluation statements, e.g., if-else statements](https://docs.julialang.org/en/v1/manual/control-flow/#man-conditional-evaluation) in [Julia](https://docs.julialang.org/en/v1/). 

* This will be the first lab where you will use a collection of `tests` to verify the correctness of your code. We'll use the `@assert macro` and the [Test module](https://docs.julialang.org/en/v1/stdlib/Test/) to write a test plan and test your code.

## Prerequisite 
Break up into teams of 2-3 people and take `5 min` to walk through all the files (starting with `Include.jl` in the `root` directory) in `Lab-2d`. At the end of `5 min`, we'll do a class Q&A to ensure everyone understands the purpose of each file.

## Tasks

### Testing
In `lab-2d`, we have included example tests designed to verify your code's correctness. 
* The `testme_assert.jl` file is an `old school` test plan that uses the `@assert macro` function to verify the correctness of your code. More details about the `@assert macro` can be found [here](https://docs.julialang.org/en/v1/base/base/#Base.@assert).
* The `testme_testset.jl` file is a more modern test plan that uses the `@testset` macro in combination with the [Test package](https://docs.julialang.org/en/v1/stdlib/Test/#Unit-Testing) to verify the correctness of your code. More details about the `@testset` macro can be found [here](https://docs.julialang.org/en/v1/stdlib/Test/#Test.@testset).

Let's run these tests together to verify the code's correctness. At this point, all tests should fail because you haven't implemented the `MyStudentModel` struct or the `build` and `find` functions. 
To run the tests, execute the following command in the `root` directory of `lab-2d`:

```julia
include("testme_testset.jl");
```

### Development (25 minutes on your own/with your team)
In `lab-2d`, create a collection of `MyStudentModels` instances and write a `find` function to locate the index of a particular student in our collection of students.

1. Implement a `MyStudentModel` struct which is `mutable` in the `Types.jl` file. `MyStudentModel` has a student id field (`sid::Int64`) and a netid field (`netid::String`). 
    * Implement a default constructor for `MyStudentModel` that initializes empty values for `sid` and `netid`. [See the notes for more information](https://varnerlab.github.io/CHEME-4800-5800-ComputingBook/unit-1-basics/types.html#composite-types)
1. `Debug` the `build(model::Type{MyStudentModel}; sid::Int64 = 0, netid::String="abc123")::MyStudentModel` function in `Factory.jl`
1. `Debug` the implementation of the `find` function in `Compute.jl`. The `find` function returns the index of the student object by matching the `sid` and `netid` fields with a test student object.
   * This logic makes use of the short-circuit `&&` operator in an `if-else` statement. For more information on `&&`, [check out the course notes](https://varnerlab.github.io/CHEME-4800-5800-ComputingBook/unit-1-basics/functions.html#if-else-conditional-statements) or the [Julia Short-Circuit conditional statement documentation](https://docs.julialang.org/en/v1/manual/control-flow/#Short-Circuit-Evaluation) 

In all cases, complete missing `docstrings` for each function and struct. For more information on the `docstring` syntax, see [here](https://docs.julialang.org/en/v1/manual/documentation/#Writing-Documentation).
