# `Lab 4b`: Build a Software Development Kit for the National Weather Service API
In `Lab 4b`, students will build a Software Development Kit (SDK) for the [National Weather Service API](https://www.weather.gov/documentation/services-web-api). We'll pull down weather data for Ithaca, NY, using the `(latitude, longitude)` coordinates `42.443961` and `-76.501881`. We'll use the `points` endpoint to get the grid data for this location and use this data for additional calls. 

## Prerequisite 
Break up into teams of 2-3 people and take `10 min` to walk through all the files (starting with `Include.jl` in the `root` directory) in `Lab-4b` and the [National Weather Service API documentation](https://www.weather.gov/documentation/services-web-api). At the end of `10 min`, we'll do a class Q&A to ensure everyone understands the purpose of each file.

## Tasks: Complete the implementation of `runme_ithaca_v1.jl`

* Build a [mutable struct model](https://docs.julialang.org/en/v1/manual/types/#Composite-Types) of the `points` endpoint we want to call. This `struct` should have a field for each piece of information that we need to pass to the `API` with the same names as the `endpoint` (convention, not required)
    * Complete the implementation of the `MyWeatherGridPointEndpointModel` struct in `src/Types.jl`. This should be a mutable struct with fields for `latitude,` and `longitude.` It should have a constructor that takes `latitude` and `longitude` as keyword arguments, so can build the `struct` with a call like:
    
    ```julia
     model = MyWeatherGridPointEndpointModel(latitude=42.443961, longitude=-76.501881)
     ```

* Build a properly formatted [uniform resource locator (URL) string](https://en.wikipedia.org/wiki/URL) containing the information needed by the `points` endpoint.
    * Finish the implementation of the `build` function in `src/Factory.jl` to build the `points` endpoint URL string, where we pass in the `baseurl::String` and an instance of the `MyWeatherGridPointEndpointModel` and get back a properly formatted URL string: `https://api.weather.gov/points/42.443962,-76.501884`

* Call the `API` and parse your response using the `default` handler. Let's try an interesting pattern common in the `Juliaverse` that makes it look like you are calling a method on a `struct.` Try this:
    
    ```julia
    result_points = MyWeatherGridPointEndpointModel(points_url_string);
    ```

* Let's dig into the `result_points` dictionary and see what we can find. In particular, let's look at the `properties` key and see what we can find there (there is a lot of information and something pretty interesting for us).

## Tasks: Complete the implementation of `runme_ithaca_v2.jl`
Let's use a `custom data handler` to transform the response data. The `runme_ithaca_v2.jl` script will have all the same tasks as `runme_ithaca_v1.jl`, but we will be calling the `forecast` endpoint with a custom handler function `process_forecast_response_dataframe` (to get back a `DataFrame` instead of a tree of dictionaries).
* This is an advanced topic. Let's walk through how these components work, what methods are called, etc.
