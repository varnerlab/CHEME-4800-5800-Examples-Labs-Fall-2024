# Lab 5d: Let's build something close to Problem Set 2
In `lab 5d`, we will analyze a program that computes two-color one-dimensional cellular automata. 
The program is a modified version of what you will write in Problem Set 2. We'll explore two versions of this program, which can be executed by running the `runme_normal.jl` and the 
`runme_probabilistic.jl` scripts.

In this lab, we'll simulate [Rule 30](https://en.wikipedia.org/wiki/Rule_30), a one-dimensional cellular automaton rule introduced by Stephen Wolfram in 1983. It is particularly interesting because it produces complex, seemingly random patterns from simple, well-defined rules.

## Part 1: The `runme_normal.jl` script (30 minutes)
The `runme_normal.jl` script computes the next generation of a one-dimensional cellular automaton using
the standard Wolfram rules. In each simulation turn, all cells are allowed to update their state,  and the
order in which we process the cells is from left to right.  

This version of the program is deterministic and is __very similar__ to the one you will write in Problem Set 2.
* Execute the `runme_normal.jl` script and observe the output. You should see an image of the cellular automaton 
being written to the `figs` directory. Do you get the expected output? If not, what is the problem?
* Let's walk through the code and understand how the program works. The `runme_normal.jl` script is a driver that creates a rule model; we then simulate the rule and save the output to a file. Let's dig into this code and understand how it works.

## Part 2: The `runme_probabilistic.jl` script (20 minutes)
The `runme_probabilistic.jl` script computes the next generation of a one-dimensional cellular automaton using a probabilistic rule. In each turn of the simulation, each cell generates a random priority score, which is stored in
[a Priority Queue](https://juliacollections.github.io/DataStructures.jl/v0.12/priority-queue.html#:~:text=The%20PriorityQueue%20type%20provides%20a,keys%20can%20be%20changed%20efficiently.) data structure. The cell with the _lowest priority score_ (like golf) is processed first. Further, we may not allow all cells to update their state during each simulation turn.

This program version is non-deterministic and may generate different outputs each time it's run, depending on the parameters. 
* Execute the `runme_probabilistic.jl` script with the default inputs and observe the output. You should see an image of the cellular automaton being written to the `figs` directory. Do you get the expected output? If not, what is the problem?
* Let's walk through the code and understand how the program works. The `runme_probabilistic.jl` script is a driver that creates a rule model; we then simulate the rule and save the output to a file. Let's dig into this code and understand how it works.

