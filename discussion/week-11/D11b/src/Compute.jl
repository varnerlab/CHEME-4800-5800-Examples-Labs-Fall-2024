"""
"""
function transitionmatrix(vocabmodel::MyEnglishLanguageVocubularyModel, 
    letters::Array{Char,1})

    # initialize -
    number_of_letters = 26;
    counts = Array{Int64,1}(undef, number_of_letters);
    P = Array{Float64, 2}(undef, number_of_letters, number_of_letters);
    fill!(P, 0.0); # initialy all the elements are zero
    fill!(counts,0.0); # initially counts has all zeros

    # process each letter
    for i ∈ eachindex(letters)
        startchar = letters[i];
        
        # get all the words that start with the startchar -
        set_of_words = vocabmodel.wordsdictionary[startchar] |> copy; # copy the set
        N = 0; # how many words have we processed?
        while (isempty(set_of_words) == false)
            word = pop!(set_of_words); # grab a word
            
            # get the second char of word -
            if (length(word) ≥ 2)
                next_char = word[2]; # get the second character in the word
                j = findfirst(x-> x == next_char, letters); # this gives me the index of the next_char
                counts[j] = counts[j] + 1;
                N += 1; # update the count of word samples that we explored
            end
        end
        
        # fill in the P -
        for k ∈ 1:number_of_letters
            P[i,k] = counts[k]/N;
        end

        # empty counts -
        fill!(counts,0.0); # fill it back up with zeros
    end

    # return the transition matrix -
    return P;
end

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