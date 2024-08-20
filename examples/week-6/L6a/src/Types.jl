abstract type AbstractPriceTreeModel end

"""
    Type: ArrayBasedTernaryCommodityPriceTree
"""
mutable struct ArrayBasedTernaryCommodityPriceTree <: AbstractPriceTreeModel

    # data -
    data::Dict{Int64,Float64}
    h::Int64; # height of the tree
    k::Int64; # branching factor of the tree

    # constructor 
    ArrayBasedTernaryCommodityPriceTree() = new()
end

"""
    Type: AdjacencyBasedTernaryCommodityPriceTree
"""
mutable struct AdjacencyBasedTernaryCommodityPriceTree <: AbstractPriceTreeModel

    # data -
    data::Dict{Int64,Float64}; # price of the commodity at each node (data)
    connectivity::Dict{Int64,Array{Int64,1}}; # connectivity of the tree
    h::Int64; # height of the tree
    k::Int64; # branching factor of the tree

    # constructor 
    AdjacencyBasedTernaryCommodityPriceTree() = new()
end