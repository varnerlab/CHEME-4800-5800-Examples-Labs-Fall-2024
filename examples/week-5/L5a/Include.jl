# Setup the paths
const _ROOT = @__DIR__
const _PATH_TO_SRC = joinpath(_ROOT, "src")

# if we are missing any packages, install them -
using Pkg
Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();

# load external package -
using BenchmarkTools
using DataFrames
using Statistics
using Plots
using Colors

# include my codes -
include(joinpath(_PATH_TO_SRC, "Compute.jl"));