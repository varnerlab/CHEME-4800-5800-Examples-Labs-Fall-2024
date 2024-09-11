# include -
include("Include.jl")

# Testset - let's write a unit test for each *public* function in our code!
@testset verbose = true "Lab-4d tests" begin

    # test the find function
    @testset "readfiles" begin

        # initialize and setup
        list_of_positive_review_files = readdir(_PATH_TO_POSITIVE_REVIEWS);

        # load the files, and build the list of documents -
        list_of_documents = readfiles(list_of_positive_review_files, base = _PATH_TO_POSITIVE_REVIEWS, delim = " ");

        # how many documents did we find?
        @test length(list_of_documents) ≥ 1000; # there should be at least 1000 documents in the postive section

        # did the parser work - check the type of the first document
        @test typeof(list_of_documents[1]) == MyMoviewReviewDocumentModel;

        # how many records are in the first document?
        @test length(list_of_documents[1].records) == 25; # there should be at 25 records in the first document

        # how many tokens are in the first document?
        @test length(list_of_documents[1].hash) == 418; # there should be at least 418 tokens in the first document

        # test what the first token is -
        @test list_of_documents[1].inverse[1] == "'80s"; # the first token should be the string "'80s"
    end

    @testset "hashing_vectorizer" begin

        # let's do the example from wikipedia: https://en.wikipedia.org/wiki/Feature_hashing
        strings = ["the", "cat", "sat", "on", "the", "mat"];
        hash = Dict("the" => 1, "cat" => 2, "sat" => 3, "on" => 4, "mat" => 5);
        size = 10;
        answer = [2,1,1,1,1,0,0,0,0,0]; # this is the correct answer for size = 10;

        # test the hashing vectorizer -
        result = hashing_vectorizer(strings, size = size, hash = hash);
        @test length(result) == size;
        @test result == answer;

        # if we run the reverse -
        result_reverse = hashing_vectorizer(strings, size = size, hash = hash);
        @test length(result_reverse) == size; # should be the same size
        @test result_reverse == answer; # should be the same answer
    end
end