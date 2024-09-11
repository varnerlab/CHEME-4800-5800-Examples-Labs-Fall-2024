function partition(data::Array{Float64,2}; 
    trainfraction::Float64)

    # initialize -
    (number_of_rows) = size(data,1);

    # compute how many rows we'll have in train, and test
    train_index = 1:(Int(trainfraction*number_of_rows));
    test_index =(train_index.stop):number_of_rows
    
    # split -
    train_data = data[train_index,:];
    test_data = data[test_index,:];

    return (train_data, test_data)
end

function partition(data::Array{Float64,1}; 
    trainfraction::Float64)

    # initialize -
    (number_of_rows) = size(data,1);

    # compute how many rows we'll have in train, and test
    train_index = 1:(Int(trainfraction*number_of_rows));
    test_index =(train_index.stop):number_of_rows
    
    # split -
    train_data = data[train_index];
    test_data = data[test_index];

    return (train_data, test_data)
end