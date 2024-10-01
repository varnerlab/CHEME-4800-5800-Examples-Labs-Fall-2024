
"""
    function build(model::Type{T}, data::Array{Int64,2}) -> T where T <: MyAbstractGraphModel

This function builds a graph model from an adjacency matrix.

### Arguments
- `model::Type{T}`: the type of the graph model to build. This is a subtype of `MyAbstractGraphModel`.
- `data::Array{Int64,2}`: the adjacency matrix.

### Returns
- `T`: the populated graph model.
"""
function build(model::Type{T}, data::Array{Int64,2}) where T <: MyAbstractGraphModel

    # build and empty graph model -
    graphmodel = model();
    number_of_nodes = size(data, 1); # see: https://docs.julialang.org/en/v1/base/arrays/#Base.size
    nodes = Dict{Int64, MyGraphNodeModel}(); # zero-based indexing
    edges = Dict{Tuple{Int64, Int64}, Int64}(); # zero-based indexing
    children = Dict{Int64, Set{Int64}}(); # zero-based indexing

    # TODO: populate the nodes dictionary - each node is a MyGraphNodeModel instance, data is the id
    # ...
    throw("Populate nodes dictionary not implemented yet!");

    # TODO: populate the edges dictionary - each edge is dictionary with keys Tuple{Int64, Int64} instance, data is the weight
    # ...
    throw("Populate edges dictionary not implemented yet!");

    # TODO: populate the children dictionary using the _children method - key is the node id, value is a set of node ids of children
    # ...
    throw("Populate children dictionary not implemented yet!");

    # add stuff to model -
    graphmodel.nodes = nodes;
    graphmodel.edges = edges;
    graphmodel.children = children;

    # return -
    return graphmodel;
end