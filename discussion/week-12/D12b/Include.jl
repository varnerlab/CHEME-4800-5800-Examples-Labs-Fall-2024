# setup paths -
const _ROOT = pwd();
const _PATH_TO_SRC = joinpath(_ROOT, "src");

# download external packages
using Pkg;
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# Load external packages -
using POMDPs
using POMDPModels # for the SimpleGridWorld problem
using MCTS
using StaticArrays
using Plots
using Colors
using D3Trees

# Load my codes -
include(joinpath(_PATH_TO_SRC, "Compute.jl"));  