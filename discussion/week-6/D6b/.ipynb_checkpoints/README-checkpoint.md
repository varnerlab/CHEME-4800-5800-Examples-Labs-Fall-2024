# Lab 6b: Depth-First and Breadth-First Tree and Graph Traversal
Tree and graph traversal algorithms are fundamental to computer science. They are used to explore, search, and sort data. In this lab, you will implement two of the most common traversal algorithms: breadth-first search and depth-first search.
* Depth-first search (DFS) is a graph traversal algorithm that explores vertices by following a path as far as it can go before backtracking. DFS is often used to detect cycles in a graph, and it is also used to generate mazes and solve puzzles.
* Breadth-first search (BFS) is a graph traversal algorithm that explores vertices in the order of their distance from the source vertex, where distance is the minimum length of a path from the source vertex to the target vertex. BFS is complete and optimal for unweighted graphs, and it is often used to find the shortest path between two vertices.

## Prerequisites
We've encoded the two graphs as adjacency matrices in the `data` directory. Check out the `Testgraph-directed.dat` and `Testgraph-undirected.dat` files to see the adjacency matrices we will use to build the graphs for this lab. 

## Task 1: Build a Graph from an Adjacency Matrix
__Duration 30 min__: Complete implementation of the `build(model::Type{T}, data::Array{Int64,2})` method in the `src/Factory.jl` file. The method should build a graph from an adjacency matrix. The method should return a graph of type `T` where `T` is the type of the graph, i.e., a subtype of `MyAbstractGraphModel.`
* Test your implementation by running the `testme_task_1.jl` script. The script should run `18` tests, and all should pass before you move on to the next task.
* The solution to this task is in the `solutions` directory in the `Factory.jl` file.

## Task 2: Depth-First Search
__Duration 10 min__: Starting from the pseudocode in the lecture notes, analyze and modify the depth-first search algorithm in the `DFS` function in the `src/Traversal.jl` file. The function should take a graph, a source vertex, and a `visited::Set{Int64}` set as arguments and print out the vertices in the order they are visited.
* `Modification`: Check to see if a child vertex has been visited before recursively calling the `DFS` function; this is a modification to the pseudocode in the lecture notes.
* Test your `DFS` implementation by running the `runme_task_2.jl` script. The script should visit all the vertices (starting from `0`) in the graph specified by the `Testgraph-directed.dat` file. 
* The solution to this task is in the `solutions` directory in the `Traversal.jl` file.

## Task 3: Breadth-First Search
__Duration 10 min__: Starting from the pseudocode in the lecture notes, analyze the breadth-first search algorithm in the `BFS` function in the `src/Traversal.jl` file. The function should take a graph and a source vertex as input and print out the vertices in the order they are visited.
* `Modification`: Check if a child vertex has been visited before adding it to the node `queue`; this is a modification to the pseudocode in the lecture notes.
* Test your `BFS` implementation by running the `runme_task_3.jl` script. The script should visit all the vertices (starting from `0`) in the graph specified by the `Testgraph-directed.dat` file. 
* The solution to this task is in the `solutions` directory in the `Traversal.jl` file.
