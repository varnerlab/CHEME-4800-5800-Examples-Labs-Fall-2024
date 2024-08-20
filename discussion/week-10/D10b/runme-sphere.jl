# include the include -
include("Include.jl")

# setup the objective function -
function _sphere(x::Array{Float64,1}, problem::MySimulatedAnnealingProblem)::Float64

    # setup -
    d = length(x);

    # compute -
    term_2 = Array{Float64,1}(undef,d);
    for i ∈ 1:d
        term_2[i] = x[i]^2
    end

    # return -
    return sum(term_2);
end

# build problem -
bounds = [
    -5.12 5.12;
    -5.12 5.12;
]
problem = build(MySimulatedAnnealingProblem, (
    number_of_iterations = 100,
    number_of_iterations_per_T = 100,
    α = 0.999,
    bounds = bounds
));

# call our SA routine -
xₒ = [5.1,5.1];
(soln, results) = solve(problem, xₒ, _sphere);

