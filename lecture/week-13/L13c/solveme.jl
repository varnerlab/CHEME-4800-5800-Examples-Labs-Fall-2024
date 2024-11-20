include("problemsetup.jl");

# -- STEP 2: Solve the problem BELOW ------------------------------------------------------------------------------------ #
startstate = (30,1); # start position
number_of_episodes = 200; # how many times do we repeat the task?
number_of_iterations = 1000; # problem horizon (how many moves)

# simulate -
my_Q_dictionary = let
    
    my_Q_dictionary = Dict{Tuple{Int,Int}, Array{Float64,2}}();
    coordinate = startstate;
    for i ∈ 1:number_of_episodes
        
        # run an episode, and grab the Q
        result = simulate(agent_model, world_model, coordinate, number_of_iterations, 
            ϵ = 0.7);
    
        # update the agent with the Q from the last episode, and try to refine this Q
        agent_model.Q = result.Q;  # Analogy: practice make perfect ...
    end
    my_Q_dictionary[coordinate] = agent_model.Q;

    # return
    my_Q_dictionary
end;

Q = my_Q_dictionary[startstate];
my_π = policy(Q);
# -- STEP 2: Solve the problem ABOVE ------------------------------------------------------------------------------------ #