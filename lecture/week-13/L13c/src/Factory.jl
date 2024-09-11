"""
    build(type::Type{MyQLearningModel},data::NamedTuple) -> MyQLearningModel
"""
function build(modeltype::Type{MyQLearningAgentModel}, data::NamedTuple)::MyQLearningAgentModel

    # initialize -
    model = MyQLearningAgentModel();

    # if we have options, add them to the contract model -
    if (isempty(data) == false)
    
        for key ∈ fieldnames(modeltype)
            
            # convert the field_name_symbol to a string -
            field_name_string = string(key)

            # check the for the key -
            if (haskey(data, key) == false)
                throw(ArgumentError("NamedTuple is missing: $(field_name_string)"))
            end

            # get the value -
            value = data[key]

            # set -
            setproperty!(model, key, value)
        end
    end

    # return -
    return model
end

"""
    build(type::Type{MyRectangularGridWorldModel},data::NamedTuple) -> MyRectangularGridWorldModel

This function builds a `MyRectangularGridWorldModel` object from a `NamedTuple` object. 
The `NamedTuple` object must have the following fields:

- `nrows::Int` : the number of rows in the grid
- `ncols::Int` : the number of columns in the grid
- `rewards::Dict{Tuple{Int,Int},Float64}` : a dictionary that maps a coordinate to a reward value
- `defaultreward::Float64` : the default reward value for all coordinates that are not in the `rewards` dictionary
"""
function build(modeltype::Type{MyRectangularGridWorldModel}, data::NamedTuple)::MyRectangularGridWorldModel

    # initialize and empty model -
    model = MyRectangularGridWorldModel()

    # get the data -
    nrows = data[:nrows]
    ncols = data[:ncols]
    rewards = data[:rewards]
    defaultreward = haskey(data, :defaultreward) == false ? -1.0 : data[:defaultreward]

    # setup storage
    rewards_dict = Dict{Int,Float64}()
    coordinates = Dict{Int,Tuple{Int,Int}}()
    states = Dict{Tuple{Int,Int},Int}()
    moves = Dict{Int,Tuple{Int,Int}}()

    # build all the stuff 
    position_index = 1;
    for i ∈ 1:nrows
        for j ∈ 1:ncols
            
            # capture this corrdinate 
            coordinate = (i,j);

            # set -
            coordinates[position_index] = coordinate;
            states[coordinate] = position_index;

            if (haskey(rewards,coordinate) == true)
                rewards_dict[position_index] = rewards[coordinate];
            else
                rewards_dict[position_index] = defaultreward;
            end

            # update position_index -
            position_index += 1;
        end
    end

    # setup the moves dictionary -
    moves[1] = (-1,0)   # a = 1 right
    moves[2] = (1,0)    # a = 2 left
    moves[3] = (0,-1)   # a = 3 down
    moves[4] = (0,1)    # a = 4 up

    # add items to the model -
    model.rewards = rewards_dict
    model.coordinates = coordinates
    model.states = states;
    model.moves = moves;
    model.number_of_rows = nrows
    model.number_of_cols = ncols

    # return -
    return model
end