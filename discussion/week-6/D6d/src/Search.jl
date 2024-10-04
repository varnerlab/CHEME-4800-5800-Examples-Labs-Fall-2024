
"""
    function _search(graph::T, start::MyGraphNodeModel, algorithm::DikjstraAlgorithm) where T <: MyAbstractGraphModel

This function performs a single source shortest path calculation on a graph model using the Dikjstra algorithm.

### Arguments
- `graph::T`: the graph model to search. This is a subtype of `MyAbstractGraphModel`.
- `start::MyGraphNodeModel`: the node to start the search from.
- `algorithm::DikjstraAlgorithm`: the algorithm to use for the search {DikjstraAlgorithm | BellmanFordAlgorithm}.

### Returns
- a tuple of two dictionaries: the first dictionary contains the distances from the starting node to all other nodes, and the second dictionary contains the previous node in the shortest path from the starting node to all other nodes.
"""
function _search(graph::T, start::MyGraphNodeModel, algorithm::DikjstraAlgorithm) where T <: MyAbstractGraphModel
    
    # initialize -
    distances = Dict{Int64, Float64}();
    previous = Dict{Int64, Union{Nothing,Int64}}();
    queue = PriorityQueue{Int64, Float64}(); # exported from DataStructures.jl

    # set distances and previous -
    distances[start.id] = 0.0; # distance from start to start is zero
    for (k, _) ∈ graph.nodes # what is this?
        if k != start.id
            distances[k] = Inf;
            previous[k] = nothing;
        end
        enqueue!(queue, k, distances[k]); # add nodes to the queue
    end

    # main loop -
    while !isempty(queue) # process nodes in the queue until it is empty (!isempty(queue) is the same as isempty(queue) == false)
        u = dequeue!(queue);
        mychildren = children(graph, graph.nodes[u]);

        for w ∈ mychildren # iterate over the children set of the current node
            alt = distances[u] + weight(graph, u, w); # distance to u so far + weight of edge from u to w
            if alt < distances[w] # Wow! the distance to w is less than the current best distance to w
                distances[w] = alt;
                previous[w] = u;
                queue[w] = alt;
            end
        end
    end

    # return -
    return distances, previous;
end

"""
    function _search(graph::T, start::MyGraphNodeModel, algorithm::BellmanFordAlgorithm) where T <: MyAbstractGraphModel

This function performs a single source shortest path calculation on a graph model using the Bellman Ford algorithm.

### Arguments
- `graph::T`: the graph model to search. This is a subtype of `MyAbstractGraphModel`.
- `start::MyGraphNodeModel`: the node to start the search from.
- `algorithm::BellmanFordAlgorithm`: the algorithm to use for the search {DikjstraAlgorithm | BellmanFordAlgorithm}.

### Returns
- a tuple of two dictionaries: the first dictionary contains the distances from the starting node to all other nodes, and the second dictionary contains the previous node in the shortest path from the starting node to all other nodes.
"""
function _search(graph::T, start::MyGraphNodeModel, algorithm::BellmanFordAlgorithm) where T <: MyAbstractGraphModel

    # initialize -
    distances = Dict{Int64, Float64}();
    previous = Dict{Int64, Union{Nothing,Int64}}();
    nodes = graph.nodes;
    number_of_nodes = length(nodes);

    # TODO: implement the Bellman Ford algorithm here
    # throw("Ooops! The Bellman Ford algorithm is not implemented yet!");

    # check fo
    return distances, previous;
end


# ------ PUBLIC METHODS BELOW HERE -------------------------------------------------------------------------------- #
"""
    computeshortestpaths(graph::T, start::MyGraphNodeModel, 
        algorithm::MyAbstractGraphSearchAlgorithm) where T <: MyAbstractGraphModel

The function computes the shortest paths from a starting node to all other nodes in a graph model. 

### Arguments
- `graph::T`: the graph model to search. This is a subtype of `MyAbstractGraphModel`.
- `start::MyGraphNodeModel`: the node to start the search from.
- `algorithm::MyAbstractGraphSearchAlgorithm`: the algorithm to use for the search.

### Returns
- a tuple of two dictionaries: the first dictionary contains the distances from the starting node to all other nodes, and the second dictionary contains the previous node in the shortest path from the starting node to all other nodes.
"""
function computeshortestpaths(graph::T, start::MyGraphNodeModel, 
    algorithm::MyAbstractGraphSearchAlgorithm) where T <: MyAbstractGraphModel
    return _search(graph, start, algorithm);
end
# ------ PUBLIC ABOVE BELOW HERE ---------------------------------------------------------------------------------- #