# include the include.jl file -
include("Include.jl");

# create an array of random numbers -
length_of_array = 25;
random_input_array = rand(1:number_of_samples, length_of_array);
random_input_array_sorted = sort(random_input_array);
sorted_output_array = bubble_sort(random_input_array; sounds=sound_dictionary);