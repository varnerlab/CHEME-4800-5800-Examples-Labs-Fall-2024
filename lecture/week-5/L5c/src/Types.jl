abstract type AbstractPriceTreeModel end

"""
    mutable struct ArrayBasedTernaryCommodityPriceTree <: AbstractPriceTreeModel

The `ArrayBasedTernaryCommodityPriceTree` type is a model of a ternary commodity price tree that uses an dictionary to store the price data.
This model does not store the connectivity information between nodes. 

### Fields
- `data::Dict{Int64,Float64}`: A dictionary that stores the price data for the tree.
"""
mutable struct ArrayBasedTernaryCommodityPriceTree <: AbstractPriceTreeModel

    # data -
    data::Dict{Int64,Float64}

    # constructor 
    ArrayBasedTernaryCommodityPriceTree() = new()
end

"""
    mutable struct AdjacencyBasedTernaryCommodityPriceTree <: AbstractPriceTreeModel

The `AdjacencyBasedTernaryCommodityPriceTree` type is a model of a ternary commodity price tree that uses an dictionary to store the price data.
This model stores the connectivity information between nodes.

### Fields
- `data::Dict{Int64,Float64}`: A dictionary that stores the price data for the tree.
- `connectivity::Dict{Int64,Array{Int64,1}}`: A dictionary that stores the connectivity information between nodes.
"""
mutable struct AdjacencyBasedTernaryCommodityPriceTree <: AbstractPriceTreeModel

    # data -
    data::Dict{Int64,Float64}
    connectivity::Dict{Int64,Array{Int64,1}}

    # constructor 
    AdjacencyBasedTernaryCommodityPriceTree() = new()
end