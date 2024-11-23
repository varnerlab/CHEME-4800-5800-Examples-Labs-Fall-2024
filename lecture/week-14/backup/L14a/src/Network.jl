function _http_get_call_with_url(url::String)::Some{Union{ErrorException, String}}

    try

        # should we check if this string is formatted as a URL?
        if (occursin("https://", url) == false)
            throw(ArgumentError("url $(url) is not properly formatted"))
        end

        # ok, so we are going to make a HTTP GET call with the URL that was passed in -
        # we want to handle the errors on our own, so do NOT have HTTP.jl throw an excpetion -
        response = HTTP.request("GET", url; status_exception = false)

        # check the status code, through an error if we have a problem -
        if (response.status != 200)
            throw(ErrorException("HTTP GET call failed with status code $(response.status)"))
        end

        # return the body -
        return Some(String(response.body))
    catch error

        # get the original error message -
        error_message = sprint(showerror, error, catch_backtrace())
        vl_error_obj = ErrorException(error_message)

        # Package the error -
        return Some(vl_error_obj)
    end
end

function _api(model::Type{T}, complete_url_string::String;
    handler::Function = _default_response_handler)::Any where T <: AbstractPolygonEndpointModel

    # execute -
    result_model = _http_get_call_with_url(complete_url_string);
    result_string = nothing
    if (result_model |> something isa ErrorException)
        @show "Error: $(result_model |> something)"
    elseif (result_model |> something isa Nothing)
        @show "Error: unknown error"
    else
       result_string = result_model |> something
    end

    # process and return -
    return handler(model, result_string)
end

# -- PUBLIC FUNCTIONS BELOW THIS LINE ----------------------------------------------------------------------------------------------------------- #
# Super flex: what is going on here???
(model::Type{MyPolygonStocksAggregatesEndpointModel})(baseurl::String)::DataFrame = _api(model, baseurl; handler = _default_response_handler)
# -- PUBLIC FUNCTIONS ABOVE THIS LINE ----------------------------------------------------------------------------------------------------------- #