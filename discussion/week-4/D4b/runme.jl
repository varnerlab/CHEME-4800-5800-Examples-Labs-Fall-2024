include("Include.jl")

# This file loads all the postive movie reviews, and builds a list of documents. 
# It then uses the hashing vectorizer to convert the records (lines of text) into a matrix of features. 
# ** This is on the documents basis, so it onlys coniders the words in a document. **

# build lists or positive and negative movie review files -
list_of_positive_review_files = readdir(_PATH_TO_POSITIVE_REVIEWS);
list_of_documents = readfiles(list_of_positive_review_files, base = _PATH_TO_POSITIVE_REVIEWS, delim = " ");

# select a document index -
index = 1;
document = list_of_documents[index];

# A document is a list of records, where each record is a line of text.
# A document has a hash, which is a dictionary of words to integers.
records = document.records;
hash = document.hash;

# compute the vector representation of the first document -
size = 1024;
term_document_matrix = Array{Int64,2}(undef, length(records), size);
number_of_records = length(records);
for i ∈ 1:number_of_records # iterate over the records
    record = records[i]; # get the record
    fields = record.fields; # get the fields
    v = hashing_vectorizer(fields, size = size, hash = hash); # compute the vector representation

    # populate the term document matrix -
    term_document_matrix[i,1:end] .= v;
end