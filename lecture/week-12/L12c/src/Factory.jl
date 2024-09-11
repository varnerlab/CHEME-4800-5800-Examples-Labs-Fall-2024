"""
    build(type::MyRectangularGridWorldModel, nrows::Int, ncols::Int, 
        rewards::Dict{Tuple{Int,Int}, Float64}; defaultreward::Float64 = -1.0) -> MyRectangularGridWorldModel
"""
function build(modeltype::Type{MyRectangularGridWorldModel}, data::NamedTuple)::MyRectangularGridWorldModel

    # initialize and empty model -
    model = MyRectangularGridWorldModel()

    # get the data -
    nrows = data[:nrows]
    ncols = data[:ncols]
    rewards = data[:rewards]
    defaultreward = haskey(data, :defaultreward) == false ? -20.0 : data[:defaultreward]

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
    moves[1] = (-1,0)   # a = 1 up
    moves[2] = (1,0)    # a = 2 down
    moves[3] = (0,-1)   # a = 3 left
    moves[4] = (0,1)    # a = 4 right

    nactions = 4;
    nstates = (nrows*ncols);

    # add items to the model -
    model.rewards = rewards_dict
    model.coordinates = coordinates
    model.states = states;
    model.moves = moves;
    model.number_of_rows = nrows
    model.number_of_cols = ncols
    model.terminal_states = data.terminal_states
    model.𝒮 = range(1,stop=nstates, step=1) |> collect;
    model.𝒜 = range(1,stop=nactions, step=1) |> collect;
    model.treenodes = Dict{Tuple{Int,Int}, MyMCTSTreeNodeModel}()

    # return -
    return model
end

function build(modeltype::Type{MyMCTSTreeNodeModel}, data::NamedTuple)::MyMCTSTreeNodeModel

    # initialize -
    model = modeltype();

    # get the data -
    position = data.position;
    score = data.score;
    timesvisited = data.timesvisited;
    parent = data.parent
    children = data.children;
    action = data.action;

    # add items to the model -
    model.position = position;
    model.score = score;
    model.timesvisited = timesvisited;
    model.parent = parent;
    model.children = children;
    model.action = action;

    # return -
    return model
end