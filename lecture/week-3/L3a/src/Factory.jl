"""
    function build(type::Type{Stack{Char}}, string::String) -> Stack{Char}

Factory method for constructing a `Stack{Char}` holding the contents of `string::String`

### Arguments
- `type::Type{Stack{Char}}`: the type of the data structure to be constructed
- `string::String`: the string to be added to the data structure

### Returns
- `Stack{Char}`: the data structure holding the contents of the string, in this case a `Stack{Char}`

### Assumptions:
* The `DataStructures.jl` package has been installed. See: https://juliacollections.github.io/DataStructures.jl/latest/
"""
function build(type::Type{Stack{Char}}, string::String)::Stack{Char}
    
    # initialize an empty stack -
    s = type()

    # add string to the stack -
    chars = collect(string);
    for c ∈ chars
        push!(s,c);
    end

    # return -
    return s
end

"""
   function build(type::Type{Queue{Char}}, string::String) -> Queue{Char}

Factory method for constructing a `Queue{Char}` holding the contents of `string::String`

### Arguments
- `type::Type{Queue{Char}}`: the type of the data structure to be constructed
- `string::String`: the string to be added to the data structure

### Returns
- `Queue{Char}`: the data structure holding the contents of the string, in this case a `Queue{Char}`

### Assumptions:
* The `DataStructures.jl` package has been installed. See: https://juliacollections.github.io/DataStructures.jl/latest/
"""
function build(type::Type{Queue{Char}}, string::String)::Queue{Char}
    
    # initialize an empty stack -
    q = type()

    # add string to the stack -
    chars = collect(string);
    for c ∈ chars
        enqueue!(q,c);
    end

    # return -
    return q
end

"""
    build(type::Type{MutableLinkedList{Char}}, string::String) -> MutableLinkedList{Char}

Factory method for constructing a `MutableLinkedList{Char}` holding the contents of `string::String`

### Arguments
- `type::Type{MutableLinkedList{Char}}`: the type of the data structure to be constructed, i.e., `MutableLinkedList{Char}`
- `string::String`: the string to be added to the data structure

### Returns
- `MutableLinkedList{Char}`: the data structure holding the contents of the string, in this case a `MutableLinkedList{Char}`

### Assumptions:
* The `DataStructures.jl` package has been installed. See: https://juliacollections.github.io/DataStructures.jl/latest/
"""
function build(type::Type{MutableLinkedList{Char}}, string::String)::MutableLinkedList{Char}
    
    # initialize an empty stack -
    l = type()

    # add string to the stack -
    chars = collect(string);
    for c ∈ chars
        push!(l,c);
    end

    # return -
    return l
end