abstract type AbstractLinearProgrammingProblemType end

"""
    mutable struct MyLinearProgrammingProblemModel <: AbstractLinearProgrammingProblemType

This is a mutable struct that defines the data structure for a linear programming problem model.

### Fields
- `A::Array{Float64,2}`: constraint matrix
- `b::Array{Float64,1}`: right-hand side vector
- `c::Array{Float64,1}`: objective function coefficient matrix
- `lb::Array{Float64,1}`: lower bound vector
- `ub::Array{Float64,1}`: upper bound vector
"""
mutable struct MyLinearProgrammingProblemModel <: AbstractLinearProgrammingProblemType
    
    # data -
    A::Array{Float64,2}     # constraint matrix
    b::Array{Float64,1}     # right-hand side vector
    c::Array{Float64,1}     # objective function coefficient matrix
    lb::Array{Float64,1}    # lower bound vector
    ub::Array{Float64,1}    # upper bound vector

    # constructor
    MyLinearProgrammingProblemModel() = new();
end

"""
    mutable struct MyLinearProgrammingDualProblemModel <: AbstractLinearProgrammingProblemType

This is a mutable struct that defines the data structure for a dual linear programming problem model.

### Fields
- `A::Array{Float64,2}`: constraint matrix
- `b::Array{Float64,1}`: right-hand side vector
- `c::Array{Float64,1}`: objective function coefficient vector
- `lb::Array{Float64,1}`: lower bound vector
- `ub::Array{Float64,1}`: upper bound vector
"""
mutable struct MyLinearProgrammingDualProblemModel <: AbstractLinearProgrammingProblemType
    
    # data -
    A::Array{Float64,2}     # constraint matrix
    b::Array{Float64,1}     # right-hand side vector
    c::Array{Float64,1}     # objective function coefficient vector
    lb::Array{Float64,1}    # lower bound vector
    ub::Array{Float64,1}    # upper bound vector

    # constructor
    MyLinearProgrammingDualProblemModel() = new();
end