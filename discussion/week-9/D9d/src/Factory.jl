function _build(edgemodel::Type{MyGraphEdgeModel}, parts::Array{String,1}, id::Int64)::MyGraphEdgeModel
    
    # initialize -
    model = edgemodel(); # build an empty edge model
    
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


# --- PUBLIC METHODS BELOW HERE ------------------------------------------------------------------------------------------------- ##

"""
    function build(modeltype::Type{T}, data::NamedTuple) where T <: AbstractLinearProgrammingProblemType

This function builds a linear programming problem model of type T from the data in the NamedTuple data.

### Arguments
- modeltype::Type{T}: The type of the model to build.
- data::NamedTuple: The data to use to build the model.

### Returns
- T: An instance of the model type `T` which is a subtype of `AbstractLinearProgrammingProblemType`. 
"""
function build(modeltype::Type{T}, data::NamedTuple) where T <: AbstractLinearProgrammingProblemType

    # initialize -
    model = modeltype(); # build an empty model 

    # set the data -
    model.A = data.A;
    model.b = data.b;
    model.c = data.c;
    model.lb = data.lb;
    model.ub = data.ub;

    # return -
    return model;
end

"""
    function build(model::Type{T}, edgemodels::Dict{Int64, MyGraphEdgeModel}) where T <: MyAbstractGraphModel

This function builds a graph model of type T from the edge models in the dictionary edgemodels.

### Arguments
- model::Type{T}: The type of the model to build.
- edgemodels::Dict{Int64, MyGraphEdgeModel}: A dictionary of edge models.

### Returns
- T: An instance of the model type `T` which is a subtype of `MyAbstractGraphModel. 
"""
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
    [nodes[id] = MyGraphNodeModel(id, nothing) for id ∈ list_of_node_ids];
    # --------------------------------------------------------------------------- #
    
    # -- DO STUFF WITH EDGES ---------------------------------------------------- #
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
    # --------------------------------------------------------------------------- #

    # -- DO STUFF WITH CHILDREN ------------------------------------------------- #
    for id ∈ list_of_node_ids
        node = nodes[id];
        children[id] = _children(edges, node.id);
    end
    # --------------------------------------------------------------------------- #

    # -- DO STUFF WITH A -------------------------------------------------------- #
    d = length(edges);
    n = length(nodes);
    A = zeros(n, d);
    for (k,v) ∈ edgesinverse
        A[v[1], k] = -1.0;
        A[v[2], k] = 1.0;
    end
    # --------------------------------------------------------------------------- #
    
    # add stuff to model -
    graphmodel.nodes = nodes;
    graphmodel.edges = edges;
    graphmodel.edgesinverse = edgesinverse;
    graphmodel.children = children;
    graphmodel.A = A;

    # return -
    return graphmodel;
end
# --- PUBLIC METHODS ABOVE HERE ----------------------------------------------------------------------------------- #
