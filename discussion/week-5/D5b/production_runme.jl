# include the Include.jl -
include("Include.jl")

# Step 1: load the reaction file 
path_to_reactions_file = joinpath(_PATH_TO_DATA, "Reactions.net")

# Step 2: parse the list of chemical reaction strings -
reactions = read_reaction_file(path_to_reactions_file);

# TODO: Build the reaction_name_array -
reaction_name_array = Array{String,1}();
for (k,v) ∈ reactions
    push!(reaction_name_array, v.name)
end
sort!(reaction_name_array); # sorts the array in place.

# TODO: Build the species_formula_array -
tmp = Set{String}();
for (name,model) in reactions
    
    d_reactants = recursivesplit(model.reactants, delim='+');
    d_products = recursivesplit(model.products, delim='+');
   
    # process the reactants -
    for (k,v) in d_reactants
        push!(tmp, v)
    end

    # process the products -
    for (k,v) in d_products
        push!(tmp, v)
    end
end
species_formula_array = tmp |> collect |> sort; # we want to sort the array, so that we establish a consistent order.

# TODO: Challenge problem: build the stoichiometry_matrix
# ...