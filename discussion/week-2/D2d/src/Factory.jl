function build(modeltype::Type{MyFibonacciSequenceModel}, data::NamedTuple)
    
    # initialize -
    model = modeltype();
    n = data.n;

    # check: is the value of n passed in by the user legit? n>=1
    # ...

    model.n = n;
    model.sequence = Dict{Int64, Int64}(); # initialize the sequence with an empty dictionary

    # return -
    return model
end