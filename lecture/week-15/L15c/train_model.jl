include("Include.jl")

file_extension(file::String) = file[findlast(==('.'), file)+1:end]

number_of_training_examples = 20;
number_digit_array = range(0,length=10,step=1) |> collect;
image_dictionary = Dict{Int64, Array{Float32,3}}();
for i ∈ number_digit_array
    
    # create a set for this digit -
    image_digit_array = Array{Float32,3}(undef, 28, 28, number_of_training_examples);
    files = readdir(joinpath(_PATH_TO_IMAGES,"$(i)")) |> x-> sort(x, rev=false);
    imagecount = 1;
    for fileindex ∈ 1:number_of_training_examples
        filename = files[fileindex];
        ext = file_extension(filename)
        if (ext == "jpg")
            @show filename
            image_digit_array[:,:,fileindex] = joinpath(_PATH_TO_IMAGES, "$(i)", filename) |> x-> FileIO.load(x);
            imagecount += 1
        end
    end

    # capture -
    image_dictionary[i] = image_digit_array
end

# d = joinpath(_PATH_TO_IMAGES, "0", "img_5.jpg")
# m = FileIO.load(d)