# ===== PRIVATE METHODS BELOW HERE =================================================================================== #
"""
    build_student_model(; sid::Int64 = 0, netid::String="abc123") -> MyStudentModel
"""
function _build_student_model(; sid::Int64 = 0, netid::String="abc123")::MyStudentModel

    # check: should we check to see if the parameters are valid?
    # Will this ever get called with invalid parameters?

    # create -
    student = MyStudentModel();
    student.sid = sid;
    student.netid = netid;

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

### Arguments
- `model::Type{MyStudentModel}`: the type of model to build
- `number_of_students::Int64 = 100`: the number of students to build. Default value is 100.
- `max_sid::Int64 = 10000`: the maximum student id. Default value is 10000.

See: https://docs.julialang.org/en/v1/stdlib/UUIDs/#UUIDs.uuid4
"""
function build(model::Type{MyStudentModel}, number_of_students::Int64 = 100; 
    max_sid::Int64 = 10000)::Array{MyStudentModel,1}

    # should we check: number_of_students>0
    # before we do this, let's get to the testing phase

    # initialize -
    student_array = Array{MyStudentModel,1}(undef, number_of_students)
    for i ∈ 1:number_of_students
        
        # build a student object -
        sid = rand(1:max_sid)
        netid = string(UUIDs.uuid4())
        local_student_model = _build_student_model(sid = sid, netid=netid);

        # add to the array -
        student_array[i] = local_student_model
    end

    # return -
    return student_array
end

"""
    function build(model::Type{MyStudentModel}; sid::Int64 = 0, netid::String = "1234")::MyStudentModel

Build a `MyStudentModel` instance with the given `sid` and `netid` values. 

### Arguments
- `model::Type{MyStudentModel}`: the type of model to build
- `sid::Int64 = 0`: the student id. Default value for sid is 0.
- `netid::String = "1234"`: the netid. Default value for netid is "1234".
"""
function build(model::Type{MyStudentModel}; sid::Int64 = 0, netid::String = "1234")::MyStudentModel
    return _build_student_model(sid = sid, netid = netid);
end

# ===== PUBLIC METHODS ABOVE HERE ==================================================================================== #