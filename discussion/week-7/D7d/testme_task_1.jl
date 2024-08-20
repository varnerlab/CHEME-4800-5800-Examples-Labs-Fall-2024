# load the price dataset full dataset, remove firms with missing data, 
# compute the growth rate matrix, and then compute the singular value decomposition of the growth rate matrix.
include("runme_task_1.jl") 

# ----------------------------------------------------------------------------------
# for more information on tests, see: https://docs.julialang.org/en/v1/stdlib/Test/
# ----------------------------------------------------------------------------------

# Testset - let's write some tests for all the facts that we know about the SVD -
@testset verbose = true "Test the SVD fun facts" begin

    # example test - uses the @test macro:
    # test passes if the expression evaluates to `true`, e.g., @test 1 == 1;
    # test fails if the expression evaluates to `false`, e.g., @test 1 == 2;
    @test size(U) == (459,459); # example test, checks the size of U

    # TODO: test if U is a orthogonal matrix using the isapprox function -
    @test 1 == 0; # replace this with your test
    
    # TODO: test if V is a orthogonal matrix using the isapprox function -
    @test 1 == 0; # replace this with your test

    # TODO: test if the *first* outer prodict of U and V is a rank 1 matrix
    @test 1 == 0; # replace this with your test

   # TODO: test if the Σ values are the sqrt(eigenvalues) of the matrix A*transpose(A)
    @test 1 == 0; # replace this with your test

    # TODO: test that we can reconstruct the original matrix from the SVD components. Use isapprox function
    @test 1 == 0; # replace this with your test
end