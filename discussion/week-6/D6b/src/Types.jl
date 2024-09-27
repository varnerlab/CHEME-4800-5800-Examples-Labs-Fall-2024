abstract type MyAbstractGraphModel end
abstract type MyAbstractGraphNodeModel end

mutable struct MyGraphNodeModel <: MyAbstractGraphNodeModel
   
   # data -
   id::Int64

   # constructor -
   MyGraphNodeModel(id::Int64) = new(id);
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