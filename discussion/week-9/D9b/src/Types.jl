abstract type AbstractSimpleChoiceProblem end
abstract type AbstractUtilityFunctionType end
abstract type AbstractLinearProgrammingProblemType end

mutable struct MySimpleLinearChoiceProblem <: AbstractSimpleChoiceProblem

    # data -
    α::Array{Float64,1}
    c::Array{Float64,1}
    I::Float64
    bounds::Array{Float64,2}
    initial::Array{Float64,1}

    # constructor
    MySimpleLinearChoiceProblem() = new();
end

mutable struct MySimpleDualLinearChoiceProblem <: AbstractSimpleChoiceProblem

    # data -
    α::Array{Float64,1}
    c::Array{Float64,1}
    I::Array{Float64,1}
    bounds::Array{Float64,2}
    initial::Array{Float64,1}

    # constructor
    MySimpleDualLinearChoiceProblem() = new();
end

mutable struct VLLinearUtilityFunction <: AbstractUtilityFunctionType
   
    # data -
    α::Union{Nothing, Array{Float64,1}} # parameters -

    # constructor -
    VLLinearUtilityFunction() = new()
end

mutable struct MyLinearProgrammingDualProblemModel <: AbstractLinearProgrammingProblemType
    
    # data -
    A::Union{Array{Float64,2}, Array{Float64,1}}     # constraint matrix
    b::Array{Float64,1}     # right-hand side vector
    c::Union{Array{Float64,2}, Array{Float64,1}}     # objective function coefficient matrix (vector)
    lb::Array{Float64,1}    # lower bound vector
    ub::Array{Float64,1}    # upper bound vector

    # constructor
    MyLinearProgrammingDualProblemModel() = new();
end