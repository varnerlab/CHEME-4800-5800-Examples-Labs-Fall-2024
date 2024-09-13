

function tokenize(s::String, tokens::Dict{String, Int64}; 
    pad::Int64 = 0, padleft::Bool = false, delim::Char = ' ')::Array{Int64,1}

    # initialize -
    tokenarray = Array{Int64,1}();

    # split the string -
    fields = split(s, delim) .|> String;
    for field ∈ fields
        if haskey(tokens, field)
            push!(tokenarray, tokens[field]);
        end
    end

    # do we need to pad?
    if (padleft == false && pad > 0)
        foreacth(i->push!(tokenarray, 0), 1:pad); # pad right
    elseif (padleft == true && pad > 0)
        foreach(i->pushfirst!(tokenarray, 0), 1:pad); # pad left
    end

    # return -
    return tokenarray;
end