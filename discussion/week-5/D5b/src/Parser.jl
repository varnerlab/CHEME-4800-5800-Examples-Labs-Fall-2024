"""
    _recursive_descent_parser(q::Queue, tmp::Queue{Char}, a::Array{String,1}; 
        delim = ' ') -> Nothing

The `_recursive_descent_parser` function is a recursive descent parser that splits a string into an array of words.
The function uses a queue data structure to store the characters of the input string. 

### Arguments
- `q::Queue`: a queue of characters.
- `tmp::Queue{Char}`: a temporary queue of characters.
- `a::Array{String,1}`: an array of strings.
- `delim::Char=' '`: the delimiter to split the string on.

### Returns
- `Nothing`: the function returns nothing. It updates the array `a` in place.
"""
function _recursive_descent_parser!(q::Queue, tmp::Queue{Char}, a::Array{String,1}; 
    delim = ' ')::Nothing
    
    # @show q,tmp,a
    
    if (isempty(q) == true)
        if (isempty(tmp) == false)
            word = join(tmp)
            if (isempty(word) == false)
                push!(a,word)
            end
        end
        return nothing 
    else
        next_char = dequeue!(q)
        if (next_char == delim)
            word = join(tmp)
            if (isempty(word) == false)
                push!(a, word)
            end
            empty!(tmp);
        else
            enqueue!(tmp, next_char)
        end
        _recursive_descent_parser!(q, tmp, a; delim = delim);
    end
end

"""
    recursivesplit(string::String; delim::Char=' ') -> Dict{Int64,String}

The `recursivesplit` function is a recursive descent parser that splits a string into a dictionary of words. 
The function is a wrapper around the `_recursive_descent_parser!` function. 


### Arguments
- `string::String`: the string to split.
- `delim::Char=' '`: the delimiter to split the string on.

### Returns
- `Dict{Int64,String}`: a dictionary of words.
"""
function recursivesplit(string::String; delim::Char=' ')::Dict{Int64,String}

    # initialize -
    d = Dict{Int,String}();
    tmp = Queue{Char}();
    q = Queue{Char}();
    a = Array{String,1}();
    counter = 0


    character_arr = collect(string) # turn the string into an array of characters
    for c ∈ character_arr
        enqueue!(q, c); # add the characters to the q queue
    end

    _recursive_descent_parser!(q, tmp, a; delim = delim); # call the recursive descent parser
    
    # populate the dictionary d
    for item ∈ a
        d[counter] = item;
        counter += 1
    end

    # return the dictionary d
    return d
end