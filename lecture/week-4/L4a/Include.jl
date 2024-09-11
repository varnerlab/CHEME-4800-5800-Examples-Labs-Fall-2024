# setup paths -
const _ROOT = @__DIR__
const _PATH_TO_SRC = joinpath(_ROOT, "src")
const _PATH_TO_POSITIVE_REVIEWS = joinpath(_ROOT, "data", "reviews", "pos")
const _PATH_TO_NEGATIVE_REVIEWS = joinpath(_ROOT, "data", "reviews", "neg")

# check: packages installed?
using Pkg


# load external packages -
using Test

# load my codes -
include(joinpath(_PATH_TO_SRC, "Types.jl"))
include(joinpath(_PATH_TO_SRC, "Factory.jl"))
include(joinpath(_PATH_TO_SRC, "Files.jl"))
include(joinpath(_PATH_TO_SRC, "Compute.jl"))

