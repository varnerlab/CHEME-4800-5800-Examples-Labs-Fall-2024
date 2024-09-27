# include -
include("Include.jl")

# ----------------------------------------------------------------------------------
# for more information on tests, see: https://docs.julialang.org/en/v1/stdlib/Test/
# ----------------------------------------------------------------------------------

# Testset - let's write a unit test for each *public* function in our code!
@testset verbose = true "Build Graph from Adj Matrix" begin

    @testset "build directed graph tests" begin

        # initialize -
        path_to_test_file = joinpath(_PATH_TO_DATA, "Testgraph-directed.dat");

        # load up the adj_matrix -
        adj_matrix = readdlm(path_to_test_file, Int64, comment_char='#', comments=true);

        # build the graph -
        dag = build(MySimpleDirectedGraphModel, adj_matrix);

        # test - is the correct type?
        @test typeof(dag) == MySimpleDirectedGraphModel;

        # correct number of nodes?
        @test length(dag.nodes) == 6;

        # correct number of edges?
        @test length(dag.edges) == 7;

        # check the children -
        @test dag.children[0] == Set([1, 2]);
        @test dag.children[1] == Set([2, 3]);
        @test dag.children[2] == Set([4]);
        @test dag.children[3] == Set([5]); 
        @test dag.children[4] == Set([3]);
        @test dag.children[5] == Set([]);
    end

    @testset "build undirected graph tests" begin

        # initialize -
        path_to_test_file = joinpath(_PATH_TO_DATA, "Testgraph-undirected.dat");

        # load up the adj_matrix -
        adj_matrix = readdlm(path_to_test_file, Int64, comment_char='#', comments=true);

        # build the graph -
        uag = build(MySimpleUndirectedGraphModel, adj_matrix);

        # test - is the correct type?
        @test typeof(uag) == MySimpleUndirectedGraphModel;

        # correct number of nodes?
        @test length(uag.nodes) == 6;

        # correct number of edges?
        @test length(uag.edges) == 14; # not sure about this one - need to check!

        # check the children -
        @test uag.children[0] == Set([1, 2]);
        @test uag.children[1] == Set([0, 2, 3]);
        @test uag.children[2] == Set([0, 1, 4]);
        @test uag.children[3] == Set([5, 4, 1]);
        @test uag.children[4] == Set([2, 3]);
        @test uag.children[5] == Set([3]);
    end
end
        