# setup paths -
const _ROOT = joinpath(@__DIR__); # check out the @__DIR__ macro here: https://docs.julialang.org/en/v1/base/base/#Base.@__DIR__
const _PATH_TO_SRC = joinpath(_ROOT, "src");
const _PATH_TO_SOUNDS = joinpath(_ROOT, "sounds");

# import external packages -
using WAV; # this is a package for reading and writing .wav files (sounds)
using PrettyTables; # this is a package for creating nice tables
using DataFrames; # this is a package for creating dataframes

# load my codes -
include(joinpath(_PATH_TO_SRC, "Compute.jl"));
include(joinpath(_PATH_TO_SRC, "Sounds.jl"));

# load the sounds library -
sound_dictionary = Dict{Int64, Tuple{Matrix{Float64}, Float32}}()
number_of_samples = 128;
for i ∈ 1:number_of_samples
    filename = joinpath(_PATH_TO_SOUNDS, "example-$(i).wav")
    y, fs = wavread(filename)
    sound_dictionary[i] = (y, fs)
end