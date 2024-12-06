abstract type MyAbstractGraphModel end
abstract type MyAbstractGraphNodeModel end
abstract type MyAbstractGraphEdgeModel end

"""
  mutable struct MyGraphNodeModel <: MyAbstractGraphNodeModel

The struct represents a node in a graph model.

### Fields
- `id::Int64`: the unique identifier of the node. We'll use the index of the node in the graph model.
- `capacity::Union{Nothing, Tuple{Int64, Int64}}`: the maximum in-degree and out-degree of the node.
"""
mutable struct MyGraphNodeModel <: MyAbstractGraphNodeModel
   
     # data -
    id::Int64
    state::Union{Nothing, Int64}; # state: s = ± 1
 
    # constructor -
    MyGraphNodeModel(id::Int64, state::Union{Nothing, Int64} = nothing) = new(id, state);
end
 
"""
  mutable struct MyGraphEdgeModel <: MyAbstractGraphEdgeModel

The struct represents an edge in a graph model.

### Fields
- `id::Int64`: the unique identifier of the edge. We'll use the index of the edge in the graph model.
- `source::Int64`: the source node id.
- `target::Int64`: the target node id.
- `cost::Union{Nothing, Float64}`: the cost of the edge.
- `lower_bound_capacity::Union{Nothing, Float64}`: the lower bound capacity of the edge.
- `upper_bound_capacity::Union{Nothing, Float64}`: the upper bound capacity of the edge.

"""
mutable struct MyGraphEdgeModel <: MyAbstractGraphEdgeModel
    
    # data -
    id::Int64
    source::Int64
    target::Int64
    weight::Union{Nothing, Float64}; # this is a little fancy??
   
    # constructor -
    MyGraphEdgeModel() = new();
end

"""
    mutable struct MySimpleUndirectedGraphModel <: MyAbstractGraphModel

The struct represents a simple undirected graph model.

### Fields
- `nodes::Union{Nothing, Dict{Int64, MyGraphNodeModel}}`: a dictionary of nodes.
- `edges::Union{Nothing, Dict{Tuple{Int, Int}, Int64}}`: a dictionary of edges.
- `children::Union{Nothing, Dict{Int64, Set{Int64}}}`: a dictionary of children nodes.
"""
mutable struct MySimpleUndirectedGraphModel <: MyAbstractGraphModel
   
    # data -
    nodes::Union{Nothing, Dict{Int64, MyGraphNodeModel}}
    edges::Union{Nothing, Dict{Tuple{Int, Int}, Int64}}
    children::Union{Nothing, Dict{Int64, Set{Int64}}}
 
    # constructor -
    MySimpleUndirectedGraphModel() = new();
 end

 