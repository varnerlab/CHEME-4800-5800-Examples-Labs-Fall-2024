"""
    DFS(graph::T, node::MyGraphNodeModel, visited::Set{Int64}) where T <: MyAbstractGraphModel
"""
function DFS(graph::T, node::MyGraphNodeModel, visited::Set{Int64}; verbose::Bool = false, 
    framecounter::Int64 = 1) where T <: MyAbstractGraphModel

    # print - if verbose is true

    if (in(node.id, visited) == false)
        
        # recursive case -
        # write a frame
        if (verbose == true)
            _writeframe(_convert(graph), visited, framecounter);
        end

        push!(visited, node.id); # add this node to the visited set -
       
        # write a frame -
        if (verbose == true)
            _writeframe(_convert(graph), visited, (framecounter+1));
        end
        mychildren = children(graph, node);  # get the children of the current node -

        # visit the children -
        for child in mychildren
            if (in(child, visited) == false) # mod from lecture pcode: don't recurse if the child has already been visited
                DFS(graph, graph.nodes[child], visited, verbose=verbose, framecounter=(framecounter+1)); 
            end
        end
    end
end



"""
    BFS(graph::T, node::MyGraphNodeModel) where T <: MyAbstractGraphModel
"""
function BFS(graph::T, node::MyGraphNodeModel; verbose::Bool = false) where T <: MyAbstractGraphModel

    # initialize -
    visited = Set{Int64}();
    q = Queue{Int64}();
    framecounter = 1;
    
    # enqueue the first node -
    enqueue!(q, node.id);
    
    # main loop -
    while isempty(q) == false
        v = dequeue!(q);
        if (in(v,visited) == false)           
            push!(visited, v);
            mychildren = children(graph, graph.nodes[v]);
            for child in mychildren
                if (in(child, visited) == false) # mod: don't enqueue if the child has already been visited
                    enqueue!(q, child);
                end
            end
        end

        # print - if verbose is true
        if (verbose == true)
            _writeframe(_convert(graph), visited, v, framecounter);
            #@show "Visiting: $(v)";
        end

        framecounter += 1;
    end
end