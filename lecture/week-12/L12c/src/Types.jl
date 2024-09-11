abstract type AbstractWorldModel end

mutable struct MyMCTSTreeNodeModel

    # data -
    position::Tuple{Int,Int}
    score::Float64
    timesvisited::Int64
    parent::Union{MyMCTSTreeNodeModel, Nothing}
    children::Union{Nothing, Array{MyMCTSTreeNodeModel,1}}
    action::Union{Int64, Nothing}

    # constructor -
    MyMCTSTreeNodeModel() = new()
end

mutable struct MyRectangularGridWorldModel <: AbstractWorldModel

    # data -
    𝒮::Array{Int64,1}
    𝒜::Array{Int64,1}
    number_of_rows::Int
    number_of_cols::Int
    coordinates::Dict{Int,Tuple{Int,Int}}
    states::Dict{Tuple{Int,Int},Int}
    moves::Dict{Int,Tuple{Int,Int}}
    rewards::Dict{Int,Float64}
    terminal_states::Set{Tuple{Int,Int}}
    treenodes::Dict{Tuple{Int,Int}, MyMCTSTreeNodeModel}

    # constructor -
    MyRectangularGridWorldModel() = new();
end