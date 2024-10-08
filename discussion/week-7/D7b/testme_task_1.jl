# include -
include("Include.jl")

# ----------------------------------------------------------------------------------
# for more information on tests, see: https://docs.julialang.org/en/v1/stdlib/Test/
# ----------------------------------------------------------------------------------

# Testset - let's write a unit test for each *public* function in our code!
@testset verbose = true "Build stoichiometric matrix" begin

    # setup path for Toy.net -
    path_to_reaction_file = joinpath(_PATH_TO_DATA, "Toy.net");

    # load the reaction file -
    R = readreactionfile(path_to_reaction_file, comment="//", delim=',', expand = false);

    # build the stoichiometric matrix -
    S = build(MyStoichiometricMatrixModel, R);

    # tests for R -
    @test length(R) == 3;
    @test typeof(R) == Dict{Int64, MyChemicalReactionModel};
    @test R[1].name == "v1";
    @test R[2].name == "v2";
    @test R[3].name == "v3";

    # tests for S -
    @test typeof(S) == MyStoichiometricMatrixModel;
    @test length(S.species) == 7;
    @test length(S.reactions) == 3;

    # compare the generated st matrix -
    STEST = [
        -1.0   0.0   0.0
        0.0   0.0  -1.0
        1.0  -1.0   0.0
        0.0   0.0   1.0
        0.0   1.0   0.0
       -1.0   0.0   1.0
        1.0   0.0  -1.0
    ];
    @test S.matrix == STEST;
end