# include -
include("Include.jl");

# setup
number_of_samples = 100;
length_of_sample_word = 4;
sample_word_start_char = 't';
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

