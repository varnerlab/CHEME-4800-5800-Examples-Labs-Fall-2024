# --- PRIVATE METHODS BELOW HERE ------------------------------------------------------------------------------------------------------------------- #
# --- PRIVATE METHODS ABOVE HERE ------------------------------------------------------------------------------------------------------------------- #

# --- PUBLIC METHODS BELOW HERE -------------------------------------------------------------------------------------------------------------------- #
"""
    function corpus(path::String) -> MySarcasmRecordCorpusModel

The function `corpus` reads a file composed of JSON records and returns the data as a `MySarcasmRecordCorpusModel` instance.
Each record in the file is expected to have the following fields:
* `is_sarcastic::Bool` - a boolean value indicating if the headline is sarcastic.
* `headline::String` - the headline of the article.
* `article_link::String` - the link to the article.

### Arguments
- `path::String` - the path to the file to read.

### Returns
- `MySarcasmRecordCorpusModel` - the data from the file as a `MySarcasmRecordCorpusModel` instance.

"""
function corpus(path::String)::MySarcasmRecordCorpusModel

    # initialize the data -
    records = Dict{Int, MySarcasmRecordModel}();
    tokendictionary = Dict{String, Int64}();
    inverse = Dict{Int64, String}();
    counter = 1;

    # open the file, process each line -
    open(path, "r") do io # open a stream to the file
        for line ∈ eachline(io)
            
            d = JSON.parse(line);
            records[counter] = build(MySarcasmRecordModel, (
                issarcastic = d["is_sarcastic"], headline = d["headline"], article = d["article_link"],
            ));

            counter += 1;
        end
    end

    # build the token dictionary -
    tokenarray = Array{String,1}();
    for (k,v) ∈ records

        # process headline data -
        headline = v.headline;
        tokens = split(headline, " ") .|> String;

        # process -
        for token ∈ tokens

            # strip any leading or trailing spaces -
            token = strip(token, ' ');
        
            if (in(token, tokenarray) == false && isempty(token) == false)
                push!(tokenarray, token);
            end
        end 
    end

    # add <OOV> token -
    push!(tokenarray, "<OOV>");

    tokenarray |> sort!
    for i ∈ eachindex(tokenarray)
        key = tokenarray[i]
        tokendictionary[key] = i; 
        inverse[i] = key;
    end

    # set the data on the model -
    document = MySarcasmRecordCorpusModel();
    document.records = records;
    document.tokens = tokendictionary;
    document.inverse = inverse;

    # return -
    return document;
end
# --- PUBLIC METHODS ABOVE HERE -------------------------------------------------------------------------------------------------------------------- #