


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
function build(modeltype::Type{MySimpleLinearChoiceProblem}, data::NamedTuple)::MySimpleLinearChoiceProblem
    
    
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