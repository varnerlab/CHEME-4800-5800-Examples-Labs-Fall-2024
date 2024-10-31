"""
    solve(problem::MySimpleBinaryVariableLinearChoiceProblem) -> Dict{String,Any}

Solves the optimal decision problem with a budget constraint using a Linear utility model, 
and binary feature variables
"""
function solve(problem::MySimpleBinaryVariableLinearChoiceProblem)::Dict{String,Any}

    # initialize -
    results = Dict{String,Any}()
    α = problem.α;
    c = problem.c;
    bounds = problem.bounds;
    I = problem.I;
    xₒ = problem.initial
    
    # how many variables do we have?
    d = length(α);

    # additional constraints -
    C = problem.C
    bV = nothing
    if (isnothing(C) == true)
        
        C = zeros(d,d);
        for i ∈ 1:d
            C[i,i] = 1;
        end
        bV = ones(d);
    else
        bV = ones(size(C,1));
    end


    # Setup the problem -
    model = Model(GLPK.Optimizer)
    @variable(model, bounds[i,1] <= x[i=1:d] <= bounds[i,2], start=xₒ[i], Bin) # we have d-binary variables
    
    # set objective function -   
    @objective(model, Max, transpose(α)*x);
    @constraints(model, 
        begin
            
            # my budget constraint
            transpose(c)*x <= I
            C*x <= bV

            # we can only choose one feature
            # x[1] + x[2] <= 1
            # x[3] + x[4] + x[5] + x[6] <= 1
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