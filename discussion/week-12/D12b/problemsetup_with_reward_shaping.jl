# load the include file -
include("Include.jl")

# -- STEP 1: Setup the problem BELOW ------------------------------------------------------------------------------------ #
number_of_rows = 20; # number_of_rows in the grid
number_of_columns = 20; # number_of_columns in the grid
number_of_states = number_of_rows*number_of_columns; # number of states in the grid
γ = 0.1; # discount factor
lava_reward = -1000.0; # penalty for falling into the lava
charging_reward = 100.0; # reward for reaching the goal
default_reward = -0.01; # penalty for each step
charging_station_coordinates = GWPos(4,3); # charging station coordinates
σ = 1.0; # sigma for the RBF function


# set the rewards for the special squares -
rewards = Dict{GWPos, Float64}();
rewards[GWPos(1,2)] = lava_reward # lava in the (1,2) square 
rewards[GWPos(2,2)] = lava_reward # lava in the (2,2) square 
rewards[GWPos(2,3)] = lava_reward # lava in the (2,3) square 
rewards[GWPos(4,5)] = lava_reward # lava in the (4,4) square
rewards[charging_station_coordinates] = charging_reward   # charging station square

# setup set of absorbing states -
absorbing_state_set = Set{GWPos}()
push!(absorbing_state_set, GWPos(1,2))
push!(absorbing_state_set, GWPos(2,2))
push!(absorbing_state_set, GWPos(2,3))
push!(absorbing_state_set, GWPos(4,5))
push!(absorbing_state_set, GWPos(4,3))

# setup softwall set -
soft_wall_set = Set{GWPos}(); # none for now ...

# setup reward shaping -
for i ∈ 1:number_of_rows
    for j ∈ 1:number_of_columns
        coordinate = GWPos(i,j);

        if (haskey(rewards, coordinate) == false && in(coordinate, soft_wall_set) == false && in(coordinate, absorbing_state_set) == false)
            rewards[coordinate] = default_reward + charging_reward*rbf(coordinate, charging_station_coordinates, σ = σ);
        end
    end
end


# create the problem model 
mdp = SimpleGridWorld(size=(number_of_rows, number_of_columns), rewards=rewards, discount=γ, tprob= 1.0, 
    terminate_from = absorbing_state_set);
# -- STEP 1: Setup the problem ABOVE ------------------------------------------------------------------------------------ #