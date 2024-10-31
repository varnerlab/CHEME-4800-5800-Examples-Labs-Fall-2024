abstract type AbstractSimpleChoiceProblem end


mutable struct MySimpleBinaryVariableLinearChoiceProblem <: AbstractSimpleChoiceProblem

    # data -
    α::Array{Float64,1}
    c::Array{Float64,1}
    I::Float64
    bounds::Array{Int64,2}
    initial::Array{Int64,1}
    C::Union{Nothing, Array{Int64,2}}

    # constructor
    MySimpleBinaryVariableLinearChoiceProblem() = new();
end