# --- PRIVATE METHODS BELOW HERE ------------------------------------------------------------------------------------------------------------------- #
"""
    _readfile(path::String; delim=",") -> MyMoviewReviewDocumentModel

Reads a file from the path, and returns an instance of the `MyMoviewReviewDocumentModel` type.

### Arguments
- `path::String`: The path to the file to read.
- `delim::String = ","`: The delimiter to use for parsing the file.
"""
function _readfile(path::String; delim=",")::MyMoviewReviewRecordModel
    
    # check: is the path arg legit? - if not throw an error 
        
    # main -
    allreviewdata = nothing;
    open(path, "r") do io # open a stream to the file
        allreviewdata = read(io, String); # read the *all* the data from the io stream
    end

    # return -
    return build(MyMoviewReviewRecordModel, allreviewdata, delim=delim);
end
# --- PRIVATE METHODS ABOVE HERE ------------------------------------------------------------------------------------------------------------------- #

# --- PUBLIC METHODS BELOW HERE -------------------------------------------------------------------------------------------------------------------- #
"""
    function readfiles(paths::Array{String,1}; delim=",", base::String="") -> Dict{Int, MyMoviewReviewRecordModel}

Reads a collection of files from the paths, and returns a dictionary of `MyMoviewReviewRecordModel` 
instances indexed by the file number.

### Arguments
- `paths::Array{String,1}`: An array of paths to the files to read.
- `delim::String = " "`: The delimiter to use for parsing the files. 
- `base::String = ""`: The base path to use for the files. 

### Returns
- `Dict{Int, MyMoviewReviewRecordModel}`: A dictionary of `MyMoviewReviewRecordModel` instances indexed by the file number.
"""
function readfiles(paths::Array{String,1}; delim=" ", base::String="")::Dict{Int, MyMoviewReviewRecordModel}
   
    # initialize -
    list_of_documents = Dict{Int64, MyMoviewReviewRecordModel}();

    # process each file -
    for i ∈ eachindex(paths) # iterate over the paths
        filename = paths[i];
        path_to_review_file = joinpath(base, filename)
        list_of_documents[i] = _readfile(path_to_review_file, delim = delim);
    end
   
    # return -
    return list_of_documents;
end
# --- PUBLIC METHODS ABOVE HERE -------------------------------------------------------------------------------------------------------------------- #