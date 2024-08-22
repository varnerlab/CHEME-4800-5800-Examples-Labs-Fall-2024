# setup paths -
const _ROOT = pwd();

# # make sure all is up to date - but only do this once
using Pkg;
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# load packages
using DataFrames
using PrettyTables
using Unicode