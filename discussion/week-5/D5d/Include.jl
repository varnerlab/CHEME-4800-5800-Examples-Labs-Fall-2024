# setup paths -
const _ROOT = @__DIR__ 
const _PATH_TO_SRC = joinpath(_ROOT, "src");
const _PATH_TO_FIGS = joinpath(_ROOT, "figs");

# if we don't have the packages installed, then install them
using Pkg
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# load external packages -
using DataStructures
using Distributions
using Images
using ImageInTerminal
using Colors
using FileIO
using Statistics
using Test
using ProgressBars
using Printf
using JLD2

# load my codes -
include(joinpath(_PATH_TO_SRC, "Types.jl"));
include(joinpath(_PATH_TO_SRC, "Factory.jl"));
include(joinpath(_PATH_TO_SRC, "Compute.jl"));