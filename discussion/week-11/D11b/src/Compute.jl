"""
    transitionmatrix(vocabmodel::MyEnglishLanguageVocubularyModel, 
        letters::Array{Char,1}) -> Array{Float64,2}

This function computes the transition matrix for {a,b,c,...,z} given the vocabulary model and the letters.

### Arguments
- `vocabmodel::MyEnglishLanguageVocubularyModel`: This is the vocabulary model that we have created.
- `letters::Array{Char,1}`: This is the array of characters that we are interested in.

### Returns
- `Array{Float64,2}`: This returns back the transition matrix.
"""
function transitionmatrix(vocabmodel::MyEnglishLanguageVocubularyModel, 
    letters::Array{Char,1})::Array{Float64,2}

    # initialize -
    number_of_letters = 26;
    counts = Array{Int64,1}(undef, number_of_letters);
    P = Array{Float64, 2}(undef, number_of_letters, number_of_letters);
    fill!(P, 0.0); # initially all the elements are zero
    fill!(counts,0.0); # initially counts has all zeros

    # TODO: code to implement the transition matrix
    throw("The transitionmatrix(...) function is not implemented yet!");

    # return the transition matrix -
    return P;
end

"""
    samples(P::Array{Float64,2}, letters::Array{Char,1};
        number_of_samples::Int64 = 100, length_of_sample_word::Int64 = 4, startchar::Char = 'z') -> Dict{Int64,String}

This function generates sample words of a specified length from the transition matrix P given the letters.

### Arguments
- `P::Array{Float64,2}`: This is the transition matrix.
- `letters::Array{Char,1}`: This is the array of characters that we are interested in.
- `number_of_samples::Int64`: This is the number of samples that we want to generate.
- `length_of_sample_word::Int64`: This is the length of the sample word that we want to generate.
- `startchar::Char`: This is the starting character of the sample word.

### Returns
- `Dict{Int64,String}`: This returns back a dictionary of sample words. The key is the index of the sample word and the value is the sample word.
"""
function samples(P::Array{Float64,2}, letters::Array{Char,1};
    number_of_samples::Int64 = 100, length_of_sample_word::Int64 = 4, 
    startchar::Char = 'z')::Dict{Int64,String}


    # initialize
    sample_word_start_char = startchar;
    letterindexmap = Dict{Int64,Char}()
    for i ∈ eachindex(letters)
        letterindexmap[i] = letters[i];
    end

    state_distribution_dictionary = Dict{Char,Categorical}();
    for i ∈ eachindex(letters)
        letter = letters[i];
        state_distribution_dictionary[letter] = Categorical(P[i,:]);
    end

    generated_word_dictionary = Dict{Int64,String}();
    for i ∈ 1:number_of_samples
        current_char = sample_word_start_char;
    
        wordvector = Array{Char,1}();
        push!(wordvector,current_char);
        for _ ∈ 2:length_of_sample_word
            d = state_distribution_dictionary[current_char];
            next_char = rand(d) |> k-> letterindexmap[k]; # returns back the char
            push!(wordvector,next_char);
            current_char = next_char;
        end

        generated_word_dictionary[i] = wordvector |> join
    end

    # return -
    return generated_word_dictionary;
end