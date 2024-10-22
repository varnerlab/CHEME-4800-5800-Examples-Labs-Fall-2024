abstract type MyAbstractGraphModel end
abstract type MyAbstractGraphNodeModel end
abstract type MyAbstractGraphEdgeModel end
abstract type AbstractSimpleChoiceProblem end

mutable struct MyGraphNodeModel <: MyAbstractGraphNodeModel
   
    # data -
    id::Int64
 
    # constructor -
    MyGraphNodeModel(id::Int64) = new(id);
 end
 
 mutable struct MyGraphEdgeModel <: MyAbstractGraphEdgeModel
    
    # data -
    id::Int64
    source::Int64
    target::Int64
    cost::Union{Nothing, Float64}; # this is a little fancy??
    lower_bound_capacity::Union{Nothing, Float64}; # this is a little fancy??
    upper_bound_capacity::Union{Nothing, Float64}; # this is a little fancy??
 
    # constructor -
    MyGraphEdgeModel() = new();
 end
 
 mutable struct MySimpleDirectedGraphModel <: MyAbstractGraphModel
    
    # data -
    nodes::Union{Nothing, Dict{Int64, MyGraphNodeModel}}
    edges::Union{Nothing, Dict{Tuple{Int, Int}, Tuple{Float64, Float64, Float64}}}; # first Float64 is the cost, second Float64 is the capacity
    edgesinverse::Dict{Int, Tuple{Int, Int}} # map between edge id and source and target
    children::Union{Nothing, Dict{Int64, Set{Int64}}}
 
    # constructor -
    MySimpleDirectedGraphModel() = new();
 end

 mutable struct MySimpleCobbDouglasChoiceProblem <: AbstractSimpleChoiceProblem

   # data -
   α::Array{Float64,1}
   c::Array{Float64,1}
   I::Float64
   bounds::Array{Float64,2}
   initial::Array{Float64,1}

   # constructor
   MySimpleCobbDouglasChoiceProblem() = new();
end