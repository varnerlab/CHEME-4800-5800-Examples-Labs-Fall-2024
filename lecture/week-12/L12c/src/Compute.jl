function UCB1(node::MyMCTSTreeNodeModel)::Float64

    # get the score -
    score = node.score;

    # get the number of times visited -
    timesvisited = node.timesvisited;

    # get the number of times visited by the parent -
    parent_timesvisited = node.parent.timesvisited;

    # check if we have visited this node -
    if (timesvisited == 0)
        return Inf;
    end

    # get the exploration term -
    explotation_term = (score/timesvisited);
    exploration_term = 2.0*sqrt((2*log(parent_timesvisited))/timesvisited);
    total_score = explotation_term + exploration_term;

    # return -
    return total_score;
end

function traversal(world::MyRectangularGridWorldModel, node::MyMCTSTreeNodeModel)

    if (node.children === nothing)
        
        # how many times as it been sampled?
        times_visited = node.timesvisited;
        if (times_visited == 0)
            return node
        else

            # ok, we need to expand -
            new_root = expansion(world, node);
            if (new_root.children === nothing)
                return new_root;
            else
                return new_root.children[1];
            end
        end
    else
        
        # initialize -
        children = node.children;
        scores = Array{Float64,1}();

        # calculate the UCB1 score for each child -
        for child ∈ children
            push!(scores, UCB1(child));
        end
    
        # compute the index of the maximum score -
        best_child_index = argmax(scores);
        selected_node = children[best_child_index];

        # traverse -
        return traversal(world, selected_node);
    end
end

function expansion(world::MyRectangularGridWorldModel, node::MyMCTSTreeNodeModel)

    # ok, we need to generate a tree
    Δ = world.moves;
    current_position = node.position;
    treenodes = world.treenodes;
    terminal_states = world.terminal_states;

    # if we start in the terminal state, then just return the node -
    if (in(node.position, terminal_states) == true)
        return node;
    end

    # check: do we have this field?
    if (node.children === nothing)
        node.children = Array{MyMCTSTreeNodeModel,1}();
    end

    for a ∈ world.𝒜
        
        new_position = current_position .+ Δ[a];
        if (haskey(world.states, new_position) == true && haskey(world.treenodes, new_position) == false)

            # create a new node -
            child_node = build(MyMCTSTreeNodeModel, 
                (position = new_position, score = 0.0, timesvisited = 0, parent = node, action = a, children = nothing));

            # add to the tree -
            treenodes[new_position] = child_node;
            
            # create a new node -        
            push!(node.children, child_node);
        end
    end

    # check if we have no children -
    if (length(node.children) == 0)
        node.children = nothing;
    end

    # return -
    return node;
end

function rollout(world::MyRectangularGridWorldModel, node::MyMCTSTreeNodeModel)::Float64

    # initialize -
    score = 0.0;
    rewards = world.rewards;
    legal_states = world.states;
    terminal_states = world.terminal_states;
    γ = 0.95;

    # get the current position - check: are we starting in a terminal state?, if so just return the reward -
    current_position = node.position;
    if (in(current_position, terminal_states) == true)
        return rewards[legal_states[current_position]];
    end

    
    # keep going until we hit a terminal state -
    test_position = current_position;
    test_position_index = legal_states[test_position];
    counter = 1;
    while (test_position ∉ terminal_states)

       
        # get the next action -
        aᵢ = rand(1:4);
        Δ = world.moves[aᵢ];

        # get the next position -
        test_position = test_position .+ Δ;
        if (haskey(legal_states, test_position) == false)
            test_position = current_position;
        end

        # get test position index -
        test_position_index = legal_states[test_position];

        # # update the score -
        score += γ^(counter-1)*rewards[test_position_index];

        # update the counter -
        counter += 1;
    end
    
    # return -
    return score;
end

function backpropagate(node::MyMCTSTreeNodeModel, score::Float64)::Nothing

    # update the score -
    node.score += score;
    node.timesvisited += 1;

    # check if we are at the root -
    if (node.parent === nothing)
        return nothing;
    else
        return backpropagate(node.parent, score);
    end
end