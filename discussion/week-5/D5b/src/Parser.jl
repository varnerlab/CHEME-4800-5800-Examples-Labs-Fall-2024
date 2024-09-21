"""
    _recursive_descent_parser(q::Queue, tmp::Queue{Char}, a::Array{String,1}; 
        delim = ' ')::Nothing
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
"""
function recursivesplit(string::String; delim::Char=' ')::Dict{Int64,String}

    # initialize -
    d = Dict{Int,String}();
    tmp = Queue{Char}();
    q = Queue{Char}();
    a = Array{String,1}();
    counter = 0

    character_arr = collect(string)
    for c ∈ character_arr
        enqueue!(q, c);
    end


    _recursive_descent_parser!(q, tmp, a; delim = delim);
    for item ∈ a
        d[counter] = item;
        counter += 1
    end


    return d
end