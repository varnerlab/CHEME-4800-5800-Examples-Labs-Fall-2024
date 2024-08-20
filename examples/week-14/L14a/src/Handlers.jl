
function _polygon_stocks_aggregates_response_handler(response::String)::DataFrame
    
    # parse the response -
    json_response = JSON.Parser.parse(response)
    dataframe = DataFrame();
    
    # get the results -
    if (haskey(json_response, "results") == true)
        
        # get the results array: this is an array of dictionaries -
        results = json_response["results"];
        for data ∈ results
            
            # build a row: this an example of a NamedTuple
            row = (
                v = data["v"],
                vw = data["vw"],
                o = data["o"],
                c = data["c"],
                h = data["h"],
                l = data["l"],
                t = unix2datetime(data["t"]*(1/1000)),
                n = data["n"]
            );
            push!(dataframe, row)
        end

        # return -
        return dataframe;
    else
        throw(ErrorException("no results found in response"))
    end

    # return nothing -
    return nothing
end



function _default_response_handler(model::Type{T}, response::String) where T <: AbstractPolygonEndpointModel

    # initialize -
    type_handler_dict = Dict{Any,Function}()

    # hardcode the response handler -
    type_handler_dict[MyPolygonStocksAggregatesEndpointModel] =  _polygon_stocks_aggregates_response_handler;  # default handler
    
    # lookup the function to handle the response -
    if (haskey(type_handler_dict, model) == true)
        handler_function = type_handler_dict[model]
        return handler_function(response);
    else
        throw(ErrorException("no handler is registered for model type $(model)"))
    end
 
    # default: return nothing
    return nothing
end