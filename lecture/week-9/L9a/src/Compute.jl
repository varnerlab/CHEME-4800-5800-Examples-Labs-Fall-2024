# --- PRIVATE METHODS BELOW HERE ------------------------------------------------------------------------------------------------ #
function _extract_species_dictionary!(dictionary::Dict{String,Float64}, phrase::String;
	direction::Float64 = -1.0)
	
	# ok, do we hve a +?
	component_array = split(phrase,'+');
	for component ∈ component_array

		if (contains(component,'*') == true)
			
			tmp_array = split(component,'*')
			st_coeff = direction*parse(Float64, tmp_array[1])
			species_symbol = String(tmp_array[2])

			# don't cache the [] -
			if (species_symbol != "[]")
				dictionary[species_symbol] = st_coeff
			end
		else 
			
			# strip any spaces -
			species_symbol = component |> lstrip |> rstrip

			# don't cache the ∅ -
			if (species_symbol != "[]")
				dictionary[species_symbol] = direction*1.0
			end
		end
	end
end

function _compute_stoichiometry(reactants::String, products::String)::Dict{String, Float64}

    # initialize -
    stoichiometry = Dict{String, Float64}();

    # split the reactants and products -
    _extract_species_dictionary!(stoichiometry, reactants, direction = -1.0);
    _extract_species_dictionary!(stoichiometry, products, direction = 1.0);

    # return -
    return stoichiometry;
end

function _compute_stoichiometric_matrix(reactions::Dict{Int64, MyChemicalReactionModel})::Tuple{Array{Float64,2}, Array{String,1}, Array{String,1}}

     # initialize -
     number_of_reactions = length(reactions);
     number_of_species = 0;
 
    # loop over the reactions, store the names in the *same* order as the reaction file
    reactionnames = Array{String,1}();
    for i ∈ 1:number_of_reactions
        push!(reactionnames, reactions[i].name);
    end
 
     # use the stoichiometry to build a species set, sort it -
     tmp_set = Set{String}();
     for (_,model) ∈ reactions
         model.stoichiometry |> (x -> keys(x)) .|> (x -> push!(tmp_set, x));
     end
     speciesnames = tmp_set |> (x -> collect(x)) |> (x -> sort(x));
     number_of_species = length(speciesnames);
 
     # build the matrix -
     matrix = zeros(Float64, number_of_species, number_of_reactions);
     for i ∈ 1:number_of_species
         species = speciesnames[i];
         for j ∈ 1:number_of_reactions
             if (haskey(reactions[j].stoichiometry, species) == true)
                 matrix[i,j] = reactions[j].stoichiometry[species];
             end
         end
     end
 
     # return -
     return (matrix, speciesnames, reactionnames);
end

"""
    ⊗(a::Array{Float64,1},b::Array{Float64,1}) -> Array{Float64,2}

Compute the outer product of two vectors `a` and `b` and returns a matrix.

### Arguments
- `a::Array{Float64,1}`: a vector of length `m`.
- `b::Array{Float64,1}`: a vector of length `n`.

### Returns
- `Y::Array{Float64,2}`: a matrix of size `m x n` such that `Y[i,j] = a[i]*b[j]`.
"""
function ⊗(a::Array{Float64,1},b::Array{Float64,1})::Array{Float64,2}

    # initialize -
    m = length(a)
    n = length(b)
    Y = zeros(m,n)

    # main loop 
    for i ∈ 1:m
        for j ∈ 1:n
            Y[i,j] = a[i]*b[j]
        end
    end

    # return 
    return Y
end

function indifference(problem::MyLinearProgrammingProblemModel, U::Float64, xlim::Array{Float64,2};
    ϵ::Float64 = 0.01)::Array{Float64,2}

   
    # Use the VLDecisionsPackage to compute the indifference curve -
    model = VLDecisionsPackage.build(VLLinearUtilityFunction, (
        α = problem.c,
    ));
    tmp = VLDecisionsPackage.indifference(model; utility = U, bounds = xlim, ϵ = ϵ);

    # return array -
    return tmp;
end

function budget(problem::MyLinearProgrammingProblemModel, xlim::Array{Float64,1}, total::Float64)::Array{Float64,2}

    # initialize -
    c = problem.A;
    I = total;

    # set values for the good and service 1
    X1 = range(xlim[1], stop=xlim[2], step = 0.001) |> collect;
    d = length(X1);

    Y = Array{Float64,2}(undef,d,2);
    for j ∈ 1:d

        tmp = (1/c[2])*(I - c[1]*X1[j]);

        Y[j,1] = X1[j];
        Y[j,2] = tmp
    end

    # return -
    return Y;
end

