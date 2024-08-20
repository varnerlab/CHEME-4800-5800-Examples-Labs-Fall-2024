
function _temperature(T,α)
    return α*T;
end

function _neighbor(x, bounds::Array{Float64,2})::Array{Float64,1}
    
    # generate a new x -
    d = length(x);
    new_x = x .* (1.0 .+ 0.05*randn(d));
    
    # enforce the bounds -
    for i ∈ 1:d
        
        # lower -
        L = bounds[i,1];
        if (new_x[i]<L)
            new_x[i] = L
        end

        # upper -
        U = bounds[i,2];
        if (new_x[i]>U)
            new_x[i] = U
        end
    end
    
    # return -
    return new_x;
end

function _accept(difference::Float64, temperature::Float64)::Bool
    
    # initialize -
    should_we_accept = false;
    
    # check -
    if (difference < 0)
        should_we_accept = true;
    elseif (rand() < exp(-difference/temperature))
        should_we_accept = true;
    end

    # return -
    return should_we_accept
end


function solve(problem::MySimulatedAnnealingProblem, initial::Array{Float64,1}, loss::Function)

    # initialize --
    Tᵢ = 1.0;
    results = Array{Dict{String,Any},1}()
    x̂ = initial;

    # get stuff from the problem -
    number_of_iterations = problem.number_of_iterations
    number_of_iterations_per_T = problem.number_of_iterations_per_T
    α = problem.α;
    bounds = problem.bounds;

    # main loop -
    for i ∈ 1:number_of_iterations

        # build new results dict -
        results_dict = Dict{Any,Any}()

        # update T -
        Tᵢ = _temperature(Tᵢ, α);
        
        # search
        for j ∈ 1:number_of_iterations_per_T

            # generate a new soln -
            x′ = _neighbor(x̂, bounds);

            # compute the difference between the candidate and the best soln -
            Δᵢ = loss(x′, problem) - loss(x̂, problem)
            if (_accept(Δᵢ,Tᵢ) == true)
                x̂ = x′;
            end

            # package the results -
            results_dict["T"] = Tᵢ
            results_dict["Δ"] = Δᵢ
            results_dict["x̂"] = x̂
            results_dict["accept"] =  _accept(Δᵢ,Tᵢ)
            results_dict["f"] = loss(x̂, problem)

             # grab -
            push!(results, results_dict);
        end
    end

    # build the soln -
    soln = MySimulatedAnnealingProblemSolution();
    soln.solution = x̂
    soln.value = loss(x̂,problem)

    # return -
    return (soln, results);
end