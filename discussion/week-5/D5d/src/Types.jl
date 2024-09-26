abstract type AbstractPolicyModel end

"""
    mutable struct MyOneDimensionalElementarWolframRuleModel <: AbstractPolicyModel

The `MyOneDimensionalElementarWolframRuleModel` mutable struct represents a one-dimensional elementary Wolfram rule model.

### Required fields
- `index::Int`: The index of the rule
- `radius::Int`: The radius, i.e, the number of cells that influence the next state for this rule
- `rule::Dict{Int,Int}`: A dictionary that holds the rule where the `key` is the binary representation of the neighborhood and the `value` is the next state
"""
mutable struct MyOneDimensionalElementarWolframRuleModel <: AbstractPolicyModel
    
    # data
    index::Int
    radius::Int
    number_of_colors::Int
    rule::Dict{Int, Int}

    # constructor -
    MyOneDimensionalElementarWolframRuleModel() = new();
end

mutable struct MyOneDimensionalProbabilisticWolframRuleModel <: AbstractPolicyModel
    
    # data
    index::Int
    radius::Int
    number_of_colors::Int
    rule::Dict{Int, Int}

    # constructor -
    MyOneDimensionalProbabilisticWolframRuleModel() = new();
end