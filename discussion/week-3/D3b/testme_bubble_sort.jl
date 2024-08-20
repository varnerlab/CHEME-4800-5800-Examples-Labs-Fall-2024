# include -
include("Include.jl");

# let's create a random array of numbers, and then sort it using the mutating version of he bubble sort algorithm -
length_of_array = 25;
random_input_array = rand(1:number_of_samples, length_of_array);
sorted_output_array = bubble_sort(random_input_array; sounds = nothing);

# Let's do an @assert to check if the sorted_output_array is indeed sorted -
# This test makes use of the sorting algorithm provided by Julia: https://docs.julialang.org/en/v1/base/sort/#Base.sort
@assert sorted_output_array == sort(random_input_array) # if sorted, then nothing happens; if not sorted, then an error is thrown