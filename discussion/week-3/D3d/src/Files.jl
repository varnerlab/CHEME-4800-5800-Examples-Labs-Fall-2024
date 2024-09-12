"""
    function simplereadcsvfile(path::String; delim::Char=',') -> Tuple{Array{String,1}, Dict{Int64, Array{Float64,1}}}

The function `simplereadcsvfile` reads a CSV file and returns the data as a tuple containing an array of strings (header) and a dictionary of arrays of floats (data), 
where the key is the row number of the file (starting at 1).

### Arguments
- `path::String` - the path to the CSV file to read.
- `delim::Char` - (optional) the delimiter used in the CSV file. Default is `,`.

### Returns
- `Tuple{Array{String,1}, Dict{Int64, Array{Float64,1}}}` - a tuple containing the header (array of strings) and the data (dictionary of arrays of floats).
""" 
function simplereadfile(path::String; delim::Char=',')::Tuple{Array{String,1}, Dict{Int, Array{Float64,1}}}
    
    # check: is the path arg legit? - if not throw an error
    is_path_a_path = ispath(path);
    does_path_point_to_csv_file = endswith(path, ".csv");
    if (is_path_a_path == false) || (does_path_point_to_csv_file == false)
        throw(ArgumentError("The path arg must point to a CSV file."))
    end
   
    # initialize
    counter = 1
    header = Array{String,1}()
    data = Dict{Int,Array{Float64,1}}()

    # main -
    open(path, "r") do io # open a stream to the file
        for line in eachline(io) # read each line from the stream
            
            # split the line around the delim. Check out: https://docs.julialang.org/en/v1/base/strings/#Base.split
            fields = split(line, delim) .|> String; # what the heck??
            if (counter == 1)
                
                # wow! this is some fancynancy syntax! what the what?!?
                foreach(value -> push!(header, value), fields); # Check out: https://docs.julialang.org/en/v1/base/collections/#Base.foreach
                counter += 1 # update the counter
            else

                # First, initialize some temporary storage -
                tmpstorage = Array{Float64,1}()
                for i ∈ eachindex(fields) # iterate over the fields
                    push!(tmpstorage, parse(Float64, fields[i])) # convert everything to a Float64 and push it to the temporary storage
                end
                
                # store the data -
                data[counter] = tmpstorage; # add the temporary storage to the data dictionary
                counter += 1 # update the counter
            end
        end
    end

    # return -
    return (header, data)
end

"""
    betterreadcsvfile(path::String; 
        delim::Char=',') -> Tuple{Array{String,1}, Dict{Int, MyRuntimeNumericalRecordType}}

The function `betterreadcsvfile` reads a CSV file and returns the data as a tuple containing an array of strings (header) and a dictionary of `MyRuntimeNumericalRecordType` instances,
where the key is the row number of the file (starting at 1).

### Arguments
- `path::String` - the path to the CSV file to read.
- `delim::Char` - (optional) the delimiter used in the CSV file. Default is `,`.

### Returns
- `Tuple{Array{String,1}, Dict{Int, MyRuntimeNumericalRecordType}}` - a tuple containing the header (array of strings) and the data (dictionary of `MyRuntimeNumericalRecordType` instances).
"""
function betterreadfile(path::String; delim::Char=',')::Tuple{Array{String,1}, Dict{Int, MyRuntimeNumericalRecordType}}
    
    # check: is the path arg legit? - if not throw an error
    is_path_a_path = ispath(path);
    does_path_point_to_data_file = endswith(path, ".csv");
    if (is_path_a_path == false) || (does_path_point_to_data_file == false)
        throw(ArgumentError("The path arg must point to a CSV file."))
    end

    # initialize
    counter = 1
    header = Array{String,1}()
    data = Dict{Int, MyRuntimeNumericalRecordType}()

    # main -
    open(path, "r") do io # open a stream to the file
        for line in eachline(io) # read each line from the stream
            
            # split the line around the delim. Check out: https://docs.julialang.org/en/v1/base/strings/#Base.split
            fields = split(line, delim) .|> String; # what the heck??
            if (counter == 1)
                
                # wow! this is some fancynancy syntax! what the what?!?
                foreach(value -> push!(header, value), fields); # Check out: https://docs.julialang.org/en/v1/base/collections/#Base.foreach
                counter += 1 # update the counter
            else

                # First, initialize some temporary storage -
                tmpstorage = Dict{Symbol,Any}();
                for i ∈ eachindex(fields) # iterate over the fields
                    push!(tmpstorage, Symbol(header[i]) => parse(Float64, fields[i])) # convert everything to a Float64 and push it to the temporary storage
                end

                # build a record model, and store it -
                data[counter] = build(MyRuntimeNumericalRecordType, tmpstorage |> NamedTuple);

                # update the counter
                counter += 1
            end
        end
    end

    # return -
    return (header, data)
end

"""
    function bestreadfile(path::String) -> DataFrame

The function `bestreadfile` reads a CSV file using the `CSV.jl` package and returns the data as a `DataFrame` instance.

### Arguments
- `path::String` - the path to the CSV file to read.

### Returns
- `DataFrame` - the data from the CSV file as a `DataFrame` instance.
"""
function bestreadfile(path::String)::DataFrame

    # check: is the path arg legit? - if not throw an error
    # is_path_a_path = ispath(path);
    # does_path_point_to_csv_file = endswith(path, ".csv");
    # if (is_path_a_path == false) || (does_path_point_to_csv_file == false)
    #     throw(ArgumentError("The path arg must point to a CSV file."))
    # end

    # read the file -
    return CSV.read(path, DataFrame)
end
    


# -- PUBLIC FUBCTIONS ABOVE HERE ------------------------------------------------------------------------------- #