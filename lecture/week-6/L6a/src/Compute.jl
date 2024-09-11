"""
    myhash(key::String, β::Int64, size::Int64)::Int64

Convert a String `key` to `Int` for an array of type `size`:
"""
function myhash(key::String; β::Int64 = 31, size::Int64 = 1000)::Int64

    # initialize -
    hash = 0

    # main loop -
    for i ∈ eachindex(key)
        keyvalue = key[i];
        tmpvalue = hash*β + convert(Int, keyvalue)
        hash = mod(tmpvalue, size)
    end

    # return -
    return hash
end