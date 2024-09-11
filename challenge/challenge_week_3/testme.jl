# load my main code -
include("Include.jl");

@testset verbose=true "Twosum testset" begin

    # test case 1 -
    @test twosum([2, 7, 11, 15], 9) == [1, 2];

    # test case 2 -
    @test twosum([3, 2, 4], 6) == [2, 3];

    # test case 3 -
    @test twosum([3, 3], 6) == [1, 2];

    # test case 4 -
    @test twosum([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 19) == [9, 10];

    # test case 5 -
    @test twosum([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 11) == [1, 10];

    # test case 6 -
    @test twosum([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 3) == [1, 2];

    # test case 7 -
    @test twosum([0, 2, 3, 4, 5, 0, 7, 8, 9, 10], 6) == [2, 4];

    # test case 8 -
    @test twosum([0, 2, 3, 14, 5, 0, 0, 8, 9, 10], 7) == [2, 5];

    # test case 9 -
    @test twosum([1, 0, 3, 4, 5, 16, 7, 18, 14, 10], 9) == [4, 5];

    # test case 10 -
    @test twosum([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 13) == [3,10];
end