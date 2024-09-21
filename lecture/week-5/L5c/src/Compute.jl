"""
    function myhash(key::String, β::Int64, size::Int64) -> Int64

The `myhash` function computes a hash value for a given `key` string. 
The hash value is computed using the `β` and `size` parameters. The function returns the hash value as an `Int64`.

### Arguments
- `key::String`: A string to be hashed.
- `β::Int64`: A prime number used in the hash computation. Default is `31`.
- `size::Int64`: The size of the hash table. Default is `1000`.

### Returns
- `Int64`: The hash value for the given `key` string.

"""
function myhash(key::String; β::Int64 = 31, size::Int64 = 1000)::Int64

    # initialize -
    hash = 0

    # main loop -
    for i ∈ eachindex(key)
        keyvalue = key[i];
        hash = (hash*β + convert(Int, keyvalue)) |> x -> mod(x, size);
    end

    # return -
    return hash
end