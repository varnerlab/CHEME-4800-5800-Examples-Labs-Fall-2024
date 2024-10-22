# setup paths -
const _ROOT = pwd();
const _PATH_TO_SRC = joinpath(_ROOT, "src");
const _PATH_TO_CONF = joinpath(_ROOT, "conf");
const _PATH_TO_FIGS = joinpath(_ROOT, "figs");

using Pkg;
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# load external packages -
using LinearAlgebra
using JuMP
using GLPK
using TOML
using Plots
using Colors
using Optim

#  include my codes -
include(joinpath(_PATH_TO_SRC, "Types.jl"));
include(joinpath(_PATH_TO_SRC, "Factory.jl"));
include(joinpath(_PATH_TO_SRC, "Compute.jl"));
include(joinpath(_PATH_TO_SRC, "Solve.jl"));
include(joinpath(_PATH_TO_SRC, "Files.jl"));