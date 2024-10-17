abstract type AbstractReturnModel end
abstract type AbstractLearningMethod end

mutable struct MySingleIndexModel <: AbstractReturnModel

    # model -
    α::Float64          # firm specific unexplained return
    β::Float64          # relationship between the firm and the market
    r::Float64          # risk free rate of return 
    ϵ::Distribution     # random shocks 

    # constructor -
    MySingleIndexModel() = new()
end

struct MySVDLearingMethod <: AbstractLearningMethod
    MySVDLearingMethod() = new()
end

struct MyMatrixAlgebraLearningMethod <: AbstractLearningMethod
    MyMatrixAlgebraLearningMethod() = new()
end