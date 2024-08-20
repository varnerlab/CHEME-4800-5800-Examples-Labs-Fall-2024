# setup paths -
const _ROOT = pwd();

# download external packages
import Pkg; Pkg.activate("."); Pkg.instantiate(); Pkg.update()

# load external packages -
using VLDecisionsPackage