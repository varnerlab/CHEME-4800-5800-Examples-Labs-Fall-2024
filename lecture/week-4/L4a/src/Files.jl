# --- PRIVATE METHODS BELOW HERE ------------------------------------------------------------------------------------------------------------------- #
# --- PRIVATE METHODS ABOVE HERE ------------------------------------------------------------------------------------------------------------------- #

# --- PUBLIC METHODS BELOW HERE -------------------------------------------------------------------------------------------------------------------- #
function corpus(path::String)::MySarcasmRecordCorpusModel

    # initialize the data -
    records = Dict{Int, MySarcasmRecordModel}();
    counter = 1;

    # open the file, process each line -
    open(path, "r") do io # open a stream to the file
        for line ∈ eachline(io)
            
            d = JSON.parse(line);
            records[counter] = build(MySarcasmRecordModel, (
                data = d,
            ));

            counter += 1;
        end
    end

    # set the data on the model -
    document = MySarcasmRecordCorpusModel();
    document.records = records;

    # return -
    return document;
end
# --- PUBLIC METHODS ABOVE HERE -------------------------------------------------------------------------------------------------------------------- #