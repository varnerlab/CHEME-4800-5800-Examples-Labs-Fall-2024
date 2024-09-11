abstract type AbstractPolygonEndpointModel end

# Each endpoint model will be a struct that will contain the parameters that are required 
# to make the request to the Polygon API.
mutable struct MyPolygonStocksAggregatesEndpointModel <: AbstractPolygonEndpointModel

    # data -
    # see: https://polygon.io/docs/stocks
    apikey::String
    stocksTicker::String
    multiplier::Int
    timespan::String
    from::Date
    to::Date
    adjusted::Bool
    sort::String
    limit::Int

    # constructor -
    MyPolygonStocksAggregatesEndpointModel() = new();
end