function readedgesfile(filepath::String; comment::Char='#', 
    delim::Char=',')::Dict{Int64,MyGraphEdgeModel}

    # initialize
    edges = Dict{Int64,MyGraphEdgeModel}()
    linecounter = 0;
    
    # main -
    open(filepath, "r") do file # open a stream to the file
        for line ∈ eachline(file) # process each line in a file, one at a time
            
            # check: do we have comments?
            if (contains(line, comment) == true) || (isempty(line) == true)
                continue; # skip this line, and move to the next one
            end
            
            # split the line around the delimiter -
            parts = split(line, delim) .|> String
            if (length(parts) != 3)
                push!(parts, "1.0"); # add a default weight, if we need to
            end

            # build the edge model -
            edges[linecounter] = build(MyGraphEdgeModel, (
                parts = parts, # strings from split
                id = linecounter # edge id
            ));

            # update the line counter -
            linecounter += 1;
        end
    end

    # return -
    return edges;
end