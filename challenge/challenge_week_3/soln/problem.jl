"""
    twosum(nums::Array{T, 1}, target::T)::Union{Nothing, Array{Int64,1}} where T <: Number

This implementation is a brute force solution to the twosum problem. 
It iterates through the array and checks if the sum of the current element and any other element in the array is equal to the target. 
If a solution is found, it returns the indices of the two elements that sum up to the target. If no solution is found, it returns nothing.

# Arguments
- nums::Array{T, 1}: An array of numbers
- target::T: The target sum

# Returns
- Union{Nothing, Array{Int64,1}}: An array of indices of the two elements that sum up to the target, or nothing if no solution is found
"""
function twosum(nums::Array{T, 1}, target::T)::Union{Nothing, Array{Int64,1}} where T <: Number
    
    # initialize -
    index_array = Array{Int64,1}();
    number_of_elements = length(nums);

    # main
    for i ∈ 1:number_of_elements
        pivot = nums[i];
        for j = (i+1):number_of_elements
            if (pivot + nums[j]) == target
                push!(index_array, i);
                push!(index_array, j);
                return index_array;
            end
        end
    end

    # if no solution found, return nothing
    return nothing;
end