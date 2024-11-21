include("problemsetup_SARSA.jl");

# -- STEP 2: Solve the problem BELOW ------------------------------------------------------------------------------------ #
startstate = (28,10); # start position
number_of_episodes = 200; # how many times do we repeat the task?
number_of_iterations = 1000; # problem horizon (how many moves)

# simulate -
my_π = let
  
    coordinate = startstate;
    for i ∈ 1:number_of_episodes
        
        # run an episode, and grab the Q
        result = simulate(agent_model, world_model, coordinate, number_of_iterations, 
            ϵ = 0.6);
    
        # update the agent with the Q from the last episode, and try to refine this Q
        agent_model.Q = result.Q;  # Analogy: practice make perfect ...
        agent_model.my_π = policy(agent_model.Q); # update the policy
    end
    my_π = agent_model.my_π; # return the policy
end;
# -- STEP 2: Solve the problem ABOVE ------------------------------------------------------------------------------------ #