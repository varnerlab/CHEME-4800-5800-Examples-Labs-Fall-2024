function _deepclean(s::String)::String
    #s = replace(s, r"[^a-zA-Z0-9 ]"=>""); # remove all non-alphanumeric characters: this uses regex

    # remove all non-alphanumeric characters: this uses a set
    puncuation_skip_set = Set{Char}();
    push!(puncuation_skip_set, ',');
    push!(puncuation_skip_set, '.');
    push!(puncuation_skip_set, '!');
    push!(puncuation_skip_set, '?');
    push!(puncuation_skip_set, ';');
    push!(puncuation_skip_set, ':');
    push!(puncuation_skip_set, ')');
    push!(puncuation_skip_set, '(');
    push!(puncuation_skip_set, '\"');
    push!(puncuation_skip_set, '/');
    push!(puncuation_skip_set, '\\');
    push!(puncuation_skip_set, '-');
    push!(puncuation_skip_set, '_');
    push!(puncuation_skip_set, '`');
    push!(puncuation_skip_set, ''');
    push!(puncuation_skip_set, '*');
    push!(puncuation_skip_set, '+');
    push!(puncuation_skip_set, '=');
    push!(puncuation_skip_set, '@');
    push!(puncuation_skip_set, '%');
    push!(puncuation_skip_set, '|');
    push!(puncuation_skip_set, '{');
    push!(puncuation_skip_set, '}');
    push!(puncuation_skip_set, '[');
    push!(puncuation_skip_set, ']');
    push!(puncuation_skip_set, '<');
    push!(puncuation_skip_set, '>');
    push!(puncuation_skip_set, '~');
    push!(puncuation_skip_set, '^');
    push!(puncuation_skip_set, '&');
    push!(puncuation_skip_set, '$');
    push!(puncuation_skip_set, '¿');
    push!(puncuation_skip_set, '¡');
    push!(puncuation_skip_set, '£');
    push!(puncuation_skip_set, '€');
    push!(puncuation_skip_set, '¥');
    push!(puncuation_skip_set, '₹');   
    push!(puncuation_skip_set, '©'); 
    push!(puncuation_skip_set, '®');
    push!(puncuation_skip_set, '™');
    push!(puncuation_skip_set, '¯');
    push!(puncuation_skip_set, '\n');
    push!(puncuation_skip_set, '\u00a0');

    # ok, so field is a string, and we are checking if it contains any of the puncuation characters
    chararray =  s |> collect;

    # let's use the filter function to remove any puncuation characters from the field -
    cleaned_word = filter(c -> (c |> Int ) ≤ 255 && !(c ∈ puncuation_skip_set),
            chararray) |> String;

    return cleaned_word;
end



"""
    build(model::Type{MyMoviewReviewRecordModel}, line::String; delim::String=",") -> MyMoviewReviewRecordModel

Builds an instance of the `MyMoviewReviewRecordModel` type from a line of text.

### Arguments
- `model::Type{MyMoviewReviewRecordModel}`: The type of model to build, in this case `MyMoviewReviewRecordModel`.
- `line::String`: The line of text to parse.
- `delim::String = ","`: The delimiter to use for parsing the line.

### Returns
- `MyMoviewReviewRecordModel`: An instance of the `MyMoviewReviewRecordModel` type.
"""
function build(model::Type{MyMoviewReviewRecordModel}, review::String; 
    delim::String=",")::MyMoviewReviewRecordModel
    
    # initialize -
    tokenset = Set{String}(); # build an empty set
    cleaned_fields_data = Array{String,1}(); # build an empty array
    hash = Dict{String,Int64}();
    record = model(); # build an empty model
    
    # do NOT include puncuation in the tokens -
    puncuation_skip_set = Set{String}();
    push!(puncuation_skip_set, ",");
    push!(puncuation_skip_set, ".");
    push!(puncuation_skip_set, "!");
    push!(puncuation_skip_set, "?");
    push!(puncuation_skip_set, ";");
    push!(puncuation_skip_set, ":");
    push!(puncuation_skip_set, ")");
    push!(puncuation_skip_set, "(");
    push!(puncuation_skip_set, "\"");
    push!(puncuation_skip_set, "/");
    push!(puncuation_skip_set, "\\");
    push!(puncuation_skip_set, "-");
    push!(puncuation_skip_set, "_");
    
    # split the line around the delim. Check out: https://docs.julialang.org/en/v1/base/strings/#Base.split
    words = split(review, delim) .|> String; # make strings out of the words
    for word ∈ words # iterate over the fields
        
        if ((word ∈ puncuation_skip_set) == false && (word != "")) # if the field is not in the puncuation set, and is not empty
            
            cleanedword = _deepclean(word); # clean the field
            
            push!(tokenset, cleanedword); # add the field to the tokenset
            push!(cleaned_fields_data, cleanedword); # add the field to the cleaned fields data
        end
    end
    record.fields = cleaned_fields_data; # set the data on the model
    
    # build an ordering for the tokens -
    token_array = collect(tokenset) |> sort; # convert the set to an array, and sort it
    for i ∈ eachindex(token_array) # iterate over the tokens
        token = token_array[i]; # get the token
        hash[token] = i; # add the token to the dictionary
    end

    # compute the inverse tokens -
    inverse = Dict{Int64,String}();
    for (k,v) ∈ hash # iterate over the tokens
        inverse[v] = k; # add the token to the dictionary
    end

    # set the data on the model -
    record.tokenset = tokenset;
    record.vocabulary = hash;
    record.inverse = inverse;
    
    # return -
    return record;
end

"""
    build(model::Type{MyMoviewReviewDocumentModel}, records::Dict{Int64, MyMoviewReviewRecordModel}) -> MyMoviewReviewDocumentModel

Builds an instance of the `MyMoviewReviewDocumentModel` type from a dictionary of records.

### Arguments
- `model::Type{MyMoviewReviewDocumentModel}`: The type of model to build, in this case `MyMoviewReviewDocumentModel`.
- `records::Dict{Int64, MyMoviewReviewRecordModel}`: A dictionary of records to use for building the document.
"""
function build(model::Type{MyMoviewReviewDocumentCorpusModel}, 
    records::Dict{Int64, MyMoviewReviewRecordModel})::MyMoviewReviewDocumentCorpusModel
    
    # initialize -
    corpus = model(); # build an empty document corpus
    tokenset = Set{String}(); # build an empty set
    hash = Dict{String, Int64}();
    inverse = Dict{Int64,String}();

    # first, set the records field on the document -
    corpus.records = records;

    # process each record, and build the overall list of tokens for this document -
    for (_, record) ∈ records # iterate over the tokens in the records
        record_token_set = record.tokenset;
        for token ∈ record_token_set # iterate over the tokens in the record
            push!(tokenset, token); # add the token to the tokenset
        end
    end
    push!(tokenset, "<OOV>"); # manually add the <OOV> token -
    corpus.tokenset = tokenset; # set the data on the document

    # build an ordering for the tokens -
    token_array = collect(tokenset) |> sort; # convert the set to an array, and sort it
    for i ∈ eachindex(token_array) # iterate over the tokens
        token = token_array[i]; # get the token
        hash[token] = i; # add the token to the dictionary
    end
    corpus.vocabulary = hash; # set the data on the document

    # inverse -
    for (k,v) ∈ hash # iterate over the tokens
        inverse[v] = k; # add the token to the dictionary
    end
    corpus.inverse = inverse; # set the data on the document


    # return -
    return corpus;
end
