# run task 1 -
include("runme_task_1.jl");

# Let's specify a regularization parameter -
λ = 1.0;

# Compute the *expected* θ vector for each firm in our dataset, and store in a dictionary
# using the θ function using matrix inv calculation directly 
parameters_matrix = Dict{String, MySingleIndexModel}();
for ticker ∈ my_list_of_tickers

    # what index is this ticker?
    ticker_index = findfirst(x->x==ticker, my_list_of_tickers);

    # compute the expected θ vector for firm i
    θᵢ = θ(market_matrix, ticker_index, Rₘ, λ = λ);

    # store MySingleIndexModel object in dictionary
    parameters_matrix[ticker] = build(MySingleIndexModel, (
        α = θᵢ[1],
        β = θᵢ[2],
        r = risk_free_rate, # risk-free rate
        ϵ = errormodel(market_matrix, ticker_index, θᵢ, Rₘ)
    ));
end