# Lab 9d: Linear Programming and the Assignment Problem
An alien landed in my office, walked over to my desk and touched my face with it's strange bulbous glowing finger.
I blacked out. When I came to, I opened my eyes to find an alien sitting at my desk, its large, luminescent eyes focused intently on my computer screen. The creature was a vivid shade of teal, with four long fingers dancing over the keyboard. Its antennae twitched as it navigated through lines of code, completely absorbed.

I blinked in disbelief, still groggy. "What are you doing?", trying to make sense of the scene. The alien turned to me, its expression unreadable. "Optimizing maximum flow," it said in a voice that sounded like a chorus of chimes. "Your Earth problem requires efficiency." 

It finished the program and handed it to me. "You will need this," it said, before vanishing in a flash of light.

## Tasks
The program appears to be some type of linear programming code to solve the assignment problem. Break into teams and analyze the alien program and its associated data to figure out what the assignment problem is, how the program is solving it, and what the optimal solution is.

### Task 1: Understand problem setup (20 minutes)
Analyze (and execute) the `runme_build_system_contraints.jl` script to understand the problem setup:
```julia
include("runme_build_system_constraints.jl")
```
* What is in the `my_graphmodel` and  `my_nodecapacities` variables?
* What does the `b` variable represent?

### Task 2: Understand the alien program (20 minutes)
Analyze (and execute) the `runme_solve_assignment_problem.jl` script to understand the alien program:
```julia
include("runme_solve_assignment_problem.jl")
```
* What is the alien program doing? What is contained in the `primal_solution` variable?
* What is the optimal solution to the assignment problem?
* Does the optimal solution satisfy the constraints?