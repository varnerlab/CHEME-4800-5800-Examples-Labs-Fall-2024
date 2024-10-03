function _children(edges::Dict{Tuple{Int, Int}, Tuple{Float64, Float64, Float64}}, id::Int64)::Set{Int64}
    
    # initialize -
    childrenset = Set{Int64}();

    # Dumb implementation - why?
    for (k, _) ∈ edges
        if k[1] == id
            push!(childrenset, k[2]);
        end
    end

    # return -
    return childrenset;
end

function _convert(graphmodel::T) where T <: MyAbstractGraphModel

    # initialize -
    number_of_nodes = length(graphmodel.nodes)
    g = SimpleDiGraph(number_of_nodes);

    # add edges -
    for (k, v) ∈ graphmodel.edges
        add_edge!(g, k[1], k[2]);
    end
   
    return g;
end

"""
    function children(graph::T, node::MyGraphNodeModel) -> Set{Int64} where T <: MyAbstractGraphModel

This function returns the children of a node in a graph model.

### Arguments
- `graph::T`: the graph model to search. This is a subtype of `MyAbstractGraphModel`.
- `node::MyGraphNodeModel`: the node to search for children.

### Returns
- a set of children node ids.
"""
function children(graph::T, node::MyGraphNodeModel)::Set{Int64} where T <: MyAbstractGraphModel
    return graph.children[node.id];
end


"""
    function weight(graph::T, source::Int64, target::Int64) -> Float64 where T <: MyAbstractGraphModel

This function returns the weight of the edge between two nodes in a graph model.

### Arguments
- `graph::T`: the graph model to search. This is a subtype of `MyAbstractGraphModel`.
- `source::Int64`: the source node id.
- `target::Int64`: the target node id.

### Returns
- the weight of the edge between the source and target nodes.
"""
function weight(graph::T, source::Int64, target::Int64)::Float64 where T <: MyAbstractGraphModel   
    return graph.edges[(source, target)][1];
end

function flow(graph::T, distances::Dict{Int64, Float64}, previous::Dict{Int64, Union{Nothing,Int64}})::Array{Float64,1} where T <: MyAbstractGraphModel
    
    # initialize -
    number_of_nodes = length(graph.nodes);
    number_of_edges = length(graph.edges);
    flow = zeros(Float64, number_of_edges); # initialize the flow array with zeros

    # create a inverse edge dictionary -
    inversedgemap = Dict{Tuple{Int64, Int64}, Int64}();
    for (k, v) ∈ graph.edgesinverse
        inversedgemap[v] = k;
    end

    # iterate over the edges -
    nodes = range(2, stop=number_of_nodes) |> collect |> reverse;
    for node ∈ nodes
        p = previous[node]; # this is a connection
        i = inversedgemap[(p, node)]; # this is the edge id
        flow[i] = 1.0;
    end

    # return -
    return flow;
end
