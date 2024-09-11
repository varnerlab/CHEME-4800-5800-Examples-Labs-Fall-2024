const _ROOT = @__DIR__
const _PATH_TO_SRC = joinpath(_ROOT, "src");

# id we don't have a pack then load it
using Pkg
Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();

# load external package
# ...

# load my codes
include(joinpath(_PATH_TO_SRC, "Types.jl"))
include(joinpath(_PATH_TO_SRC, "Factory.jl"))
include(joinpath(_PATH_TO_SRC, "Compute.jl"))
