"""
    solve(problem::MySimpleLinearChoiceProblem) -> Dict{String,Any}

Solves the optimal decision problem with a budget constraint using a Linear utility model
"""
function solve(problem::MySimpleLinearChoiceProblem)::Dict{String,Any}

    # initialize -
    results = Dict{String,Any}()
    α = problem.α;
    c = problem.c;
    bounds = problem.bounds;
    I = problem.I;
    xₒ = problem.initial

    # how many variables do we have?
    d = length(α);

    # Setup the problem -
    model = Model(GLPK.Optimizer)
    @variable(model, bounds[i,1] <= x[i=1:d] <= bounds[i,2], start=xₒ[i]) # we have d variables
    
    # set objective function -   
    @objective(model, Max, transpose(α)*x);
    @constraints(model, 
        begin
            # my budget constraint
            transpose(c)*x <= I
        end
    );

    # run the optimization -
    optimize!(model)

     # check: was the optimization successful?
     @assert is_solved_and_feasible(model)

    # populate -
    x_opt = value.(x);
    results["argmax"] = x_opt
    results["budget"] = transpose(c)*x_opt; 
    results["objective_value"] = objective_value(model);

    # return -
    return results
end

function solve(problem::MySimpleDualLinearChoiceProblem)::Dict{String,Any}

    # initialize -
    results = Dict{String,Any}()
    α = problem.α;
    c = problem.c;
    bounds = problem.bounds;
    I = problem.I;
    yₒ = problem.initial

    # how many variables do we have?
    d = length(α);

    @show d

    # Setup the problem -
    model = Model(GLPK.Optimizer)
    @variable(model, bounds[i,1] <= y[i=1:d] <= bounds[i,2], start = 0.0) # we have d variables
    
    # set objective function -   
    @objective(model, Min, transpose(α)*y);
    @constraints(model, 
        begin
            # my budget constraint
            transpose(c)*y >= I # we pass in the transpose of the primal problem
        end
    );

    # run the optimization -
    optimize!(model)

    # check: was the optimization successful?
    @assert is_solved_and_feasible(model)

    # populate -
    y_opt = value.(y);
    results["argmin"] = y_opt
    # results["budget"] = transpose(c*y_opt; 
    results["objective_value"] = objective_value(model);

    # return -
    return results
end

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