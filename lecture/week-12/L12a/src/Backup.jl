"""
    myrandpolicy(problem::MyMDPProblemModel, world::MyRectangularGridWorldModel, s::Int)::Int

This function implements a random policy for a given MDP problem and world model.

### Arguments
- `problem::MyMDPProblemModel`: the MDP problem model
- `world::MyRectangularGridWorldModel`: the world model
- `s::Int`: the state

### Returns
- `Int`: the action we choose
"""
function myrandpolicy(problem::MyMDPProblemModel, 
    world::MyRectangularGridWorldModel, s::Int)::Int

    # initialize -
    d = Categorical([0.25,0.25,0.25,0.25]); # you specify this

    # should keep chooseing -
    should_choose_gain = true;
    a = -1; # default
    while (should_choose_gain == true)
    
        # initialize a random categorical distribution over actions -
        aᵢ = rand(d);
        
        # get the move, and the current location -
        Δ = world.moves[aᵢ];
        current_position = world.coordinates[s]
        new_position =  current_position .+ Δ
        if (haskey(world.states, new_position) == true)
            a = aᵢ
            should_choose_gain = false;
        end
    end

    return a;
end;

"""
    myrandstep(problem::MyMDPProblemModel, world::MyRectangularGridWorldModel, s::Int, a::Int)

This function implements a random step for a given MDP problem and world model.

### Arguments
- `problem::MyMDPProblemModel`: the MDP problem model
- `world::MyRectangularGridWorldModel`: the world model
- `s::Int`: the state we are in
- `a::Int`: the action we choose

### Returns
- `(s′,r)`: a tuple of the next state and the reward for being in state `s` and taking action `a`
"""
function myrandstep(problem::MyMDPProblemModel, 
    world::MyRectangularGridWorldModel, s::Int, a::Int)

    # get the reward value -
    r = problem.R[s,a];

    # get the move, and the current location -
    Δ = world.moves[a];
    current_position = world.coordinates[s]

    # propose a new position -
    new_position =  current_position .+ Δ
    s′ = s; # default, we don't do anything
    if (haskey(world.states, new_position) == true)
        s′ = world.states[new_position];
    end

    # return -
    return (s′,r)
end;


