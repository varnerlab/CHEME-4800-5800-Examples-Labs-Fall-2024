"""
    build(type::Type{ArrayBasedTernaryCommodityPriceTree}; 
        h::Int64 = 1, price::Float64 = 1.0, u::Float64 = 0.02, d::Float64 = 0.01) -> ArrayBasedTernaryCommodityPriceTree
"""
function build(type::Type{ArrayBasedTernaryCommodityPriceTree}; 
    h::Int64 = 1, price::Float64 = 1.0, u::Float64 = 0.02, d::Float64 = 0.01)::ArrayBasedTernaryCommodityPriceTree

    # initialize -
    model = ArrayBasedTernaryCommodityPriceTree(); # build an emprt tree model -
    Nₕ = sum([3^i for i ∈ 0:h]) # compute how many nodes we have in the tree
    P = Dict{Int64,Float64}() 

    # setup Δ - the amount the price moves up, or down -
    Δ = [u,0,-d];
    
    # set the root price -
    P[0] = price

    # fill up the array -
    for i ∈ 0:(Nₕ - 3^h - 1)
        
        # what is the *parent* price -
        Pᵢ = P[i]

        # Compute the children for this node -
        Cᵢ = [j for j ∈ (3*i+1):(3*i+3)]; 
        for c ∈ 1:3 # for each node (no matter what i) we have three children
        
            # what is the child index?
            child_index = Cᵢ[c]

            # compute the new *child* prive 
            P[child_index] = Pᵢ*(1+Δ[c])
        end
    end

    # set the price data on the model -
    model.data = P;

    # return -
    return model
end

"""
    build(type::Type{AdjacencyBasedTernaryCommodityPriceTree};
        h::Int64 = 1, price::Float64 = 1.0, u::Float64 = 0.02, d::Float64 = 0.01) -> AdjacencyBasedTernaryCommodityPriceTree
"""
function build(type::Type{AdjacencyBasedTernaryCommodityPriceTree};
    h::Int64 = 1, price::Float64 = 1.0, u::Float64 = 0.02, d::Float64 = 0.01)::AdjacencyBasedTernaryCommodityPriceTree

    # initialize -
    model = AdjacencyBasedTernaryCommodityPriceTree(); # build an emprt tree model
    Nₕ = sum([3^i for i ∈ 0:h]) # compute how many nodes we have in the tree
    P = Dict{Int64,Float64}() # use Dict for zero-based array hack. Hold price information
    connectivity = Dict{Int64, Array{Int64,1}}() # holds tree connectivity information

    # setup Δ - the amount the price moves up, or down -
    Δ = [u,0,-d];

    # set the root price -
    P[0] = price

    # build connectivity -
    for i ∈ 0:(Nₕ - 3^h - 1)
        
        # what is the *parent* price
        Pᵢ = P[i]

        # Compute the children for this node -
        Cᵢ = [j for j ∈ (3*i+1):(3*i+3)]; 
        connectivity[i] = Cᵢ # stores the children indices of node i

        # cmpute the prices at the child nodes
        for c ∈ 1:3 # for each node (no matter what i) we have three children

            # what is the child index?
            child_index = Cᵢ[c]

            # compute the new price for the child node
            P[child_index] = Pᵢ*(1+Δ[c])
        end
    end

    # set the data, and connectivity for the model -
    model.data = P;
    model.connectivity = connectivity;

    # return -
    return model;
end