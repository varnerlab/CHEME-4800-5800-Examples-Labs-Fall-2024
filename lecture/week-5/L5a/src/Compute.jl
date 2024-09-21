"""
    function quicksort(arr::Array{T,1}) -> Array{T,1} where T <: Number

The `quicksort` function sorts an array of numbers using the quicksort algorithm.

### Arguments
- `arr::Array{T,1}`: An array of numbers to be sorted where `T` is a subtype of `Number`.

### Returns
- `Array{T,1}`: A sorted array of numbers where `T` is a subtype of `Number`.

See: https://en.wikipedia.org/wiki/Quicksort
"""
function quicksort(arr::Array{T,1})::Array{T,1} where T <: Number
    
    # initialize -
    smaller_array = Array{T,1}()
    larger_array = Array{T,1}()

    # Base case: if we only have element, return the array
    if length(arr) <= 1
        return arr
    else
        
        # Recursive case: we have more than one element in the array 
        # 1. grab the *last* element - we call this the pivot element
        # 2. partition arr into elements that are smaller and larger than the pivot element

        # grab the *last* element of the array - this is the pivot element
        pivot = arr[end]

        # populate the smaller array -
        for x ∈ arr[1:end-1]
            
            # if this value of x is *smaller or equal to* the pivot element, it goes in the smaller array
            # otherwise, x goes in the larger array
            if (x <= pivot)
                push!(smaller_array, x);
            else
                push!(larger_array, x);
            end
        end

        # show the user what is going on ...
        # println("small: $(smaller_array) pivot: $(pivot) large: $(larger_array)")

        # return: this line creates (and returns) an array with the smaller part, the pivot and the larger part
        return [quicksort(smaller_array); pivot; quicksort(larger_array)]
    end
end

"""
    function bubblesort(arr::Array{T,1}) -> Array{T,1} where T <: Number

The `bubblesort` function sorts an array of numbers using the bubblesort algorithm.

### Arguments
- `arr::Array{T,1}`: An array of numbers to be sorted where `T` is a subtype of `Number`.

### Returns
- `Array{T,1}`: A sorted array of numbers where `T` is a subtype of `Number`.

See: https://en.wikipedia.org/wiki/Bubble_sort
"""
function bubblesort(arr::Array{T,1})::Array{T,1} where T <: Number

    # initialize -
    N = length(arr)

    # main -
    for i ∈ 1:N
        for j ∈ 1:N-i
            if arr[j] > arr[j+1]

                # swap that values at j and j+1
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
    fibonacci_for_loop_dict(n::Int64) -> Dict{Int64,Int64}

Computes the `fibonacci` number for n where n >= 1 using a `for` loop.

See: https://en.wikipedia.org/wiki/Fibonacci_number
"""
function fibonacci_for_loop_dict(n::Int64)::Dict{Int64,Int64}

    # implement a fibonacci function that uses a for loop to compute the fibonacci sequence. 
    # The fibonacci sequence is stored in a dictionary. Inside the for loop use an if else to check for the 0, 1 cases

    # initialize -
    fibonacci_seq = Dict{Int64, Int64}()

    # main loop -
    for i ∈ 0:n
        
        # conditional logic: hardcode 0, 1 else gets all other cases
        if (i == 0)
            fibonacci_seq[i] = 0; 
        elseif (i == 1)
            fibonacci_seq[i] = 1;
        else
            fibonacci_seq[i] = fibonacci_seq[i-1] + fibonacci_seq[i-2]
        end
    end

    # return -
    return fibonacci_seq
end

"""
    fibonacci_recurisive(n::Int64) -> Int64

Computes the `fibonacci` number for n where n >= 1.

See: https://en.wikipedia.org/wiki/Fibonacci_number
"""
function fibonacci_recursive(n::Int64)::Int64

    if (n == 0)  # base case
        return 0;
    elseif (n == 1) # base case
        return 1; 
    else # recursive case
        return fibonacci_recursive(n-1) + fibonacci_recursive(n-2);
    end
end

"""
    fibonacci!(n::Int64, series::Dict{Int64,Int64}) -> Nothing

Recursively computes the `fibonacci` sequence for 0 to n where n >= 1.
Stores series in `series::Dict`.

See: https://en.wikipedia.org/wiki/Fibonacci_number
"""
function fibonacci!(n::Int64, series::Dict{Int64,Int64})

    if (n == 0)  # base case
        return 0;
    elseif (n == 1) # base case
        return 1; 
    else
        series[n] = fibonacci!(n-1, series) + fibonacci!(n-2, series);
    end
end

"""
    memoization_fibonacci!(n::Int64, series::Dict{Int64,Int64}) -> Nothing

Recursively computes the `fibonacci` sequence for 0 to n where n >= 1.
Stores series in `series::Dict`.

See: https://en.wikipedia.org/wiki/Fibonacci_number
"""
function memoization_fibonacci!(n::Int64, series::Dict{Int64,Int64})

    if (n == 0)  # base case
        series[n] = 0;
    elseif (n == 1) # base case
        series[n] = 1;
    elseif (haskey(series,n) == true) # memoization
        return series[n];
    else # recursive case
        series[n] = memoization_fibonacci!(n-1, series) + memoization_fibonacci!(n-2, series);
    end
end


