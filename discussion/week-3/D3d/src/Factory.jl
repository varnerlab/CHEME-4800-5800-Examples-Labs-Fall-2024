function _build(modeltype::Type{MyRuntimeNumericalRecordType}, data::NamedTuple)

    # get data from the NamedTuple -
    N = data.N;
    μ = data.mean;
    σ = data.std;

    # checks?
    # ...

    # create the an empty instance of the modeltype, and then add data to it
    model = modeltype();
    model.N = N;
    model.μ = μ;
    model.σ = σ;

    # return the populated model -
    return model;
end

"""
    function build(record::Type{T}, data::NamedTuple) -> T where T <: AbstractNumericalRecordType

The function `build` creates an instance of a mutable struct that is a subtype of the abstract type `AbstractNumericalRecordType` from the data stored in a NamedTuple. 

### Arguments
- `record::Type{T}` - the type of the mutable struct to create. Must be a subtype of `AbstractNumericalRecordType`.
- `data::NamedTuple` - the data to use to populate the mutable struct.

### Returns
- `T` - an instance of the mutable struct of type `record::T` populated with the data from `data::NamedTuple`.
"""
function build(record::Type{T}, data::NamedTuple)::T where T <: AbstractNumericalRecordType 
    return _build(record, data);
end