abstract type AbstractLearningModel end
abstract type AbstractWorldModel end
abstract type AbstractSamplingModel end

"""
    ThompsonSamplingModel <: AbstractSamplingModel

A mutable struct that represents a Thompson Sampling model.

### Fields
- `α::Array{Float64,1}`: The α array - number of successes
- `β::Array{Float64,1}`: The β array - number of failures
- `K::Int64`: The number of actions (arms)
"""
mutable struct ThompsonSamplingModel <: AbstractSamplingModel

    # data -
    α::Array{Float64,1}
    β::Array{Float64,1}
    K::Int64

    # constructor -
    ThompsonSamplingModel() = new();
end

"""
    EpsilonSamplingModel <: AbstractSamplingModel

A mutable struct that represents an Epsilon-Greedy Thompson Sampling model.

### Fields
- `α::Array{Float64,1}`: The α array - number of successes
- `β::Array{Float64,1}`: The β array - number of failures
- `K::Int64`: The number of actions (arms)
- `ϵ::Float64`: The epsilon value (exploration factor)
"""
mutable struct EpsilonSamplingModel <: AbstractSamplingModel

    # data -
    α::Array{Float64,1}
    β::Array{Float64,1}
    K::Int64
    ϵ::Float64

    # constructor -
    EpsilonSamplingModel() = new();
end

"""
    MyQLearningAgentModel <: AbstractLearningModel

A mutable struct that represents a Q-Learning agent.

### Fields
- `states::Array{Int,1}`: The states
- `actions::Array{Int,1}`: The actions
- `γ::Float64`: The discount factor
- `α::Float64`: The learning rate
- `Q::Array{Float64,2}`: The Q-array
"""
mutable struct MyQLearningAgentModel <: AbstractLearningModel

    # data -
    states::Array{Int,1}
    actions::Array{Int,1}
    γ::Float64
    α::Float64 
    Q::Array{Float64,2}

    # constructor
    MyQLearningAgentModel() = new();
end

"""
    MyRectangularGridWorldModel <: AbstractWorldModel

A mutable struct that represents a rectangular grid world.

### Fields
- `number_of_rows::Int`: The number of rows
- `number_of_cols::Int`: The number of columns
- `coordinates::Dict{Int,Tuple{Int,Int}}`: The coordinates dictionary. Key is the state, value is the (row,col) tuple
- `states::Dict{Tuple{Int,Int},Int}`: The states dictionary. Key is the (row,col) tuple, value is the state
- `moves::Dict{Int,Tuple{Int,Int}}`: The moves dictionary. Key is the action, value is the (row,col) move tuple
- `rewards::Dict{Int,Float64}`: The rewards dictionary. Key is the state index, value is the reward
"""
mutable struct MyRectangularGridWorldModel <: AbstractWorldModel

    # data -
    number_of_rows::Int
    number_of_cols::Int
    coordinates::Dict{Int,Tuple{Int,Int}}
    states::Dict{Tuple{Int,Int},Int}
    moves::Dict{Int,Tuple{Int,Int}}
    rewards::Dict{Int,Float64}

    # constructor -
    MyRectangularGridWorldModel() = new();
end