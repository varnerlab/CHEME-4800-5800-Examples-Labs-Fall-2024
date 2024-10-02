abstract type MyAbstractGraphModel end
abstract type MyAbstractGraphNodeModel end
abstract type MyAbstractGraphEdgeModel end
abstract type MyAbstractGraphSearchAlgorithm end

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
   weight::Union{Nothing, Float64}; # this is a little fancy??

    # constructor -
    MyGraphEdgeModel() = new();
end

mutable struct MySimpleDirectedGraphModel <: MyAbstractGraphModel
   
   # data -
   nodes::Union{Nothing, Dict{Int64, MyGraphNodeModel}}
   edges::Union{Nothing, Dict{Tuple{Int, Int}, Int64}}
   children::Union{Nothing, Dict{Int64, Set{Int64}}}

   # constructor -
   MySimpleDirectedGraphModel() = new();
end

mutable struct MySimpleUndirectedGraphModel <: MyAbstractGraphModel
   
    # data -
    nodes::Union{Nothing, Dict{Int64, MyGraphNodeModel}}
    edges::Union{Nothing, Dict{Tuple{Int, Int}, Int64}}
    children::Union{Nothing, Dict{Int64, Set{Int64}}}
 
    # constructor -
    MySimpleUndirectedGraphModel() = new();
 end

 
struct DikjstraAlgorithm <: MyAbstractGraphSearchAlgorithm
   DikjstraAlgorithm() = new();
end

struct BellmanFordAlgorithm <: MyAbstractGraphSearchAlgorithm
   BellmanFordAlgorithm() = new();
end