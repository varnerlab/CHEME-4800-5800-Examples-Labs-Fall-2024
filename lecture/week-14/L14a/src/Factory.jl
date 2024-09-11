function _build(modeltype::Type{T}, data::NamedTuple)::T where T <: AbstractPolygonEndpointModel
   
    # build an empty model
    model = modeltype();

    # if we have options, add them to the contract model -
    if (isempty(data) == false)
        for key ∈ fieldnames(modeltype)
            
            # check the for the key - if we have it, then grab this value
            value = nothing
            if (haskey(data, key) == true)
                value = data[key] # get the value
            end

            # set -
            setproperty!(model, key, value)
        end
    end
 
    # return -
    return model   
end

# -- PUBLIC FUNCTIONS BELOW THIS LINE -------------------------------------------------------------------- #
build(model::Type{T}, data::NamedTuple) where T <: AbstractPolygonEndpointModel = _build(model, data);


"""
    buildurl(base::String, model::MyPolygonStocksAggregatesEndpointModel; 
        apiversion::Int64 = 2) -> String
"""
function build(base::String, model::MyPolygonStocksAggregatesEndpointModel; 
    apiversion::Int64 = 2)::String

    # get data from the model to build the url -
    apikeuy = model.apikey;
    stocksTicker = model.stocksTicker;
    multiplier = model.multiplier;
    timespan = model.timespan;
    from = model.from;
    to = model.to;
    adjusted = model.adjusted;
    sort = model.sort;
    limit = model.limit;

    # build the base url -
    url_string = "$(base)/v$(apiversion)/aggs/ticker/$(stocksTicker)/range/$(multiplier)/$(timespan)/$(from)/$(to)?adjusted=$(adjusted)&sort=$(sort)&limit=$(limit)&apiKey=$(apikeuy)"

    # return -
    return url_string;
end

# -- PUBLIC FUNCTIONS ABOVE THIS LINE -------------------------------------------------------------------- #