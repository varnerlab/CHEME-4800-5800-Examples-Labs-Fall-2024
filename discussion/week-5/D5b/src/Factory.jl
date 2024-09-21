"""
    build(type::Type{MyKeggReaction}, name::String, reactants::String, products::String)::MyKeggReaction

Factory method to build an instance of the MyKeggReaction type. MyKeggReaction is a model of the
information contained in the Reactions.net file
"""
function build(modeltype::Type{MyKeggReactionModel}, data::NamedTuple)::MyKeggReactionModel

    # check: name, reactants and products correct?
    # in production, we'd check this. Assume these are ok now
    name = data.name;
    reactants = data.reactants;
    products = data.products;

    # initialize -
    model = modeltype(); # build an empty model 

    # add data to the model -
    model.name = name;
    model.reactants = reactants;
    model.products = products;

    # return -
    return model;
end