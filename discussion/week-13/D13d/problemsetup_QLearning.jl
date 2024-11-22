# include -
include("Include.jl")

# -- STEP 1: Setup the problem BELOW ------------------------------------------------------------------------------------ #

# constants -
number_of_rows = 30; # number_of_rows in the grid (apples)
number_of_columns = 30; # number_of_columns in the grid (oranges)
number_of_states = number_of_rows*number_of_columns; # number of states in the grid
number_of_actions = 4; # number of actions (move around the grid)
𝒮 = range(1,stop=number_of_states,step=1) |> collect;
𝒜 = range(1,stop=number_of_actions,step=1) |> collect;

# parameters associated with the utility function -
α = [0.30, 0.70]; # coefficients
c = [0.98, 1.79]; # price of x1 and x2
# c = [0.01, 0.01]; # price of x1 and x2
total_budget = 50.0; # we can only spend this much
budget_penalty = -10000.0; # penalty for going over budget

# what will the rewards be?
myrewards = Dict{Tuple{Int,Int}, Float64}();
for apples ∈ 1:number_of_rows
    for oranges ∈ 1:number_of_columns
        how_much_did_we_spend = c[1]*apples + c[2]*oranges;
        myrewards[(apples,oranges)] = U((apples,oranges), α) + 
            budget_penalty*max(0.0, how_much_did_we_spend - total_budget);
    end
end

# build the world model -
world_model = build(MyRectangularGridWorldModel, (
    nrows=number_of_rows, ncols=number_of_columns, rewards = myrewards, defaultreward = 0.0));

# setup up the agent -
agent_model = let
    
    α = 0.7;  # learning rate
    γ = 0.95; # discount rate
    nstates = (number_of_rows*number_of_columns);

    agent_model = build(MyQLearningAgentModel, (
        states = 𝒮, # states (coordinates)
        actions = 𝒜, # actions 
        α = α, # learning rate
        γ = γ, # discount rate
        Q = zeros(number_of_states,number_of_actions) # Hmmm. Could we do something better than this?
    ));

    agent_model
end

# for visualization purposes, let's keep track of the soft walls -
soft_wall_set = Set{Tuple{Int,Int}}();
for s ∈ 𝒮
    
    # get the position -
    current_position = world_model.coordinates[s]
    
    # does this position violate the budget?
    budget_violation = max(0.0, c[1]*current_position[1]+c[2]*current_position[2] - total_budget)
    if (budget_violation ≥ 1.0)
        push!(soft_wall_set, current_position)
    end
end

# -- STEP 1: Setup the problem ABOVE ------------------------------------------------------------------------------------ #