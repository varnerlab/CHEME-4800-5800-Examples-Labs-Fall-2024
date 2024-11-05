mutable struct MyEnglishLanguageVocubularyModel
    
    # fields -
    wordsdictionary::Dict{Char, Set{String}}

    # empty constructor
    MyEnglishLanguageVocubularyModel() = new();
end