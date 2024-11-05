"""
    build(modeltype::Type{MyEnglishLanguageVocubularyModel}, filepath::String)::MyEnglishLanguageVocubularyModel

Builds a model of type `MyEnglishLanguageVocubularyModel` from the data stored in the file `filepath`.
The `filepath` should be a JSON file with the words as keys and the values as the frequency of the words.

### Arguments
- `modeltype::Type{MyEnglishLanguageVocubularyModel}`: The type of the model to be built.
- `filepath::String`: The path to the JSON file containing the data.

### Returns
- `MyEnglishLanguageVocubularyModel`: The model built from the data in the file.
"""
function build(modeltype::Type{MyEnglishLanguageVocubularyModel}, 
    filepath::String)::MyEnglishLanguageVocubularyModel

    # initialize -
    model = modeltype(); # create an empty model
    data = JSON.parsefile(filepath); # read the data from the *.json file
    wordsdictionary = Dict{Char, Set{String}}(); # create an empty dictionary

    # the words are the keys of the dictionary
    list_of_words = keys(data) |> collect;
    for word ∈ list_of_words
        
        # what is the first letter of the word?
        first_letter = word[1]; # this gives the first letter of the word as a Char

        # do we have this letter in the model?
        if (haskey(wordsdictionary, first_letter) == false)
            wordsdictionary[first_letter] = Set{String}(); # create an empty new set
        end

        # add the word to the set
        push!(wordsdictionary[first_letter], word); # fancy!!
    end

    # update the model -
    model.wordsdictionary = wordsdictionary;
    
    # return the model -
    return model;
end