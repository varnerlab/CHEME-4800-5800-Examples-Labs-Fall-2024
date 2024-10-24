"""
    solve(problem::MySimpleLinearChoiceProblem) -> Dict{String,Any}

Solves a constrained uility maximization problem with linear utility function and linear budget constraint.

### Arguments
- problem::MySimpleLinearChoiceProblem: An instance of MySimpleLinearChoiceProblem holding the data for the problem.

### Returns
- Dict{String,Any}: A dictionary with the following keys:
    - "argmax": The optimal choice.
    - "budget": The budget at the optimal choice.
    - "objective_value": The value of the objective function at the optimal choice.
"""
function solve(problem::MyLinearProgrammingProblemModel)::Dict{String,Any}

    # initialize -
    results = Dict{String,Any}()
    c = problem.c; # objective function coefficients
    lb = problem.lb; # lower bounds
    ub = problem.ub; # upper bounds
    A = problem.A; # constraint matrix
    b = problem.b; # right-hand side vector

    # how many variables do we have?
    d = length(c);

    # Setup the problem -
    model = Model(GLPK.Optimizer)
    @variable(model, lb[i,1] <= x[i=1:d] <= ub[i,1], start=0.0) # we have d variables
    
    # set objective function -   
    @objective(model, Max, transpose(c)*x);
    @constraints(model, 
        begin
            A*x .<= b # my system constraints
        end
    );

    # run the optimization -
    optimize!(model)

    # check: was the optimization successful?
    @assert is_solved_and_feasible(model)

    # populate -
    x_opt = value.(x);
    results["argmax"] = x_opt
    results["objective_value"] = objective_value(model);

    # return -
    return results
end

"""
    solve(problem::MySimpleLinearChoiceProblem) -> Dict{String,Any}

Solves a constrained uility maximization problem with linear utility function and linear budget constraint.

### Arguments
- problem::MySimpleLinearChoiceProblem: An instance of MySimpleLinearChoiceProblem holding the data for the problem.

### Returns
- Dict{String,Any}: A dictionary with the following keys:
    - "argmax": The optimal choice.
    - "budget": The budget at the optimal choice.
    - "objective_value": The value of the objective function at the optimal choice.
"""
function solve(problem::MyLinearProgrammingDualProblemModel)::Dict{String,Any}

    # initialize -
    results = Dict{String,Any}()
    c = problem.c; # obj coeff (right hand side primal problem)
    lb = problem.lb; # lower bounds
    ub = problem.ub; # upper bounds
    A = problem.A; # constraint matrix (transpose of primal problem)
    b = problem.b; # right hand side (obj coeff in primal)

    # how many variables do we have?
    d = length(c);

    # Setup the problem -
    model = Model(GLPK.Optimizer)
    @variable(model, lb[i,1] <= y[i=1:d] <= ub[i,1], start=0.0) # we have d variables
    
    # set objective function -   
    @objective(model, Min, transpose(c)*y);
    @constraints(model, 
        begin
            A*y .>= b # my dual constraints
        end
    );

    # run the optimization -
    optimize!(model)

    # check: was the optimization successful?
    @assert is_solved_and_feasible(model)

    # populate -
    y_opt = value.(y);
    results["argmin"] = y_opt
    results["objective_value"] = objective_value(model);

    # return -
    return results
end