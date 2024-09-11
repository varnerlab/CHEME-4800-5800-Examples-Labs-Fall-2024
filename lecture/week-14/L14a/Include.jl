# setup paths -
const _ROOT = @__DIR__
const _PATH_TO_SRC = joinpath(_ROOT, "src")
const _PATH_TO_CONFIG = joinpath(_ROOT, "conf")

# check: do we have the required packages installed?
using Pkg
Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();

# load external package -
using HTTP
using JSON
using DataFrames
using CSV
using Dates
using TOML
using Plots
using Colors

# load my codes -
include(joinpath(_PATH_TO_SRC, "Types.jl"))
include(joinpath(_PATH_TO_SRC, "Factory.jl"))
include(joinpath(_PATH_TO_SRC, "Network.jl"))
include(joinpath(_PATH_TO_SRC, "Handlers.jl"))