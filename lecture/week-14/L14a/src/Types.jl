abstract type AbstractWeatherEndpointModel end

mutable struct MyWeatherGridPointEndpointModel <: AbstractWeatherEndpointModel

    # data -
    latitude::Float64
    longitude::Float64
  
    # methods -
    MyWeatherGridPointEndpointModel(; 
        latitude::Float64 = 0.0, longitude::Float64 = 0.0) = new(latitude, longitude);
end

mutable struct MyWeatherForecastEndpointModel <: AbstractWeatherEndpointModel
    MyWeatherForecastEndpointModel() = new(); # empty
end