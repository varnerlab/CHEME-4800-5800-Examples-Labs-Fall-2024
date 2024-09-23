# load my main code -
include("Include.jl");

# These tests are based on 0-based indexing
@testset verbose=true "Search testset" begin

    # test case 1 -
    @test search([4,5,6,7,0,1,2], 0) == 4;

    # test case 2 -
    @test search([4,5,6,7,0,1,2], 3) == -1;

    # test case 3 -
    @test search([1], 0) == -1;
end