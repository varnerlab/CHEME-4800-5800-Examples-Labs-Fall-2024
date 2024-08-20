function policy(node::MyMCTSTreeNodeModel, storage::Array{Tuple{Int,Int},1})    

    # get the children -
    if (node.children === nothing)
        push!(storage, node.position);
        return nothing;
    else
        
        # get the children -
        children = node.children;
        local_score_array = Array{Float64,1}()
        for child in children
            push!(local_score_array, UCB1(child));
        end

        # get the best score -
        best_score_index = argmax(local_score_array);
        push!(storage, children[best_score_index].position);
        policy(children[best_score_index], storage);
    end

    return nothing;
end