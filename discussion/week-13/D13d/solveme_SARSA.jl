include("problemsetup_SARSA.jl");

# -- STEP 2: Solve the problem BELOW ------------------------------------------------------------------------------------ #
startstate = (1,1); # start position
number_of_episodes = 1000; # how many times do we repeat the task?
number_of_iterations = 10; # problem horizon (how many moves)

# simulate -
my_π = let
  
    coordinate = startstate;
    T = 1.0;
    for i ∈ 1:number_of_episodes

        T = (0.99)*T;
        
        # run an episode, and grab the Q
        result = simulate(agent_model_SARSA, world_model, coordinate, number_of_iterations, 
            ϵ = T);
    
        # update the agent with the Q from the last episode, and try to refine this Q
        agent_model_SARSA.Q = result.Q;  # Analogy: practice make perfect ...
        agent_model_SARSA.my_π = policy(agent_model_SARSA.Q); # update the policy
    end
    my_π = agent_model_SARSA.my_π; # return the policy
end;
# -- STEP 2: Solve the problem ABOVE ------------------------------------------------------------------------------------ #