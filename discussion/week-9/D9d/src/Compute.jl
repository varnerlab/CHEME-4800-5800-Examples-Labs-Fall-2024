# --- PRIVATE METHODS BELOW HERE ------------------------------------------------------------------------------------------------ #


"""
    ⊗(a::Array{Float64,1},b::Array{Float64,1}) -> Array{Float64,2}

Compute the outer product of two vectors `a` and `b` and returns a matrix.

### Arguments
- `a::Array{Float64,1}`: a vector of length `m`.
- `b::Array{Float64,1}`: a vector of length `n`.

### Returns
- `Y::Array{Float64,2}`: a matrix of size `m x n` such that `Y[i,j] = a[i]*b[j]`.
"""
function ⊗(a::Array{Float64,1},b::Array{Float64,1})::Array{Float64,2}

    # initialize -
    m = length(a)
    n = length(b)
    Y = zeros(m,n)

    # main loop 
    for i ∈ 1:m
        for j ∈ 1:n
            Y[i,j] = a[i]*b[j]
        end
    end

    # return 
    return Y
end

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
