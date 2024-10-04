abstract type AbstractChemicalReactionType end
abstract type AbstractConnectivityMatrixType end
abstract type AbstractLinearSolverType end


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

# let's create two "tag" types -
struct MyJacobiMethod <: AbstractLinearSolverType
    MyJacobiMethod() = new();
end

struct MyGaussSeidelMethod <: AbstractLinearSolverType
    MyGaussSeidelMethod() = new();
end

struct MyGaussianEliminationMethod <: AbstractLinearSolverType
    MyGaussianEliminationMethod() = new();
end