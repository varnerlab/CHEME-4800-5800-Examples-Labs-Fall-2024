
function _search(graph::T, start::MyGraphNodeModel, algorithm::DikjstraAlgorithm) where T <: MyAbstractGraphModel
    
    # initialize -
    distances = Dict{Int64, Float64}();
    previous = Dict{Int64, Union{Nothing,Int64}}();
    queue = PriorityQueue{Int64, Float64}();

    # set distances and previous -
    distances[start.id] = 0.0;
    for (k, _) ∈ graph.nodes
        if k != start.id
            distances[k] = Inf;
            previous[k] = nothing;
        end
        enqueue!(queue, k, distances[k]);
    end

    # main loop -
    while !isempty(queue)
        u = dequeue!(queue);
        mychildren = children(graph, graph.nodes[u]);

        for w ∈ mychildren
            alt = distances[u] + weight(graph, u, w);
            if alt < distances[w]
                distances[w] = alt;
                previous[w] = u;
                queue[w] = alt;
            end
        end
    end

    return distances, previous;
end

function _search(graph::T, start::MyGraphNodeModel, algorithm::BellmanFordAlgorithm) where T <: MyAbstractGraphModel
    throw(ArgumentError("The Bellman-Ford algorithm is not implemented yet"));
end


# ------ PUBLIC METHODS BELOW HERE -------------------------------------------------------------------------------- #
"""
    computeshortestpaths(graph::T, start::MyGraphNodeModel, 
        algorithm::MyAbstractGraphSearchAlgorithm) where T <: MyAbstractGraphModel
"""
function computeshortestpaths(graph::T, start::MyGraphNodeModel, 
    algorithm::MyAbstractGraphSearchAlgorithm) where T <: MyAbstractGraphModel
    return _search(graph, start, algorithm);
end
# ------ PUBLIC ABOVE BELOW HERE ---------------------------------------------------------------------------------- #