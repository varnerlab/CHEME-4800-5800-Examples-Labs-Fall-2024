include("Include.jl")

# load up the directed graph -
adj_matrix = readdlm(joinpath(_PATH_TO_DATA, "Testgraph-undirected.dat"), Int64, comment_char='#', comments=true);
dag = build(MySimpleUndirectedGraphModel, adj_matrix);
visited = Set{Int64}();

# run DFS in the directed graph -
DFS(dag, dag.nodes[0], visited);