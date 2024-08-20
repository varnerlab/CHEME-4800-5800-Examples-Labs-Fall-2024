# setup paths -
const _ROOT = dirname(@__DIR__);
const _PATH_TO_DATA = joinpath(_ROOT, "data");
const _PATH_TO_SRC = joinpath(_ROOT, "src");

# load external package -
using JLD2
using FileIO
using DataFrames

# include my codes -
include(joinpath(_PATH_TO_SRC, "Files.jl"));