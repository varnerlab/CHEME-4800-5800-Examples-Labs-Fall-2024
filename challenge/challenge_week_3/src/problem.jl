function twosum(nums::Array{T, 1}, target::T)::Union{Nothing, Array{Int64,1}} where T <: Number
    
    # initialize -
    # index_array = Array{Int64,1}();

    # TODO: implement the twosum logic here
    # throw("Twosum not implemented yet!");

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