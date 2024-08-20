# include -
include("Include.jl");

# let's play with the recursivesplit function -
test_input_string = "Dog+Cat+Mouse+Lizard";

# split the string -
fragments = recursivesplit(test_input_string, delim='+');