
"""
    function build(model::Type{T}, data::Array{Int64,2}) where T <: MyAbstractGraphModel

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
    nodes = Dict{Int64, MyGraphNodeModel}();
    edges = Dict{Tuple{Int64, Int64}, Int64}();
    children = Dict{Int64, Set{Int64}}();

    # build the nodes -
    [nodes[i] = MyGraphNodeModel(i) for i in 0:number_of_nodes-1];

    # build the edges -
    for i in 1:number_of_nodes
        for j in 1:number_of_nodes
            if data[i,j] != 0
                edges[(i-1, j-1)] = data[i,j];
            end
        end
    end

    # compute the children -
    for i ∈ 0:number_of_nodes-1
        node = nodes[i];
        children[i] = _children(edges, node.id);
    end

    # add stuff to model -
    graphmodel.nodes = nodes;
    graphmodel.edges = edges;
    graphmodel.children = children;

    # return -
    return graphmodel;
end