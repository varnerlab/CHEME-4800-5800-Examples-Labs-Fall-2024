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