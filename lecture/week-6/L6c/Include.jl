# setup paths -
const _ROOT = @__DIR__;
const _PATH_TO_SRC = joinpath(_ROOT, "src");
const _PATH_TO_DATA = joinpath(_ROOT, "data");
const _PATH_TO_FRAMES = joinpath(_ROOT, "frames");

# check: do we have the correct packages?
using Pkg;
Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();

# load external package -
using ProgressBars;
using DataStructures;
using Graphs; # this is a 3rd party package for graphs
using GraphIO; # this is a 3rd party package for graph io

# for visualization -
using Karnak
using Colors
using NetworkLayout

# load my codes -
include(joinpath(_PATH_TO_SRC, "Types.jl"));
include(joinpath(_PATH_TO_SRC, "Factory.jl"));
include(joinpath(_PATH_TO_SRC, "Files.jl"));
include(joinpath(_PATH_TO_SRC, "Compute.jl"));
include(joinpath(_PATH_TO_SRC, "Traversal.jl"));
include(joinpath(_PATH_TO_SRC, "Search.jl"));
include(joinpath(_PATH_TO_SRC, "Visualize.jl"));