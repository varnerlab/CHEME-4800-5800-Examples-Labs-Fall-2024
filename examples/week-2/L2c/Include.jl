# setup path structure -
const _ROOT = pwd();
const _PATH_TO_SRC = joinpath(_ROOT, "src")

# # make sure all is up to date - but only do this once
using Pkg;
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# load any external packages -
using UUIDs
using Test

# load my codes -
include(joinpath(_PATH_TO_SRC, "Types.jl"));
include(joinpath(_PATH_TO_SRC, "Factory.jl"))
include(joinpath(_PATH_TO_SRC, "Compute.jl"))