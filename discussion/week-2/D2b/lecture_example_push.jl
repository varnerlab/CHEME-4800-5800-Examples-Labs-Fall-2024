# lets make a push! example =

# Initialize an emprty array of number_of_elements -
number_of_elements = 10;
empty_array = Array{Char,1}(undef, number_of_elements)


# # Let's push some data into the empty array -
test_string_array = "I like the 8-bit version of songs from Nine Inch Nails (NIN)" |> collect;
for i ∈ eachindex(test_string_array)
    push!(empty_array, test_string_array[i])
end