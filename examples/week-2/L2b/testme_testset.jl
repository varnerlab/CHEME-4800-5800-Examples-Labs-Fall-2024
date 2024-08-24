# include the include -
include("Include.jl")

# ----------------------------------------------------------------------------------
# for more information on tests, see: https://docs.julialang.org/en/v1/stdlib/Test/
# ----------------------------------------------------------------------------------

# Testset - let's write a unit test for each *public* function in our code!
@testset verbose = true "Lab-2d tests" begin
     
    # test the find function
    @testset "find function" begin
        
        # setup -
        number_of_students = 1000;

        # a) build 1000 students
        test_student_array = build(MyStudentModel, number_of_students = number_of_students);
        
        # b) pick a random student index (test_index) and grab that student model from the array
        rand_student_index = rand(1:number_of_students); # this will generate a random number between 1 and number_of_students
        test_student_model = test_student_array[rand_student_index];
        
        # c) pass values -
        test_student_index = find(test_student_array; sid = test_student_model.sid, netid = test_student_model.netid);
        
        # d) Same?
        @test test_student_index == rand_student_index
    end

    # test the build function
    @testset "build function" begin
        
        # setup -
        number_of_students = 1000;

        # a) build 1000 students
        test_student_array = build(MyStudentModel, number_of_students = number_of_students);
        
        # b) test the length of the array
        @test length(test_student_array) == number_of_students
        
        # c) test the type of the array
        @test typeof(test_student_array) == Array{MyStudentModel,1}

        # d) throw an error if the number of students is less than 1
        @test_throws ArgumentError build(MyStudentModel, number_of_students = -1)
    end
end
