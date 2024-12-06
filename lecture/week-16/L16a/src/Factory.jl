function _build(edgemodel::Type{MyGraphEdgeModel}, parts::Array{String,1}, id::Int64)::MyGraphEdgeModel
    
    # initialize -
    model = MyGraphEdgeModel(); # build an empty edge model
    
    # populate -
    model.id = id;
    model.source = parse(Int64, parts[1]);
    model.target = parse(Int64, parts[2]);
    model.weight = parse(Float64, parts[3]);

    # return -
    return model
end


# -- PUBLIC METHODS BELOW HERE ---------------------------------------------------------------------------------------- #
"""
    function build(model::Type{T}, edgemodels::Dict{Int64, MyGraphEdgeModel})::T where T <: MyAbstractGraphModel

This function builds a graph model from a dictionary of edge models.

### Arguments
- `model::Type{T}`: the type of graph model to build. Must be a subtype of `MyAbstractGraphModel`.
- `edgemodels::Dict{Int64, MyGraphEdgeModel}`: a dictionary of edge models. The keys are the edge ids, and the values are the edge models.

### Returns
- a populated graph model of type `T`.
"""
function build(model::Type{T}, edgemodels::Dict{Int64, MyGraphEdgeModel}) where T <: MyAbstractGraphModel

    # build and empty graph model -
    graphmodel = model();
    nodes = Dict{Int64, MyGraphNodeModel}();
    edges = Dict{Tuple{Int64, Int64}, Int64}();
    children = Dict{Int64, Set{Int64}}();

    # let's build a list of nodes ids -
    tmp_node_ids = Set{Int64}();
    for (_,v) ∈ edgemodels
        push!(tmp_node_ids, v.source);
        push!(tmp_node_ids, v.target);
    end
    list_of_node_ids = tmp_node_ids |> collect |> sort;

    # remap the node ids to a contiguous ordering -
    nodeidmap = Dict{Int64, Int64}();
    nodecounter = 1;
    for id ∈ list_of_node_ids
        nodeidmap[id] = nodecounter;
        nodecounter += 1;
    end

    # build the nodes models -
    [nodes[nodeidmap[id]] = MyGraphNodeModel(nodeidmap[id], rand() ≤ 0.5 ? 1 : -1) for id ∈ list_of_node_ids];

    # build the edges -
    for (_, v) ∈ edgemodels
        source_index = nodeidmap[v.source];
        target_index = nodeidmap[v.target];
        edges[(source_index, target_index)] = v.weight;
    end

    # compute the children -
    for id ∈ list_of_node_ids
        newid = nodeidmap[id];
        node = nodes[newid];
        children[newid] = _children(edges, node.id);
    end

    # add stuff to model -
    graphmodel.nodes = nodes;
    graphmodel.edges = edges;
    graphmodel.children = children;

    # return -
    return graphmodel;
end
# --- PUBLIC METHODS ABOVE HERE --------------------------------------------------------------------------------------- #