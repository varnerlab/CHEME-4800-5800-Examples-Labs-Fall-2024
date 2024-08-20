"""
    function bubble_sort(array::Array{T,1}; 
        sounds::Union{Nothing, Dict{Int64, Tuple{Matrix{Float64}, Float32}}} = nothing)::Array{T,1} where T <: Number

Sorts an `array` of `Numbers` into ascending order using the `Bubble Sort` algorithm. \\
If the `sounds` dictionary is provided, then the sound of the array at each iteration is played. \\
This is a `non-mutating` function.

### Arguments
- `array::Array{T,1}`: the array to be sorted where `T` is a subtype of `Number`.\
- `sounds::Union{Nothing, Dict{Int64, Tuple{Matrix{Float64}, Float32}}} = nothing`: a dictionary of sounds where the keys are integers and the values are the sound matrix and the sampling frequency.

### More information
* Algorithm: https://en.wikipedia.org/wiki/Bubble_sort
"""
function bubble_sort(array::Array{T,1}; 
    sounds::Union{Nothing, Dict{Int64, Tuple{Matrix{Float64}, Float32}}} = nothing)::Array{T,1} where T <: Number

    # initialize -
    arr = copy(array) # make a copy of the array
    N = length(arr) # how many elements in the array?

    # main -
    for i ∈ 1:N

        if (sounds !== nothing)
            @show i, arr
            _play_sound(arr; sounds=sounds)
        end
        
        for j ∈ 1:N-i
            if arr[j] > arr[j+1]

                # TODO: swap that values at j and j+1
                tmp = arr[j]
                arr[j] = arr[j+1]
                arr[j+1] = tmp

            end
        end
    end

    # return sorted array -
    return arr
end

"""
    function bubble_sort!(array::Array{T,1}; 
        sounds::Union{Nothing, Dict{Int64, Tuple{Matrix{Float64}, Float32}}} = nothing)::Array{T,1} where T <: Number

Sorts an `array` of `Numbers` into ascending order using the `Bubble Sort` algorithm. \\
If the `sounds` dictionary is provided, then the sound of the array at each iteration is played. \\
This is a `mutating` function.

### Arguments
- `array::Array{T,1}`: the array to be sorted where `T` is a subtype of `Number`.
- `sounds::Union{Nothing, Dict{Int64, Tuple{Matrix{Float64}, Float32}}} = nothing`: a dictionary of sounds where the keys are integers and the values are the sound matrix and the sampling frequency.

### More information
* Algorithm: https://en.wikipedia.org/wiki/Bubble_sort
"""
function bubble_sort_2(array::Array{T,1}; 
    sounds::Union{Nothing, Dict{Int64, Tuple{Matrix{Float64}, Float32}}} = nothing)::Array{T,1} where T <: Number

    # initialize -
    arr = array # do nothing, just use the array directly
    N = length(arr) # how many elements in the array?

    # main -
    for i ∈ 1:N

        if (sounds !== nothing)
            @show i, arr
            _play_sound(arr; sounds=sounds)
        end

        for j ∈ 1:N-i
            if arr[j] > arr[j+1]

                # TODO: swap that values at j and j+1
                tmp = arr[j]
                arr[j] = arr[j+1]
                arr[j+1] = tmp
            end
        end
    end

    # return sorted array -
    return arr
end