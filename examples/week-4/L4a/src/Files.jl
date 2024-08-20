# --- PRIVATE METHODS BELOW HERE ------------------------------------------------------------------------------------------------------------------- #
"""
    _readfile(path::String; delim=",") -> MyMoviewReviewDocumentModel

Reads a file from the path, and returns an instance of the `MyMoviewReviewDocumentModel` type.

### Arguments
- `path::String`: The path to the file to read.
- `delim::String = ","`: The delimiter to use for parsing the file.
"""
function _readfile(path::String; delim=",")::MyMoviewReviewDocumentModel
    
    # check: is the path arg legit? - if not throw an error 

    # initialize
    records = Dict{Int, MyMoviewReviewRecordModel}()
    linecounter = 1; # initialize a counter
    
    # main -
    open(path, "r") do io # open a stream to the file
        for line ∈ eachline(io) # read each line from the stream
        
            # build the record model by calling a build function -
            records[linecounter] = build(MyMoviewReviewRecordModel, line, delim=delim);
            linecounter += 1; # increment the counter
        end
    end

    # return -
    return build(MyMoviewReviewDocumentModel, records);
end
# --- PRIVATE METHODS ABOVE HERE ------------------------------------------------------------------------------------------------------------------- #

# --- PUBLIC METHODS BELOW HERE -------------------------------------------------------------------------------------------------------------------- #
"""
    readfiles(paths::Array{String,1}; delim=",", base::String="") -> Dict{Int, MyMoviewReviewDocumentModel}

Reads a collection of files from the paths, and returns a dictionary of `MyMoviewReviewDocumentModel` instances indexed by the file number.
"""
function readfiles(paths::Array{String,1}; delim=" ", base::String="")::Dict{Int, MyMoviewReviewDocumentModel}
   
    # initialize -
    list_of_positive_documents = Dict{Int64, MyMoviewReviewDocumentModel}();

    # process each file -
    for i ∈ eachindex(paths) # iterate over the paths
        filename = paths[i];
        path_to_review_file = joinpath(base, filename)
        list_of_positive_documents[i] = _readfile(path_to_review_file, delim = delim);
    end
   
    # return -
    return list_of_positive_documents;
end
# --- PUBLIC METHODS ABOVE HERE -------------------------------------------------------------------------------------------------------------------- #