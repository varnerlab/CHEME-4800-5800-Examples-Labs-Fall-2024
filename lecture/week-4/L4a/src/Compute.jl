
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