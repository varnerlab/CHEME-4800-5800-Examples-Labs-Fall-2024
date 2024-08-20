"""
    readreactionfile(path::String; comment::String = "#", delim::Char=',', expand::Bool = false) -> Dict{Int64, MyChemicalReactionModel}
"""
function readreactionfile(path::String; 
    comment::String = "#", delim::Char=',', expand::Bool = false)::Dict{Int64, MyChemicalReactionModel}
    
    # check: is path legit?
    # in production we would check this path, assume ok for now

    # initialize -
    reactions = Dict{Int64, MyChemicalReactionModel}()
    counter = 1; # one-based index

    # use example pattern from: https://varnerlab.github.io/CHEME-1800-Computing-Book/unit-1-basics/data-file-io.html#program-read-a-csv-file-refactored
    open(path, "r") do io # open a stream to the file
        for line in eachline(io) # read each line from the stream
            
            # Impl me -
            # line is a line from the file  

            # A couple of things to think about: 
            # a) ignore the comments, check out the contains function: https://docs.julialang.org/en/v1/base/strings/#Base.contains
            # b) records are comma delimited. Check out the split functions: https://docs.julialang.org/en/v1/base/strings/#Base.split
            # c) from the data in each record, we need to build a MyChemicalReactionModel object. Each reaction object should be stored in the reactions dict with the name as the key
            if (contains(line, comment) == false && length(line) > 0)

                fields = split(line, delim); # splits around the ','

                # grab the fields -
                name = string(fields[1]);
                reactant = string(fields[2]);
                product = string(fields[3]);
                reversible = parse(Bool, fields[4]);

                # if expand is true, split the reversible reaction into two irreversible reactions
                model = nothing;
                if (expand == true)
                    
                    # build - 
                    model_forward = _build(MyChemicalReactionModel, "F$(name)", reactant, product, false);
                    model_reversible = _build(MyChemicalReactionModel, "R$(name)", product, reactant, false);

                    # store the forward reaction -
                    reactions[counter] = model_forward;
                    counter += 1;

                    # store the reverse reaction 
                    reactions[counter] = model_reversible;
                    counter += 1;
                else
                    
                    # build - 
                    model = _build(MyChemicalReactionModel, name, reactant, product, reversible);
                    
                    # store -
                    reactions[counter] = model;
                    counter += 1;
                end
            end
        end
    end

    # return -
    return reactions;
end