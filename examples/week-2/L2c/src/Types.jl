"""
    MyStudentModel

Mutable stuct with two fields:
sid::Int64 - student id number
netid::String - netid field 
"""
mutable struct MyStudentModel

    # data fields 
    sid::Int64
    netid::String
    
    # constructor: builds a new empty Student
    MyStudentModel() = new()
end