# Load the include -
include("Include.jl");

# specifcy a file to read -
path_to_data_file = joinpath(_PATH_TO_DATA,"Bubblesort.dat");

# read the file -
data = bestreadfile(path_to_data_file);