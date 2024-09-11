# setup -
include("Include.jl")

# problem setup 
number_of_rows = 10
number_of_cols = 10
nactions = 4;
nstates = (number_of_rows*number_of_cols);
𝒮 = range(1,stop=nstates,step=1) |> collect;
𝒜 = range(1,stop=nactions,step=1) |> collect;
lava_reward = -500.0;
charging_reward = 1000.0;

# rewards -
rewards = Dict{Tuple{Int,Int}, Float64}()
rewards[(5,5)] = lava_reward # lava in the (5,5) square 
rewards[(6,5)] = lava_reward # lava in the (6,5) square
rewards[(6,6)] = lava_reward # lava in the (6,6) square
rewards[(5,6)] = charging_reward    # charging station square

# terminal states -
absorbing_state_set = Set{Tuple{Int,Int}}()
push!(absorbing_state_set, (5,5));
push!(absorbing_state_set, (6,5));
push!(absorbing_state_set, (6,6));
push!(absorbing_state_set, (5,6));


world = build(MyRectangularGridWorldModel, 
        (nrows = number_of_rows, ncols = number_of_cols, rewards = rewards, terminal_states = absorbing_state_set));

start_position = (3,1);
start_node = build(MyMCTSTreeNodeModel, 
    (position = start_position, score = 0.0, timesvisited = 0, parent = nothing, children = nothing, action = nothing)) |> x-> expansion(world, x);

# add root node to the treenodes dictionary -
world.treenodes[start_position] = start_node;

# run the simulation -
number_of_iterations = 10;
for i ∈ 1:number_of_iterations
    candidate = traversal(world, start_node);
    score = rollout(world, candidate);
    backpropagate(candidate, score);
end

next_state = [UCB1(node) for node ∈ start_node.children] |> argmax |> x-> start_node.children[x].position;