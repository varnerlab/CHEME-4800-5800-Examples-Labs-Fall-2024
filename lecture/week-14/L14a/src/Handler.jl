# --- PRIVATE METHODS BELOW HERE ------------------------------------------------------------------------------- #
function _default_handler_process_weather_response(model::Type{T}, 
    response::String) where T <: AbstractWeatherEndpointModel

    # initialize -
    type_handler_dict = Dict{Any,Function}()

    # hardcode the response handler -
    type_handler_dict[MyWeatherGridPointEndpointModel] = (x::String) -> JSON.parse(x) # default handler
    type_handler_dict[MyWeatherForecastEndpointModel] = (x::String) -> JSON.parse(x) # default handler

    # lookup the function to handle the response -
    if (haskey(type_handler_dict, model) == true)
        handler_function = type_handler_dict[model]
        return handler_function(response);
    end

    # default: return nothing
    return nothing
end
# --- PRIVATE METHODS ABOVE HERE ------------------------------------------------------------------------------- #

# --- PUBLIC METHODS BELOW HERE -------------------------------------------------------------------------------- #
"""
    process_forecast_response_dataframe(model::Type{T}, response::String) -> DataFrame where T <: AbstractWeatherEndpointModel

This function is used to process the response from the National Weather Service API. 
It takes two arguments, a model of type `T`, and a response string.
We parse the response string, and return a `DataFrame` populated from the response. 
"""
function process_forecast_response_dataframe(model::Type{T}, response::String)::DataFrame where T <: AbstractWeatherEndpointModel

    # initialize -
    dataframe = DataFrame();

    # parse the response -
    response_dict = JSON.parse(response);
    for data ∈ response_dict["properties"]["periods"]
        
        # put data into a row. This is an example of a NamedTuple
        row = (
            startTime = data["startTime"],
            endTime = data["endTime"],
            isDayTime = data["isDaytime"],
            temperature = data["temperature"],
            temperatureUnit = data["temperatureUnit"],
            windSpeed = data["windSpeed"],
            windDirection = data["windDirection"],
            shortForecast = data["shortForecast"]
        );
        push!(dataframe, row);
    end
 
    return dataframe
end
# --- PUBLIC METHODS ABOVE HERE -------------------------------------------------------------------------------- #