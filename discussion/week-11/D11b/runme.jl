# include -
include("Include.jl");

# setup
number_of_samples = 100;
length_of_sample_word = 4;
sample_word_start_char = 'b';
letters = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p',
    'q','r','s','t','u','v','w','x','y','z'];

# build a vocabulary model 
pathtofile = joinpath(_PATH_TO_DATA, "words_dictionary.json");
vocabmodel = build(MyEnglishLanguageVocubularyModel, pathtofile);

# Let's build a transition matrix for words in our vocabulary model
P = transitionmatrix(vocabmodel, letters);

# generate samples -
S = samples(P,letters, number_of_samples = number_of_samples, 
    length_of_sample_word = length_of_sample_word, startchar = sample_word_start_char);

# how many of these samples are in the vocabulary model?
N₊ = 0;
my_word_set = vocabmodel.wordsdictionary[sample_word_start_char];
for i ∈ 1:number_of_samples
    if S[i] ∈ my_word_set
        global N₊ += 1;
        @show S[i];
    end
end
println("Fraction of samples in the vocabulary model: ", N₊/number_of_samples);