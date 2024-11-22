# PRIVATE METHODS BELOW HERE ================================================================================= #
# placeholder - always return 0
_null(action::Int64)::Int64 = return 0;


function _world(model::MyRectangularGridWorldModel, s::Int, a::Int)::Tuple{Int64, Float64}

    # initialize -
    s′ = nothing
    r = nothing
    
    # get data from the model -
    coordinates = model.coordinates;
    moves = model.moves
    states = model.states;
    rewards = model.rewards;

    # where are we now?
    current_position = coordinates[s];

    # get the perturbation -
    Δ = moves[a];
    new_position = current_position .+ Δ

    # before we go on, have we "driven off the grid"?
    if (haskey(states, new_position) == true)

        # lookup the new state -
        s′ = states[new_position];
        r = rewards[s′];
    else
       
        # ok: so we are all the grid. Bounce us back to to the current_position, and charge a huge penalty 
        s′ = states[current_position];
        r = -1000000000000.0
    end

    # return -
    return (s′,r);
end

"""
    _update!(model::MyQLearningModel, data::NamedTuple) -> MyQLearningAgentModel
"""
function _update(model::MyQLearningAgentModel, data::NamedTuple)::MyQLearningAgentModel

    # grab the s,a,reward and next state from the data tuple
    s = data[:s];
    a = data[:a];
    r = data[:r];
    s′ = data[:s′];
    
    # grab parameters from the model -
    γ, Q, α = model.γ, model.Q, model.α

    # use the update rule to update Q -
    Q[s,a] += α*(r+γ*maximum(Q[s′,:]) - Q[s,a])

    # return -
    return model;
end


function _update(model::MySARSAAgentModel, data::NamedTuple)::MySARSAAgentModel

    # grab the s,a,reward and next state from the data tuple
    s = data[:s];
    a = data[:a];
    a′ = data[:a′];
    r = data[:r];
    s′ = data[:s′];
    
    # grab parameters from the model -
    γ, Q, α = model.γ, model.Q, model.α

    # use the update rule to update Q -
    Q[s,a] += α*(r+γ*Q[s′,a′] - Q[s,a])

    # update the policy -
    model.Q = Q;

    # return -
    return model;
end

# PRIVATE METHODS ABOVE HERE ================================================================================= #

# PUBLIC METHODS BELOW HERE ================================================================================== #``
# Cool hack: What is going on with these?
(model::MyQLearningAgentModel)(data::NamedTuple) = _update(model, data);
(model::MySARSAAgentModel)(data::NamedTuple) = _update(model, data);
(world::MyRectangularGridWorldModel)(s::Int, a::Int) = _world(world, s, a);


"""
    simulate(model::MyQLearningModel, environment::T, startstate::Int, maxsteps::Int;
        ϵ::Float64 = 0.2) -> MyQLearningModel where T <: AbstractWorldModel

Simulate the agent in the environment for a number of steps. The agent will use the ϵ-greedy policy to select actions.

### Arguments
- `model::MyQLearningModel`: The agent model.
- `environment::T`: The environment model
- `startstate::Int`: The starting state
- `maxsteps::Int`: The maximum number of steps to simulate (number of updates to the agent model)
- `ϵ::Float64 = 0.2`: The probability of selecting a random action (exploration rate)

### Returns
- `MyQLearningModel`: The updated agent model
"""
function simulate(agent::MyQLearningAgentModel, environment::MyRectangularGridWorldModel, 
    startstate::Tuple{Int,Int}, maxsteps::Int; ϵ::Float64 = 0.2)::MyQLearningAgentModel

    # initialize -
    s = environment.states[startstate]
    actions = agent.actions;
    number_of_actions = length(actions);

    # simulation loop -
    for _ ∈ 1:maxsteps

        a = nothing;
        if rand() < ϵ

            # we generate a random action
            a = rand(1:number_of_actions);
        else

            # ok: so we are in some state s, let's use our memory to suggest a new action
            Q = agent.Q;
            a = argmax(Q[s,:]);
        end

        # ask the world, what is my next state and reward from this (s,a)
        s′,r = environment(s,a)
        
        # update my model -
        agent = agent((
            s = s, a = a, r = r, s′ = s′
        ));

        # move -
        s = s′;
    end

    # return -
    return agent
end

"""
    simulate(model::MySARSAAgentModel, environment::T, startstate::Int, maxsteps::Int;
        ϵ::Float64 = 0.2) -> MySARSAAgentModel where T <: AbstractWorldModel

Simulate the agent in the environment for a number of steps. The agent will use the ϵ-greedy policy to select actions,
and the Sarsa update rule to update the Q-values.

### Arguments
- `model::MySARSAAgentModel`: The agent model.
- `environment::T`: The environment model
- `startstate::Int`: The starting state
- `maxsteps::Int`: The maximum number of steps to simulate (number of updates to the agent model)
- `ϵ::Float64 = 0.2`: The probability of selecting a random action (exploration rate)

### Returns
- `MySARSAAgentModel`: The updated agent model
"""
function simulate(agent::MySARSAAgentModel, environment::MyRectangularGridWorldModel, 
    startstate::Tuple{Int,Int}, maxsteps::Int; ϵ::Float64 = 0.2)::MySARSAAgentModel

    # initialize -
    actions = agent.actions;
    number_of_actions = length(actions);
    visited_states = Set{Int64}();

    # precompute categorical distribution -
    exploration_dictionary = Dict{Int64,Categorical}();
    for a ∈ 1:number_of_actions
        θ = Array{Float64,1}(undef,number_of_actions)
        for i ∈ 1:number_of_actions
            if (a == i)
                θ[i] = 1 - ϵ + ϵ/number_of_actions;
            else
                θ[i] = ϵ/number_of_actions;
            end
        end
        exploration_dictionary[a] = Categorical(θ);
    end
    
    # simulation loop -
    s = environment.states[startstate];
    a = agent.my_π[s]; # get the action from the policy at this epsiode 
    for _ ∈ 1:maxsteps

        # implement the action -
        s′,r = environment(s,a) # what is the response from the world for doing (s,a)?

        # if we visited s′ - big penalty
        if (in(s′,visited_states) == false)
            push!(visited_states,s′); # ok, we visited this state
        else
            r = -100.0; # dont revisit the same state!
        end

        a′ = agent.my_π[s′] |> i-> exploration_dictionary[i] |> rand # best guess of action from policy
            
        # update my model -
        agent = agent((
            s = s, a = a, r = r, s′ = s′, a′ = a′
        ));

        # update, and go around again -
        s,a = s′,a′;
    end

    # return -
    return agent
end

"""
    policy(Q_array::Array{Float64,2}) -> Array{Int64,1}

Given a Q-array, return the policy that maximizes the Q-values for each state.

### Arguments
- `Q_array::Array{Float64,2}`: The Q-array

### Returns
- `Array{Int64,1}`: The policy array
"""
function policy(Q_array::Array{Float64,2})::Array{Int64,1}

    # get the dimension -
    (NR, _) = size(Q_array);

    # initialize some storage -
    π_array = Array{Int64,1}(undef, NR)
    for s ∈ 1:NR
        π_array[s] = argmax(Q_array[s,:]);
    end

    # return -
    return π_array;
end

function U(x::Tuple{Int,Int}, α::Array{Float64,1})::Float64
    
    # get the apples, and oranges 
    apples = x[1];
    oranges = x[2];
    
    # compute the objective -
    utility = (apples^α[1])*(oranges^α[2]);
    
    # return -
    return utility;
end;
# PUBLIC METHODS ABOVE HERE ================================================================================== #