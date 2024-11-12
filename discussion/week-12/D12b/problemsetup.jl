# load the include file -
include("Include.jl")

# -- STEP 1: Setup the problem BELOW ------------------------------------------------------------------------------------ #
number_of_rows = 20; # number_of_rows in the grid
number_of_columns = 20; # number_of_columns in the grid
γ = 0.9; # discount factor
lava_reward = -1000.0; # penalty for falling into the lava
charging_reward = 100.0; # reward for reaching the goal
default_reward = -1.0; # penalty for each step

# let's build the rewards for the problem. Start with the default reward
rewards = Dict{GWPos, Float64}();
for i ∈ 1:number_of_rows
    for j ∈ 1:number_of_columns
        rewards[GWPos(i,j)] = default_reward;
    end
end

# set the rewards for the special squares -
rewards[GWPos(1,2)] = lava_reward # lava in the (1,2) square 
rewards[GWPos(2,2)] = lava_reward # lava in the (2,2) square 
rewards[GWPos(2,3)] = lava_reward # lava in the (2,3) square 
rewards[GWPos(4,5)] = lava_reward # lava in the (4,4) square
rewards[GWPos(4,3)] = charging_reward   # charging station square

# setup set of absorbing states -
absorbing_state_set = Set{Tuple{Int,Int}}()
push!(absorbing_state_set, (1,2))
push!(absorbing_state_set, (2,2))
push!(absorbing_state_set, (2,3))
push!(absorbing_state_set, (4,5))
push!(absorbing_state_set, (4,3))

# create the problem model 
mdp = SimpleGridWorld(size=(number_of_rows, number_of_columns), rewards=rewards, discount=γ);
# -- STEP 1: Setup the problem ABOVE ------------------------------------------------------------------------------------ #