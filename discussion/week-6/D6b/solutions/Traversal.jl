"""
    DFS(graph::T, node::MyGraphNodeModel, visited::Set{Int64}) where T <: MyAbstractGraphModel
"""
function DFS(graph::T, node::MyGraphNodeModel, visited::Set{Int64}) where T <: MyAbstractGraphModel

    if (in(node.id, visited) == false)
        
       @show "Visiting: $(node.id)";

        # recursive case -
        push!(visited, node.id); # add this node to the visited set -
        mychildren = children(graph, node);  # get the children of the current node -
    
        # visit the children -
        for child in mychildren
            if (in(child, visited) == false) # mod from lecture pcode: don't recurse if the child has already been visited
                DFS(graph, graph.nodes[child], visited); 
            end
        end
    end

    # backtracking -
    @show "Backtracking from: $(node.id)";
end

"""
    BFS(graph::T, node::MyGraphNodeModel) where T <: MyAbstractGraphModel
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
                if (in(child, visited) == false) # mod: don't enqueue if the child has already been visited
                    enqueue!(q, child);
                end
            end
        end
    end
end