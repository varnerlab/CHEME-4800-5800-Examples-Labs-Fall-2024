abstract type AbstractTextRecordModel end
abstract type AbstractTextDocumentModel end
abstract type AbstractTextDocumentCorpusModel end

"""
    MyMoviewReviewRecordModel <: AbstractTextRecordModel

### Fields 
- `fields::Array{String,1}`: The tokens found in the record in the order they were found
- `tokenset::Set{String}`: The set of tokens in the record (no order)
- `hash::Dict{String,Int64}`: A dictionary of tokens in alphabetical order (key: token, value: position)
- `inverse::Dict{Int64,String}`: A dictionary mapping position to token (key: position, value: token)
"""
mutable struct MyMoviewReviewRecordModel <: AbstractTextRecordModel
    
    # data -
    fields::Array{String,1}
    tokenset::Set{String}
    hash::Dict{String,Int64}
    inverse::Dict{Int64,String}
    
    # constructor -
    MyMoviewReviewRecordModel() = new(); # empty
end

"""
    MyMoviewReviewDocumentModel <: AbstractTextDocumentModel

### Fields
- `fields::Array{String,1}`: The tokens (words) found in the document (collection of records) in the order they were found
- `tokenset::Set{String}`: The set of tokens in the document (no order)
- `hash::Dict{String,Int64}`: A dictionary of tokens in alphabetical order (key: token, value: position) for the entire document
- `inverse::Dict{Int64,String}`: A dictionary mapping position to token (key: position, value: token) for the entire document
"""
mutable struct MyMoviewReviewDocumentModel <: AbstractTextDocumentModel
    
    # data -
    records::Dict{Int, MyMoviewReviewRecordModel}
    tokenset::Set{String}
    hash::Dict{String,Int64}
    inverse::Dict{Int64,String}
    
    # constructor -
    MyMoviewReviewDocumentModel() = new(); # empty
end

mutable struct MyMoviewReviewDocumentCorpusModel <: AbstractTextDocumentModel
    
    # data -
    records::Dict{Int, MyMoviewReviewDocumentModel}
    tokens::Dict{String,Int64}
    
    # constructor -
    MyMoviewReviewDocumentCorpusModel() = new(); # empty
end
