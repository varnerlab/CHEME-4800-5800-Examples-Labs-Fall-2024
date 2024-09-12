include("Include.jl")

function main()

    # initialize -
    collection_of_sample_length = [10,100,200,400,800,1000];
    results = Array{Any, 2}(undef, length(collection_of_sample_length), 2);

    counter = 1;
    for i ∈ collection_of_sample_length
       
        tmp_array = Array{Int64,1}(undef, i) |> x -> fill!(x, 0);
        
        # set the values, at the start and end -
        tmp_array[1] = 1;
        tmp_array[end] = 9;

        tvals = @benchmark twosum($tmp_array, 10);
        results[counter, 1] = i;
        results[counter, 2] = median(tvals.times);
        counter += 1;

        @show i;
    end

    return results;
end

r = main();