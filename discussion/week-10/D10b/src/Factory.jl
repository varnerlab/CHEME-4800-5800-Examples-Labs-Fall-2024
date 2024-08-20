
"""
    build(type::Type{MySimulatedAnnealingProblem}, data::NamedTuple) -> MySimulatedAnnealingProblem
"""
function build(modeltype::Type{MySimulatedAnnealingProblem}, data::NamedTuple)::MySimulatedAnnealingProblem

    # initialize -
    model = MySimulatedAnnealingProblem();

    # if we have options, add them to the contract model -
    if (isempty(data) == false)
        for key ∈ fieldnames(modeltype)
            
            # convert the field_name_symbol to a string -
            field_name_string = string(key)

            # check the for the key -
            if (haskey(data, key) == false)
                throw(ArgumentError("NamedTuple is missing: $(field_name_string)"))
            end

            # get the value -
            value = data[key]

            # set -
            setproperty!(model, key,  value)
        end
    end

    # return -
    return model;
end