function sample(distribution::ContinuousUnivariateDistribution, 
    number_of_samples::Int64 = 100)::Array{Float64,1}
    
    # check: should we check to see if the parameters are valid?
    # ...
    
    # calls the rand function from the Distributions package
    return rand(distribution, number_of_samples) 
end