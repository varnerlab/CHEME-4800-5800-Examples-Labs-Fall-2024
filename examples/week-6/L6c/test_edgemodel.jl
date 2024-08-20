# setup -
include("Include.jl")

# load the data -
path_to_data_file = joinpath(_PATH_TO_DATA, "SimpleGraph.txt");

# read -
edges = readedgesfile(path_to_data_file)