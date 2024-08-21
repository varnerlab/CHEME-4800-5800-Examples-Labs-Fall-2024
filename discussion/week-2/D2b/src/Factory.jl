function build(distribution::Type{T}; 
    μ::Float64 = 0.0, σ::Float64 = 1.0)::Union{ContinuousUnivariateDistribution, Nothing} where T <: ContinuousUnivariateDistribution
    
    # check: should we check to see if the parameters are valid?
    # @assert σ > 0.0 "Standard deviation must be positive"
    # σ = abs(σ) # force σ to be positive - agressive programming!!
    if (σ <= 0.0)
        return nothing
    end

    # this will return a distribution of type T
    return distribution(μ,σ)
end