"""
    DFS(graph::T, node::MyGraphNodeModel, visited::Set{Int64}) where T <: MyAbstractGraphModel

This function performs a depth-first search on a graph model.

### Arguments
- `graph::T`: the graph model to search. This is a subtype of `MyAbstractGraphModel`.
- `node::MyGraphNodeModel`: the node to start the search from.
"""
function DFS(graph::T, node::MyGraphNodeModel, visited::Set{Int64}) where T <: MyAbstractGraphModel

    if (in(node.id, visited) == false)
        
        @show "Visiting: $(node.id)";
 
         # recursive case -
         push!(visited, node.id); # add this node to the visited set -
         mychildren = children(graph, node);  # get the children of the current node -
     
         # visit the children -
         for child in mychildren
             DFS(graph, graph.nodes[child], visited); 
         end
     end
 
     # backtracking -
     @show "Backtracking from: $(node.id)";
end

"""
    BFS(graph::T, node::MyGraphNodeModel) where T <: MyAbstractGraphModel

This function performs a breadth-first search on a graph model.

### Arguments
- `graph::T`: the graph model to search. This is a subtype of `MyAbstractGraphModel`.
- `node::MyGraphNodeModel`: the node to start the search from.

"""
function BFS(graph::T, node::MyGraphNodeModel) where T <: MyAbstractGraphModel

    # initialize -
    visited = Set{Int64}();
    q = Queue{Int64}();
    
    # enqueue the first node -
    enqueue!(q, node.id);
    
    # main loop -
    while isempty(q) == false
        v = dequeue!(q);
        if (in(v,visited) == false)
            @show "Visiting: $(v)";
            push!(visited, v);
            mychildren = children(graph, graph.nodes[v]);
            for child in mychildren
                enqueue!(q, child);
            end
        end
    end
end