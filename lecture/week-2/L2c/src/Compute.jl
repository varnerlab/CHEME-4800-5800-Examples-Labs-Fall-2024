"""
    function find(students::Array{MyStudentModel,1}; sid::Int64=0, netid::String="abc123") -> Union{Int64, Nothing}

The function `find` searches for a student in an array of students. The function takes in an array of `MyStudentModel` objects and two optional parameters: `sid` and `netid`. 
The function returns the index of the student in the array if the student is found, otherwise it returns `nothing`.

## Arguments
- `students::Array{MyStudentModel,1}`: an array of `MyStudentModel` objects.
- `sid::Int64=0`: the student ID of the student to search for. Default is `0`.
- `netid::String="abc123"`: the net ID of the student to search for. Default is `"abc123"`.
"""
function find(students::Array{MyStudentModel,1}; 
    sid::Int64=0, netid::String="abc123")::Union{Int64, Nothing}

    # check: should we check to see if the parameters are valid?
    # Let's discuss this in the testing phase ...

    # initialize -
    student_index = nothing; # default: we don't know which student we are looking for
    number_of_students = length(students) # how many students do we have?

    # main loop -
    for i ∈ 1:number_of_students
        
        # get student i from the array -
        test_student = students[i];

        # if statement: does test_student have the same sid and netid as the student that was passed in? 
        # what is the && operator doing here?
        if (test_student.sid == sid && test_student.netid == netid) 
            student_index = i; # index is i
            break; # we found the student, so we can stop looking
        end
    end


    # return -
    return student_index
end