# include -
include("Include.jl")

# Test plan:
# a) Build an array of 1000 student models using the build method from the factory
# b) Pick a random student index (test_index) and grab that student model from the array 
# c) Pass the student array and the values for sid and netid from the random student into the find function
# d) If the impl is correct, the index returned from your function should be the test_index

# a)
number_of_students = 1000;
test_student_array = build(MyStudentModel, number_of_students = number_of_students);

# b) Pick a random student index (rand_student_index) and grab that student model from the array
rand_student_index = rand(1:number_of_students); # you can change this to any number between 1 and 1000
test_student_model = test_student_array[rand_student_index];

# c) pass values -
test_student_index = find(test_student_array; sid = -1, netid = "abc123");

# d) Same?
@assert test_student_index == rand_student_index