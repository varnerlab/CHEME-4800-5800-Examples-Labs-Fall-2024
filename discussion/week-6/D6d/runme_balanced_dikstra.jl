include("Include.jl");

# load up the balanced example -
balanced_edgefile = joinpath(_PATH_TO_DATA, "Bipartite.edgelist");
balanced_graphmodel = readedgesfile(balanced_edgefile) |> edges -> build(MySimpleDirectedGraphModel, edges); # wow - this is ammaaazing!

# run Dijkstra's algorithm -
(d,p) = computeshortestpaths(balanced_graphmodel, balanced_graphmodel.nodes[1], DikjstraAlgorithm());

# compute flow vector -
f = flow(balanced_graphmodel, d, p);

# visualize the flow -
include("visualize.jl");