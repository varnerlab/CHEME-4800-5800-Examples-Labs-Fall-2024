# ===== PRIVATE METHODS BELOW HERE =================================================================================== #
"""
    build_student_model(; sid::Int64 = 0, netid::String="abc123") -> Student

kjHdlohasdljhasldkjhasljk
"""
function _build_student_model(; sid::Int64 = 0, netid::String="abc123")::MyStudentModel

    # check: should we check to see if the parameters are valid?
    # Will this ever get called with invalid parameters?

    # create -
    student = MyStudentModel();
    student.sid = sid;
    student.netid = netid;

    #$@show student

    # return -
    return student;
end
# ===== PRIVATE METHODS ABOVE HERE =================================================================================== #

# ===== PUBLIC METHODS BELOW HERE ==================================================================================== #
"""
    build(model::Type{MyStudentModel}; number_of_students::Int64 = 100, max_sid::Int64 = 10000) -> Array{MyStudentModel,1}

Build an array of `MyStudentModel` instances with random information.
The sid field is a random integer in the range `1:max_sid`.
The netid field is a random string generated using `UUIDs.uuid4` from the `UUIDs` package.

See: https://docs.julialang.org/en/v1/stdlib/UUIDs/#UUIDs.uuid4
"""
function build(model::Type{MyStudentModel}; 
    number_of_students::Int64 = 100, max_sid::Int64 = 10000)::Array{MyStudentModel,1}

    # should we check: number_of_students>0
    # before we do this, let's get to the testing phase

    # initialize -
    # student_array = Array{Student,1}(undef, number_of_students) # old line -
    student_array = Array{MyStudentModel,1}(undef, number_of_students)
    for i ∈ 1:number_of_students
        
        # build a student object -
        sid = rand(1:max_sid)
        netid = string(UUIDs.uuid4())
        # local_student_model = _build_my_model(sid = dis, netid=metid); # old line
        local_student_model = _build_student_model(sid = sid, netid=netid);

        # add to the array -
        student_array[i] = local_student_model
    end

    # return -
    return student_array
end

# ===== PUBLIC METHODS ABOVE HERE ==================================================================================== #