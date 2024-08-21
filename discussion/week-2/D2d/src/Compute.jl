# should there be some documentation here?
# what should the return type be, what are the args, what does the function do?
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
        if (test_student.sid == sid && test_student.netid == netid) # netid - not metid
            # student_index = j; old line -
            student_index = i; # index is i
        end
    end


    # return -
    return student_index
end