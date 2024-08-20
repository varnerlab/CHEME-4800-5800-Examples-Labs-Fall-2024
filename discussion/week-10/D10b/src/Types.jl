abstract type AbstractProblemModel end
abstract type AbstractSolutionModel end

mutable struct MySimulatedAnnealingProblem <: AbstractProblemModel

    # data -
    number_of_iterations::Int
    number_of_iterations_per_T::Int
    α::Float64
    bounds::Array{Float64,2}

    # constructor -
    MySimulatedAnnealingProblem() = new();
end

mutable struct MySimulatedAnnealingProblemSolution <: AbstractSolutionModel

    # data -
    solution::Array{Float64,1}
    value::Float64

    # constructor -
    MySimulatedAnnealingProblemSolution() = new();
end