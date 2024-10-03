# Lab 6d: Bellman-Ford Algorithm for Single-Source Shortest Paths
This lab will introduce you to [the Bellman-Ford algorithm](https://en.wikipedia.org/wiki/Bellman–Ford_algorithm) for finding the shortest path from a single source vertex to all other vertices in a weighted graph. 

The [Bellman-Ford algorithm](https://en.wikipedia.org/wiki/Bellman–Ford_algorithm) is a graph search algorithm that can search graphs with negative edge weights. However, it is slower than Dijkstra's algorithm. Bellman-Ford has a time complexity of $\mathcal{O}(|\mathcal{V}|\cdot|\mathcal{E}|)$, where $|\mathcal{V}|$ is the number of vertices and $|\mathcal{E}|$ is the number of edges in the graph.

## Task 1: Understanding the Bellman-Ford versus Dikstra's Algortihm (15 minutes)
Before implementing the Bellman-Ford algorithm, let's take a few minutes to understand how it works and how it differs from [Dikstra's algorithm](https://en.wikipedia.org/wiki/Dijkstra's_algorithm). The pseudocode for the Bellman-Ford algorithm is provided in the lecture slides. However, [let's watch a video that explains the algorithm in more detail before jumping into the code](https://www.youtube.com/watch?v=j0OUwduDOS0).

## Task 2: Implement Bellman-Ford (15 minutes)
In this task, implement [the Bellman-Ford algorithm](https://en.wikipedia.org/wiki/Bellman–Ford_algorithm) to find the shortest path from a single source vertex to all other vertices in a weighted graph. Use the pseudocode provided in the lecture slides to guide your implementation. 
* `Update` the `_search` method in the `src/Search.jl` file with your implementation of Bellman-Ford. Check out the solution in the `solutions` folder if you get stuck.

## Task 3: Test Your Implementation (20 minutes)
In this task, we'll test your implementation of [the Bellman-Ford algorithm](https://en.wikipedia.org/wiki/Bellman–Ford_algorithm) using a test case that is similar to problem set 3 (PS3).

<div>
    <center>
        <img src="figs/Fig-BalancedSchematic-PeopleTasks-Problem-WB.svg" width="480"/>
    </center>
</div>

Imagine you (node `1`) are in charge of allocating workers to tasks, i.e., faculty to courses. You have a list of faculty and a list of courses. While each faculty member can teach any course, they have a preference for each course reflected in the edge weight connecting faculty to classes. 
* The weight of the edge connecting faculty `i` to course `j` is the cost of assigning faculty `i` to course `j.` If $w_{ij} < 0$, it means that faculty `i` prefers course `j`. If $w_{ij} > 0$, it means that faculty `i` dislikes course `j`. If $w_{ij} = 0$, it means that faculty `i` is indifferent to course `j.`
* At most, one faculty member can be assigned to each course.

We want to assign faculty members to courses in a way that minimizes the cost of the assignment. Later, we'll solve this problem using [Linear Programming](https://en.wikipedia.org/wiki/Linear_programming). However, let's try to solve this problem using [the Bellman-Ford algorithm](https://en.wikipedia.org/wiki/Bellman–Ford_algorithm) and see what happens.

Let's specify different weights for the edges connecting faculty to courses, solve the problem, and look at the solution. The graph and weights are specified in the `data/Bipartite.edgelist` file. The file has the following format:
* Each record has the fields: `source,` `target,` `cost,` `lb capacity,` `ub capacity`

Execute the `runme_balanced_bellmanford.jl` script to solve the problem and visualize the results:

```julia
include("runme_balanced_bellmanford.jl")
```

