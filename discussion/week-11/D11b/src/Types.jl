"""
    mutable struct MyEnglishLanguageVocubularyModel

This models the English language vocabulary. 

### Fields
- `wordsdictionary::Dict{Char, Set{String}}`: This is a dictionary where the key is the starting character and the value is a set of words that start with that character.
"""
mutable struct MyEnglishLanguageVocubularyModel
    
    # fields -
    wordsdictionary::Dict{Char, Set{String}} # key is the starting character and value is a set of words that start with that character

    # empty constructor
    MyEnglishLanguageVocubularyModel() = new();
end