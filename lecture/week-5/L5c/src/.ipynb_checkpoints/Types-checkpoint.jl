abstract type AbstractPriceTreeModel end

"""
    Type: ArrayBasedTernaryCommodityPriceTree
"""
mutable struct ArrayBasedTernaryCommodityPriceTree <: AbstractPriceTreeModel

    # data -
    data::Dict{Int64,Float64}

    # constructor 
    ArrayBasedTernaryCommodityPriceTree() = new()
end

"""
    Type: AdjacencyBasedTernaryCommodityPriceTree
"""
mutable struct AdjacencyBasedTernaryCommodityPriceTree <: AbstractPriceTreeModel

    # data -
    data::Dict{Int64,Float64}
    connectivity::Dict{Int64,Array{Int64,1}}

    # constructor 
    AdjacencyBasedTernaryCommodityPriceTree() = new()
end