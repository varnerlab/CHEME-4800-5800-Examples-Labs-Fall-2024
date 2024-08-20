# setup -
include("Include.jl")

# load the data -
path_to_data_file = joinpath(_PATH_TO_DATA, "soc-sign-bitcoinalpha.csv");
# path_to_data_file = joinpath(_PATH_TO_DATA, "SimpleGraph.txt");
# path_to_data_file = joinpath(_PATH_TO_DATA, "Cit-HepPh.txt");

# read the edges -
myedges = readedgesfile(path_to_data_file, delim=',', comment='#')

# build the graph -
dag = build(MySimpleDirectedGraphModel, myedges);
# dag = build(SimpleDiGraph, myedges);
BFS(dag, dag.nodes[1], verbose=true)
# (d,p) = computeshortestpaths(dag, dag.nodes[0], DikjstraAlgorithm())