abstract type AbstractKeggReaction end

"""
    MyKeggReactionModel <: AbstractKeggReaction

Holds chemical reaction information from Kegg. See the Reactions.net file
"""
mutable struct MyKeggReactionModel <: AbstractKeggReaction
    
    # data -
    name::String
    reactants::String
    products::String

    # constructor
    MyKeggReactionModel() = new()
end