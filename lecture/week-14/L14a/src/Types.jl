abstract type AbstractWeatherEndpointModel end

"""
    mutable struct MyWeatherGridPointEndpointModel <: AbstractWeatherEndpointModel

A model for the weather grid point endpoint.

### Fields
- `latitude::Float64` - The latitude of the grid point.
- `longitude::Float64` - The longitude of the grid point.

### Constructors
- `MyWeatherGridPointEndpointModel(; latitude::Float64 = 0.0, longitude::Float64 = 0.0)` - Returns a new `MyWeatherGridPointEndpointModel` instance.
"""
mutable struct MyWeatherGridPointEndpointModel <: AbstractWeatherEndpointModel

    # data -
    latitude::Float64
    longitude::Float64
  
    # methods -
    MyWeatherGridPointEndpointModel(; 
        latitude::Float64 = 0.0, longitude::Float64 = 0.0) = new(latitude, longitude);
end

"""
    mutable struct MyWeatherForecastEndpointModel <: AbstractWeatherEndpointModel

A model for the weather forecast endpoint. This type is empty, with no fields.
"""
mutable struct MyWeatherForecastEndpointModel <: AbstractWeatherEndpointModel
    MyWeatherForecastEndpointModel() = new(); # empty
end