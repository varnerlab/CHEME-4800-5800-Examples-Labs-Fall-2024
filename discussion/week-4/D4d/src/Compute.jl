""" 
    hashing(strings::Array{String,1}; 
        size::Int64 = 1024, tokens::Dict{String,Int64} = nothing) -> Array{Int64,1}

Takes a array of strings and returns a vectorized representation of the 
strings using a hashing vectorizer. 

### Arguments
- `strings::Array{String,1}`: An array of strings to vectorize.
- `size::Int64 = 1024`: The size of the vector to return.
- `hash::Dict{String, Int64} = nothing`: A dictionary of tokens to use for vectorization.

### See also
- Feature hashing: https://en.wikipedia.org/wiki/Feature_hashing
"""
# function hashing(strings::Array{String,1}; 
#     size::Int64 = 1024, hash::Dict{String,Int64} = nothing)::Array{Int64,1}

#     # initialize -
#     result = Array{Int64,1}(undef, size);
#     fill!(result, 0); # initialize the result with 0s

#     # iterate through the strings, and compute the hash
#     for string ∈ strings

#         h = nothing;
#         if (string ∈ keys(hash)) == false
#             h = hash["<OOV>"]; # returns the position of the Out of Vocabulary <OOV> token
#         else
#             h = hash[string]; # returns the position of the string in the corpus
#         end

#         i = mod(h, size); # compute the index in the feature vector

#         if (i == 0 || i > size)
#             h = hash["<OOV>"]
#             result[h] += 1; # increment the count of the Out of Vocabulary token
#         else
#             result[i] += 1; # increment the count
#         end
#     end

#     # return the result -
#     return result;
# end

""" 
    hashing(strings::Array{String,1}; 
        size::Int64 = 1024, tokens::Dict{String,Int64} = nothing) -> Array{Int64,1}

Takes a array of strings and returns a vectorized representation of the 
strings using a hashing vectorizer. 

### Arguments
- `strings::Array{String,1}`: An array of strings to vectorize.
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
    for string ∈ strings
        h = hash[string]; # returns the position of the string in the corpus
        i = mod(h, size); # compute the index
        result[i] += 1; # increment the count
    end

    # return the result -
    return result;
end