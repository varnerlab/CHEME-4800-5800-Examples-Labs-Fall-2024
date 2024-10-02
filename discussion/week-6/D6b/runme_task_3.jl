include("Include.jl")

# load up the directed graph -
adj_matrix = readdlm(joinpath(_PATH_TO_DATA, "Testgraph-undirected.dat"), Int64, comment_char='#', comments=true);
dag = build(MySimpleUndirectedGraphModel, adj_matrix);

# run DFS in the directed graph -
BFS(dag, dag.nodes[0]);