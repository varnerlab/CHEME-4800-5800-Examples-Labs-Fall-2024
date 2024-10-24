# load the include file
include("Include.jl")

# load up the edge list and node capacities -
balanced_edgefile = joinpath(_PATH_TO_DATA, "Bipartite.edgelist");
balanced_nodecapacityfile = joinpath(_PATH_TO_DATA, "Bipartite.nodecapacity");

# build the graph model, and node capacities -
my_graphmodel = readedgesfile(balanced_edgefile) |> edges -> build(MySimpleDirectedGraphModel, edges); # wow - this is ammaaazing!
my_nodecapacities = readnodecapacityfile(balanced_nodecapacityfile);

# build the right hand side vector, and update the graph model -
b = [0.0 for _ ∈ 1:length(my_graphmodel.nodes)]; # initialize the right-hand side vector
for (k, v) ∈ my_nodecapacities
    
    # get data -
    node_in_degree = v[1];
    node_out_degree = v[2];
    node_type = v[3];
    
    # update the right-hand side vector -
    if node_type == 0 # this is a source node
        b[k] = -node_out_degree;
    elseif node_type == 1 # this is a sink node
        b[k] = node_in_degree;
    end
end

# update the graph model -
my_graphmodel.b = b;
