# setup paths -
const _ROOT = @__DIR__
const _PATH_TO_SRC = joinpath(_ROOT, "src");

# check: do we need to download any packages?
using Pkg
Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();

# load the required packages -
using Distributions
using Plots
using Colors
using LinearAlgebra
using Statistics

# load my codes -
# ...