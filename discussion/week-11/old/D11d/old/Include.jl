# setup paths -
const _ROOT = pwd();
const _PATH_TO_SRC = joinpath(_ROOT, "src");
const _PATH_TO_DATA = joinpath(_ROOT, "data");

# load external packages -
using Distributions
using Plots
using Colors
using LinearAlgebra
using Statistics
using PrettyTables
using JLD2
using FileIO
using StatsPlots

# load my codes -
include(joinpath(_PATH_TO_SRC, "Types.jl"));
include(joinpath(_PATH_TO_SRC, "Factory.jl"));
include(joinpath(_PATH_TO_SRC, "Compute.jl"));