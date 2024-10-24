
"""
    function build(modeltype::Type{T}, data::NamedTuple) where T <: AbstractLinearProgrammingProblemType

This function builds a linear programming problem model of type T from the data in the NamedTuple data.

### Arguments
- modeltype::Type{T}: The type of the model to build.
- data::NamedTuple: The data to use to build the model.

### Returns
- T: An instance of the model type `T` which is a subtype of `AbstractLinearProgrammingProblemType`. 
"""
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