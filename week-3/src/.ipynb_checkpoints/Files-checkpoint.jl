# -- PRIVATE FUBCTIONS BELOW HERE ------------------------------------------------------------------------------ #
function _jld2(path::String)::Dict{String,Any}
    return load(path);
end

# -- PRIVATE FUBCTIONS ABOVE HERE ------------------------------------------------------------------------------ #

# -- PUBLIC FUBCTIONS BELOW HERE ------------------------------------------------------------------------------- #

MyMarketDataSet() = _jld2(joinpath(_PATH_TO_DATA, "SP500-Daily-OHLC-1-3-2018-to-12-29-2023.jld2"));

"""
    readjsonfile(path::String) -> Dict{String,Any}

Load the JSON file at the path arg. Returns a Dict{String,Any} 
containing the JSON data.
"""
function readjsonfile(path::String)::Dict{String,Any}

    # check: does path point to a json file?
    is_path_a_path = ispath(path);
    does_path_point_to_json_file = endswith(path, ".json");
    if (is_path_a_path == false) || (does_path_point_to_json_file == false)
        throw(ArgumentError("The path arg must point to a JSON file."))
    end

    # call the build in parsefile function from the JSON package
    return JSON.parsefile(path)
end

"""
    readtomlfile(path::String) -> Dict{String,Any}

Load the TOML file at the path arg. Returns a Dict{String,Any} 
containing the TOML data.
"""
function readtomlfile(path::String)::Dict{String,Any}

    # check: does path point to a toml file?
    is_path_a_path = ispath(path);
    does_path_point_to_toml_file = endswith(path, ".toml");
    if (is_path_a_path == false) || (does_path_point_to_toml_file == false)
        throw(ArgumentError("The path arg must point to a TOML file."))
    end

    # call the build in parsefile function from the TOML package
    return TOML.parsefile(path)
end

"""
    readyamlfile(path::String) -> Dict{String,Any}

Load the YAML file at the path arg. Returns a Dict{String,Any} 
containing the YAML data.
"""
function readyamlfile(path::String)::Dict{String,Any}

    # check: does path point to a yaml file?
    is_path_a_path = ispath(path);
    does_path_point_to_yaml_file = endswith(path, ".yaml");
    if (is_path_a_path == false) || (does_path_point_to_yaml_file == false)
        throw(ArgumentError("The path arg must point to a YAML file."))
    end

    return YAML.load_file(path)
end

"""
    function simplereadcsvfile(path::String; 
        delim::Char=',', keyindex::Int64 = 1) -> Tuple{Array{String,1}, Dict{Int, Array{Number,1}}}
""" 
function simplereadcsvfile(path::String; 
    delim::Char=',', keyindex::Int64 = 1)::Tuple{Array{String,1}, Dict{Int, Array{Number,1}}}
    
    # check: is the path arg legit?
    # ....

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
                keyfield = fields[keyindex] # get a key field
                for i ∈ eachindex(fields) # iterate over the fields
                    
                    # for all fields NOT equal to the key field, parse the value and push it to the temporary storage
                    if (i != keyindex)
                        push!(tmpstorage, parse(Float64, fields[i]))
                    end
                end

                # do not add bad keys -
                if (isempty(keyfield) == false)
                    data[parse(Int, keyfield)] = tmpstorage;
                end
            end
        end
    end

    # return -
    return (header, data)
end

# -- PUBLIC FUBCTIONS ABOVE HERE ------------------------------------------------------------------------------- #