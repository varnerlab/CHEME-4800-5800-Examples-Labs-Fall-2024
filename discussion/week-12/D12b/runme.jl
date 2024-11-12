include("problemsetup.jl")

# -- STEP 2: Solve the problem BELOW ------------------------------------------------------------------------------------ #
solver = MCTSSolver(n_iterations=50, depth=200, exploration_constant=5.0, enable_tree_vis=true); # create the solver
planner = solve(solver, mdp); # solve the problem
a = action(planner, SA[1,1]); # get the action for the state (1,2)
# -- STEP 2: Solve the problem ABOVE ------------------------------------------------------------------------------------ #