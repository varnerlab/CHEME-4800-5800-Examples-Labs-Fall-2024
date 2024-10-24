include("runme_build_system_constraints.jl") # run the script, this build the graph model and node capacities

# -- SETUP THE LINEAR PROGRAMMING PROBLEM -------------------------------------- #
A = my_graphmodel.A; # constraint matrix
b = my_graphmodel.b; # right-hand side vector
lb = [0.0 for _ in 1:length(my_graphmodel.edges)]; # array comprehension: alternative to zeros(length(my_graphmodel.edges))
ub = [1.0 for _ in 1:length(my_graphmodel.edges)]; # array comprehension: alternative to ones(length(my_graphmodel.edges))

# set the objective function -
number_of_edges = length(my_graphmodel.edges);
c = zeros(number_of_edges);
for i in 1:number_of_edges
    
    # get source,target node ids -
    node_id_tuple = my_graphmodel.edgesinverse[i];

    # get the edge model and the weight -
    edge_model = my_graphmodel.edges[node_id_tuple];
    c[i] = edge_model[1]; # satisfication for the edge
end
# ------------------------------------------------------------------------------ #

# -- SOLVE THE LINEAR PROGRAMMING PROBLEM -------------------------------------- #
primal_model = build(MyLinearProgrammingProblemModel, (
    A = A,
    b = b,
    c = c,
    lb = lb,
    ub = ub
));

# solve the linear programming problem -
primal_solution = nothing;
try
    global primal_solution = solve(primal_model); # global keyword is used to make the variable available outside the try block
catch error
    println("Error: ", error);
end

# make a plot -
include("visualize.jl") # run the script, this visualizes the solution
# ------------------------------------------------------------------------------ #