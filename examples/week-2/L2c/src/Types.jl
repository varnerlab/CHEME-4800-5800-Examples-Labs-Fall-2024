"""
    mutable struct MyStudentModel

A mutable struct that models a student with a student id and a netid.

## Fields
- `sid::Int64`: the student id
- `netid::String`: the netid
"""
mutable struct MyStudentModel

    # data fields 
    sid::Int64
    netid::String
    
    # constructor: builds a new empty Student
    MyStudentModel() = new()
end