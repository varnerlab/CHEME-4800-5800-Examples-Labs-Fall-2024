# --- PRIVATE METHODS BELOW HERE ------------------------------------------------------------------------------- #
function _http_get_call_with_url(url::String)::String

    # should we check if this string is formatted as a URL?
    if (occursin("https://", url) == false)
        throw(ArgumentError("url $(url) is not properly formatted"))
    end

    # ok, so we are going to make a HTTP GET call with the URL that was passed in -
    # we want to handle the errors on our own, so do NOT have HTTP.jl throw an excpetion -
    response = HTTP.request("GET", url; status_exception = false)
    if (response.status != 200)
        throw(ArgumentError("HTTP GET call failed with status code $(response.status)"))
    end

    # return the body -
    return response.body |> String;
end

function _api(model::Type{T}, complete_url_string::String;
    handler::Function = _default_handler_process_weather_response) where T <: AbstractWeatherEndpointModel

    # execute the HTTP GET call. This is a blocking call, it uses the HTTP.jl package
    # For more information on the HTTP.jl package, see: https://github.com/JuliaWeb/HTTP.jl
    result_string = _http_get_call_with_url(complete_url_string);

    # process and return -
    return handler(model, result_string)
end
# --- PRIVATE METHODS ABOVE HERE ------------------------------------------------------------------------------- #

# --- PUBLIC METHODS BELOW HERE -------------------------------------------------------------------------------- #

# New pattern: This makes it look we are calling a method on an struct, but we are not!
# We are using the Julia type system (and something called multiple dispatch) to call the correct method.
# For more information on multiple dispatch, see: https://docs.julialang.org/en/v1/manual/methods/#Defining-Methods
(endpoint::Type{T})(url::String; handler::Function = _default_handler_process_weather_response) where T <: AbstractWeatherEndpointModel = _api(endpoint, url, handler = handler)
# --- PUBLIC METHODS ABOVE HERE -------------------------------------------------------------------------------- #