abstract type AbstractSequenceModel end
abstract type AbstractIterationModel end

mutable struct MyFibonacciSequenceModel <: AbstractSequenceModel

    # data -
    n::Int64 # number of elements in the sequence
    sequence::Dict{Int64, Int64} # the sequence itself

    # constructor -
    MyFibonacciSequenceModel() = new();
end

struct MyForLoopIterationModel <: AbstractIterationModel
    MyForLoopIterationModel() = new();
end

struct MyWhileLoopIterationModel <: AbstractIterationModel
    MyWhileLoopIterationModel() = new();
end
