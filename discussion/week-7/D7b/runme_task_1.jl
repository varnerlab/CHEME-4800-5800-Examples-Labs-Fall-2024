# include -
include("Include.jl");

# setup path for Toy.net -
path_to_reaction_file = joinpath(_PATH_TO_DATA, "Toy.net");

# load the reaction file -
R = readreactionfile(path_to_reaction_file, comment="//", delim=',', expand = false);

# build the stoichiometric matrix -
S = build(MyStoichiometricMatrixModel, R);