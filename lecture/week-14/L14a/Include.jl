# setup paths -
const _ROOT = @__DIR__
const _PATH_TO_SRC = joinpath(_ROOT, "src");

# check: packages installed?
using Pkg
# Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# load packages -
using HTTP
using JSON
using DataFrames
using Test

# load my codes -
include(joinpath(_PATH_TO_SRC, "Types.jl"));
include(joinpath(_PATH_TO_SRC, "Factory.jl"));
include(joinpath(_PATH_TO_SRC, "Network.jl"));
include(joinpath(_PATH_TO_SRC, "Handler.jl"));