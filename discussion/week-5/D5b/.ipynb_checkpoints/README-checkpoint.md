# `Lab-5b`: Recursive Parser of Chemical Formulas
The objectives of `lab-5b` are to familiarize students with loading and parsing comma-separated value (CSV) files and developing a recursive descent parser to process the fields of the data records in the `CSV` file. In computer science, a [recursive descent parser](https://en.wikipedia.org/wiki/Recursive_descent_parser) is a kind of top-down parser that recursively walks down a collection of objects until all the objects in the collection have been processed.

In particular, we'll load and process chemical reaction records of the form: `R00267,C6H8O7+C21H29N7O17P3,C5H6O5+CO2+C21H30N7O17P3+H` where:

__Fields__:
* Field 1: The `name` field contains an identifier for the reaction string, e.g., `R00267.`
* Field 2: The `reactants` field contains the reaction string, e.g., `C6H8O7+C21H29N7O17P3`
* Field 3: The `products` field contains the reaction string, e.g., `C5H6O5+CO2+C21H30N7O17P3+H`

The reaction strings are in the [`data/Reactions.net`](data/Reactions.net) file.

## Tasks
A coworker has provided us with a `CSV` file (`data/Reactions.net`) containing chemical reaction strings and some logic to parse these reactions in the `src/Parser.jl` file. However, while the parser logic is complete (i.e., it runs without errors), it needs to be better documented, seems overly complicated, and our team needs to understand the behavior better.

We must analyze the parser and explain its behavior to our coworkers. 

1. __Duration 25 min__: Analyze and discuss the behavior of the `recursivesplit` and `_recursive_descent_parser` functions in `src/Parser.jl` using simple text inputs such as `Dog+Cat+Mouse+Lizard`. Run these simple cases using the `test_runme.jl` script.
    * To see what the parser is doing, add `@show` statements to the `recursivesplit` and `_recursive_descent_parser` functions to print out values. Alternatively, use the `debugger` to step through the code (see initial demo).
1. __Duration 15 min__: Finish the implementation of the `production_runme.jl` script to process the reaction strings.
    * The `production_runme.jl` script should load the `CSV` file, parse the reaction strings, and store the reaction information in a dictionary of `MyKeggReactionModel` objects (already implemented for you).
    * The `production_runme.jl` script should populate a unique `Array` of chemical compound strings, called `species_formula_array,` and a unique `Array` of reaction names, called `reaction_name_array.` Write code to populate these arrays.
    * __Challenge problem__: The `production_runme.jl` script should generate a $n \times m$ matrix $\mathbf{S}$, called the `stoichiometry_matrix`, where $n$ is the number of unique chemical compound strings and $m$ is the number of reaction strings. The elements $s_{ij}\in\mathbf{S}$ should encode the stoichiometric coefficient for species $i$ in reaction $j$. 
1. __Duration 10 min__: Can you feed reaction strings to the parser that will cause it to fail? If so, what are they? (Create a copy of the `Reactions.net` file, and put test case reactions in the new file.)
