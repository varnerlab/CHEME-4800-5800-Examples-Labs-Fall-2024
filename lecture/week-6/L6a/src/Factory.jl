function build(edgemodel::Type{MyGraphEdgeModel}, data::NamedTuple)::MyGraphEdgeModel
    
    # get data from the tuple -
    parts = data.parts;
    id = data.id;

    # initialize -
    model = edgemodel(); # build an empty edge model
    
    # populate -
    model.id = id;
    model.source = parse(Int64, parts[1]);      # source id
    model.target = parse(Int64, parts[2]);      # target id
    model.weight = parse(Float64, parts[3]);    # edge weight

    # return -
    return model
end

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
    [nodes[nodeidmap[id]] = MyGraphNodeModel(nodeidmap[id]) for id ∈ list_of_node_ids];

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

"""
    function build(model::Type{SimpleGraph}, edgemodels::Dict{Int64, MyGraphEdgeModel}) -> SimpleGraph
"""
function build(model::Type{SimpleGraph}, edgemodels::Dict{Int64, MyGraphEdgeModel})::SimpleGraph

    # initialize 
    tmp_node_ids = Set{Int64}();
    for (_,v) ∈ edgemodels
        push!(tmp_node_ids, v.source);
        push!(tmp_node_ids, v.target);
    end
    list_of_node_ids = tmp_node_ids |> collect |> sort;
    
    # remap the node ids -
    nodeidmap = Dict{Int64, Int64}();
    nodecounter = 1;
    for id ∈ list_of_node_ids
        nodeidmap[id] = nodecounter;
        nodecounter += 1;
    end
    
    # let's build a list of nodes ids -
    tmp_edge_list = Array{Tuple{Int64, Int64},1}();
    for (_,v) ∈ edgemodels
        
        source_index = nodeidmap[v.source];
        target_index = nodeidmap[v.target];
        push!(tmp_edge_list, (source_index, target_index));
    end
    el = Edge.(tmp_edge_list);

    # return -
    return model(el);
end

function build(model::Type{SimpleDiGraph}, edgemodels::Dict{Int64, MyGraphEdgeModel})::SimpleDiGraph

    # initialize
    tmp_node_ids = Set{Int64}();
    for (_,v) ∈ edgemodels
        push!(tmp_node_ids, v.source);
        push!(tmp_node_ids, v.target);
    end
    list_of_node_ids = tmp_node_ids |> collect |> sort;
    
    # remap the node ids -
    nodeidmap = Dict{Int64, Int64}();
    nodecounter = 1;
    for id ∈ list_of_node_ids
        nodeidmap[id] = nodecounter;
        nodecounter += 1;
    end
    
    # let's build a list of nodes ids -
    tmp_edge_list = Array{Tuple{Int64, Int64},1}();
    for (_,v) ∈ edgemodels
        
        source_index = nodeidmap[v.source];
        target_index = nodeidmap[v.target];
        push!(tmp_edge_list, (source_index, target_index));
    end
    el = Edge.(tmp_edge_list);

    # return -
    return model(el);
end