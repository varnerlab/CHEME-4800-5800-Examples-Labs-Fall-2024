function _build(modeltype::Type{MyChemicalReactionModel}, 
    name::String, reactants::String, products::String, reversible::Bool)::MyChemicalReactionModel

    # initialize -
    model = modeltype(); # build an reaction empty model 

    # add data to the model -
    model.name = name;
    model.reactants = reactants;
    model.products = products;
    model.reversible = reversible;

    # compute the stoichiometric coefficients for this reaction, store them in the stoichiometry dictionary
    model.stoichiometry = _compute_stoichiometry(reactants, products);

    # return -
    return model;
end

"""
    build(modeltype::Type{MyStoichiometricMatrixModel}, 
        reactions::Dict{Int64, MyChemicalReactionModel}) -> MyStoichiometricMatrixModel

Builds a stoichiometric matrix model from a set of chemical reactions objects.

### Arguments
- `modeltype::Type{MyStoichiometricMatrixModel}`: The type of the model to build
- `reactions::Dict{Int64, MyChemicalReactionModel}`: A dictionary of chemical reactions

### Returns
- `MyStoichiometricMatrixModel`: A stoichiometric matrix model with fields `species`, `reactions` and `matrix`. 
The  `matrix` is the matrix of stoichiometric coefficients of the reactions, `species` is a list of species and `reactions` is a list of reaction names.
"""
function build(modeltype::Type{MyStoichiometricMatrixModel}, 
    reactions::Dict{Int64, MyChemicalReactionModel})::MyStoichiometricMatrixModel

    # initialize -
    model = modeltype(); # build an empty model 

    # call the internal function -
    (matrix, species, reactionnames) = _compute_stoichiometric_matrix(reactions);

    # set the data -
    model.species = species;
    model.reactions = reactionnames;
    model.matrix = matrix;

    # return -
    return model;
end