
"""
    function tokenize(s::String, tokens::Dict{String, Int64}; 
        pad::Int64 = 0, padleft::Bool = false, delim::Char = ' ') -> Array{Int64,1}

### Arguments
- `s::String` - the string to tokenize.
- `tokens::Dict{String, Int64}` - a dictionary of tokens in alphabetical order (key: token, value: position) for the entire document.
- `pad::Int64` - (optional) the number of padding tokens to add to the end of the tokenized string. Default is `0`.
- `padleft::Bool` - (optional) if `true`, the padding tokens are added to the beginning of the tokenized string. Default is `false`.
- `delim::Char` - (optional) the delimiter used in the string. Default is `' '`.

### Returns
- `Array{Int64,1}` - an array of integers representing the vectorized string.
"""
function tokenize(s::String, tokens::Dict{String, Int64}; 
    pad::Int64 = 0, padleft::Bool = false, delim::Char = ' ')::Array{Int64,1}

    # initialize -
    tokenarray = Array{Int64,1}();

    # split the string -
    fields = split(s, delim) .|> String;
    for field ∈ fields
        if haskey(tokens, field)
            push!(tokenarray, tokens[field]);
        else
            push!(tokenarray, tokens["<OOV>"]);
        end
    end

    # -- PAD LOGIC ----------------------------------------------------------- #
    # do we need to pad?
    if (padleft == false && pad > 0)
        N = length(tokenarray);
        foreach(i->push!(tokenarray, tokens["<PAD>"]), (N+1):pad); # pad right
    elseif (padleft == true && pad > 0)
        N = length(tokenarray);
        foreach(i->pushfirst!(tokenarray, tokens["<PAD>"]), (N+1):pad); # pad left
    end
    # ----------------------------------------------------------------------- #

    # return -
    return tokenarray;
end

""" 
    hashing_vectorizer(strings::Array{String,1}; 
        size::Int64 = 1024, tokens::Dict{String,Int64} = nothing) -> Array{Int64,1}

Takes a array of strings and returns a vectorized representation of the 
strings using a hashing vectorizer. 

### Arguments
- `strings::Array{String,1}`: An array of strings to vectorize. These are the tokens in the record or document.
- `size::Int64 = 1024`: The size of the vector to return.
- `hash::Dict{String, Int64} = nothing`: A dictionary of tokens to use for vectorization.

### See also
- Feature hashing: https://en.wikipedia.org/wiki/Feature_hashing
"""
function hashing(strings::Array{String,1}; 
    size::Int64 = 1024, hash::Dict{String,Int64} = nothing)::Array{Int64,1}

    # initialize -
    result = Array{Int64,1}(undef, size);
    fill!(result, 0); # initialize the result with 0s

    # iterate through the strings, and compute the hash
    frequency_dictionary = Dict{Int64, Int64}();
    for string ∈ strings
                
        h = hash[string]; # returns the position of the string in the corpus
        i = mod(h, size); # compute the index
        
        if (haskey(frequency_dictionary, i) == true)
            frequency_dictionary[i] += 1; # increment the count
        else
            frequency_dictionary[i] = 1; # initialize the count
        end
    end

    # populate the result array -
    kv = keys(frequency_dictionary) |> collect |> sort;
    for k ∈ kv
        result[k+1] = frequency_dictionary[k];
    end

    # return the result -
    return result;
end

"""
    partition(input::Array{T,2}, output::Vector{Y}; 
        trainfraction::Float64) -> Tuple{Array{T,2}, Array{T,2}, Vector{Y}, Vector{Y}} where T <: Number where Y <: Number

The `partition` function takes an input matrix and an output vector and randomly partitions the data into training and testing sets.

### Arguments
- `input::Array{T,2}`: a matrix of size `m x n` where `m` is the number of rows and `n` is the number of features.
- `output::Vector{Y}`: a vector of size `m` representing the output values.
- `trainfraction::Float64`: a float representing the fraction of the data to use for training.

### Returns
- `Tuple{Array{T,2}, Array{T,2}, Vector{Y}, Vector{Y}}`: a tuple of `(train_data, test_data, train_output, test_output)`.
"""
function partition(input::Array{T,2}, output::Vector{Y}; 
    trainfraction::Float64) where T <: Number where Y <: Number

    # initialize -
    (number_of_rows) = size(input,1);

    # compute the pivot: this is the number of training examples we'll have
    pivot = round(trainfraction*number_of_rows) |> Int

    # generate a random set of training indexes -
    training_index_set = Set{Int}();
    while (length(training_index_set) <= pivot)
        push!(training_index_set, rand(1:number_of_rows));
    end

    # compute how many rows we'll have in train, and test
    training_index = collect(training_index_set);
    test_index = setdiff(1:number_of_rows, training_index);
    
    # split -
    train_data = input[training_index,:];
    test_data = input[test_index,:];
    train_output = output[training_index];
    test_output = output[test_index];

    # return -
    return (train_data, test_data, train_output, test_output)
end