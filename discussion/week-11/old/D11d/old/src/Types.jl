abstract type MyAbstractAgentType end

mutable struct MySentimentAgentModel <: MyAbstractAgentType

    # data -
    α::Array{Float64,1}
    β::Array{Float64,1}
    K::Int64
    ϵ::Float64

    # constructor -
    MySentimentAgentModel() = new();
end