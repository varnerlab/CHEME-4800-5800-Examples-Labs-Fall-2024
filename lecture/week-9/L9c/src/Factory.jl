function _build(edgemodel::Type{MyGraphEdgeModel}, parts::Array{String,1}, id::Int64)::MyGraphEdgeModel
    
    # initialize -
    model = MyGraphEdgeModel(); # build an empty edge model
    
    # populate -
    model.id = id;
    model.source = parse(Int64, parts[1]);
    model.target = parse(Int64, parts[2]);
    model.cost = parse(Float64, parts[3]);
    model.lower_bound_capacity = parse(Float64, parts[4]);
    model.upper_bound_capacity = parse(Float64, parts[5]);

    # return -
    return model
end

function _build(modeltype::Type{T}, data::NamedTuple) where T <: Union{AbstractSimpleChoiceProblem}
    
    # build an empty model
    model = modeltype();

    # if we have options, add them to the contract model -
    if (isempty(data) == false)
        for key ∈ fieldnames(modeltype)
            
            # check the for the key - if we have it, then grab this value
            value = nothing
            if (haskey(data, key) == true)
                # get the value -
                value = data[key]
            end

            # set -
            setproperty!(model, key, value)
        end
    end
 
    # return -
    return model
end

# --- PUBLIC METHODS BELOW HERE ----------------------------------------------------------------------------------- #
function build(model::Type{T}, edgemodels::Dict{Int64, MyGraphEdgeModel}) where T <: MyAbstractGraphModel

    # build and empty graph model -
    graphmodel = model();
    nodes = Dict{Int64, MyGraphNodeModel}();
    edges = Dict{Tuple{Int64, Int64}, Tuple{Float64,Float64, Float64}}();
    edgesinverse = Dict{Int, Tuple{Int, Int}}();
    children = Dict{Int64, Set{Int64}}();

    # -- DO STUFF WITH NODES -------------------------------------------------- #
    # let's build a list of nodes ids -
    tmp_node_ids = Set{Int64}();
    for (_,v) ∈ edgemodels
        push!(tmp_node_ids, v.source);
        push!(tmp_node_ids, v.target);
    end
    list_of_node_ids = tmp_node_ids |> collect |> sort;

    # build the nodes models with the id's
    [nodes[id] = MyGraphNodeModel(id) for id ∈ list_of_node_ids];
    
    # compute the children of this node -
    # for id ∈ list_of_node_ids
    #     node = nodes[id];
    #     children[id] = _children(edges, node.id);
    # end
    # ------------------------------------------------------------------------- #
    
    # -- DO STUFF WITH EDGES -------------------------------------------------- #
    # build the edges dictionary (source, target) -> (cost, lower_bound_capacity, upper_bound_capacity
    for (_, v) ∈ edgemodels
        source_index = v.source;
        target_index = v.target;
        edges[(source_index, target_index)] = (v.cost, v.lower_bound_capacity, v.upper_bound_capacity);
    end

    # build the inverse edge dictionary edgeid -> (source, target)
    n = length(nodes);
    edgecounter = 1;
    for source ∈ 1:n
        for target ∈ 1:n
            if haskey(edges, (source, target)) == true
                edgesinverse[edgecounter] = (source, target);
                edgecounter += 1;
            end
        end
    end
    # ------------------------------------------------------------------------- #
    
    # add stuff to model -
    graphmodel.nodes = nodes;
    graphmodel.edges = edges;
    graphmodel.edgesinverse = edgesinverse;
    graphmodel.children = children;

    # return -
    return graphmodel;
end

build(model::Type{MySimpleCobbDouglasChoiceProblem}, data::NamedTuple)::MySimpleCobbDouglasChoiceProblem = _build(model, data);
# --- PUBLIC METHODS ABOVE HERE ----------------------------------------------------------------------------------- #
