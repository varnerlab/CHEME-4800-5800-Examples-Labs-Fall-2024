abstract type AbstractChemicalReactionType end
abstract type AbstractConnectivityMatrixType end
abstract type AbstractLinearProgrammingProblemType end


"""
    MyChemicalReactionModel

The `MyChemicalReactionModel` type is a mutable model of a chemical reaction.
It contains the fields `name`, `reactants`, `products`, `reversible` and `stoichiometry`.
"""
mutable struct MyChemicalReactionModel <: AbstractChemicalReactionType
    
    # data -
    name::String
    reactants::String
    products::String
    reversible::Bool
    stoichiometry::Dict{String, Float64}

    # constructor
    MyChemicalReactionModel() = new()
end

"""
    MyStoichiometricMatrixModel

The `MyStoichiometricMatrixModel` type is a mutable model of a stoichiometric matrix. 
It contains the fields `species`, `reactions` and `matrix`.
"""
mutable struct MyStoichiometricMatrixModel <: AbstractConnectivityMatrixType
    
    # data -
    species::Array{String,1}
    reactions::Array{String,1}
    matrix::Array{Float64,2}

    # constructor
    MyStoichiometricMatrixModel() = new()
end

mutable struct MyLinearProgrammingProblemModel <: AbstractLinearProgrammingProblemType
    
    # data -
    A::Array{Float64,2}     # constraint matrix
    b::Array{Float64,1}     # right-hand side vector
    c::Array{Float64,1}     # objective function coefficient vector
    lb::Array{Float64,1}    # lower bound vector
    ub::Array{Float64,1}    # upper bound vector

    # constructor
    MyLinearProgrammingProblemModel() = new();
end

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