# setup paths -
const _ROOT = @__DIR__
const _PATH_TO_SRC = joinpath(_ROOT, "src");

# Load packages -
using Pkg
# Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# using -
using LinearAlgebra
using Statistics
using PrettyTables
using DataFrames
using Distributions

# plot related packages -
using Plots
using Colors
using StatsPlots

# load my codes -
include(joinpath(_PATH_TO_SRC, "Types.jl"))
include(joinpath(_PATH_TO_SRC, "Factory.jl"))
include(joinpath(_PATH_TO_SRC, "Compute.jl"))
include(joinpath(_PATH_TO_SRC, "Bandit.jl"))
