# setup paths -
const _ROOT = pwd()
const _PATH_TO_SRC = joinpath(_ROOT, "src")
const _PATH_TO_FRAMES = joinpath(_ROOT, "frames")

# check: packages are installed?
import Pkg;
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# load external packages -
using LinearAlgebra
using Images
using TestImages
using ImageMagick
using ImageIO
using DelimitedFiles
using BenchmarkTools


# include my codes -
include(joinpath(_PATH_TO_SRC, "Compute.jl"))
