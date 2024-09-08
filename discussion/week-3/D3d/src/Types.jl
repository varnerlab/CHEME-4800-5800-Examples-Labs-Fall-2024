abstract type AbstractNumericalRecordType end

"""
    mutable struct MyMutableNumericalRecordType <: AbstractNumericalRecordType

The mutable struct `MyMutableNumericalRecordType`, which is a subtype of the abstract type `AbstractNumericalRecordType,` has three fields:

- `N::Int64` - the number of trials used to compute the mean and standard deviation.
- `μ::Float64` - the mean of the data.
- `σ::Float64` - the standard deviation of the data.

The constructor `MyMutableNumericalRecordType(n::Int64, data::Array{Float64,1})` creates an instance of `MyMutableNumericalRecordType` with the following values:
"""
mutable struct MyRuntimeNumericalRecordType <: AbstractNumericalRecordType

    # data -
    N::Int64
    μ::Float64
    σ::Float64

    # constructor -
    MyRuntimeNumericalRecordType() = new();
end