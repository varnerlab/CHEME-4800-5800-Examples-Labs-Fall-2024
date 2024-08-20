


# --- PUBLIC METHODS BELOW HERE -------------------------------------------------------------------------------- #
"""
    build(base::String, model::MyWeatherGridPointEndpointModel) -> String

This function is used to build a URL string that can be used to make a HTTP GET call to the National Weather Service API.
It takes two arguments, a base URL string, and a model of type `MyWeatherGridPointEndpointModel`. 
"""
function build(base::String, model::MyWeatherGridPointEndpointModel)::String
    
    # TODO: implement this function, and remove the throw statement
    # throw(ArgumentError("build(base::String, model::MyWeatherGridPointEndpointModel) not implemented yet!"));

    # build the URL string -
    url_string = "$(base)/points/$(model.latitude),$(model.longitude)";

    # return the URL string -
    return url_string;
end
# --- PUBLIC METHODS ABOVE HERE -------------------------------------------------------------------------------- #