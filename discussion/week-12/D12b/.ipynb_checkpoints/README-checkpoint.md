# Example: Monte-Carlo Tree Search 
Monte Carlo Tree Search (MCTS) is a robust heuristic search algorithm used in decision-making processes, particularly in game-playing artificial intelligence. It combines the random sampling of Monte Carlo methods with the strategic exploration of game trees, allowing it to efficiently navigate large search spaces and make intelligent decisions even in complex scenarios.

* Before we do anything, let's see how [the MCTS algorithm works](https://www.youtube.com/watch?v=UXW2yZndl7U).

### Test problem
Let's consider a test problem. Suppose you have a [roomba](https://www.irobot.com) that has finished cleaning the floor in your kitchen and needs to return to its charging station. However, between your kitchen and the charging station (home base and safety), there are one or more lava pits (destruction for the [roomba](https://www.irobot.com)). This is an example of a two-dimensional grid-world navigational decision task. 

To solve the Roomba problem using MCTS, we are going to invoke the `buy` side of `buy` versus `build` and use [the POMDPs.jl package](https://github.com/JuliaPOMDP/POMDPs.jl), which provides implementations for several different classes of problems in the [Markov Decision Process (MDPs)](https://en.wikipedia.org/wiki/Markov_decision_process) space.
* The problem setup is encoded in [the `problemsetup_with_reward_shaping.jl`](problemsetup_with_reward_shaping.jl) script. Let's take a look before executing the code in the `Roomba.jl` notebook.