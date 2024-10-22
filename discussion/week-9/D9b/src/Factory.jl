


"""
    build(modeltype::Type{VLLinearUtilityFunction}, data::NamedTuple) -> VLLinearUtilityFunction
"""
function build(modeltype::Type{VLLinearUtilityFunction}, data::NamedTuple)::VLLinearUtilityFunction
    model = modeltype()
    model.α = data.α
    return model
end

"""
    build(modeltype::Type{MySimpleLinearChoiceProblem}, data::NamedTuple) -> MySimpleLinearChoiceProblem
"""
function build(modeltype::Type{T}, data::NamedTuple)::T where {T<:AbstractSimpleChoiceProblem}
    
    # initialize -
    model = modeltype()

    # load data -
    model.α = data.α
    model.c = data.c
    model.I = data.I
    model.bounds = data.bounds
    model.initial = data.initial

    # return -
    return model
end


function build(modeltype::Type{T}, data::NamedTuple) where T <: AbstractLinearProgrammingProblemType

    # initialize -
    model = modeltype(); # build an empty model 

    # set the data -
    model.A = data.A;
    model.b = data.b;
    model.c = data.c;
    model.lb = data.lb;
    model.ub = data.ub;

    # return -
    return model;
end