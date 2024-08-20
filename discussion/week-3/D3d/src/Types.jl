abstract type AbstractNumericalRecordType end

mutable struct MyRuntimeNumericalRecordType <: AbstractNumericalRecordType

    # data -
    N::Int64
    μ::Float64
    σ::Float64

    # constructor -
    MyRuntimeNumericalRecordType(n::Int64, data::Array{Float64,1}) = new(n, data[1], data[2]);
end