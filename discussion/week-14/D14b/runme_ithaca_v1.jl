# include -
include("Include.jl");

# let's get the data for Ithaca, NY -

# New Pattern for building the struct directly *instead* of using the factory method
# We are building the struct directly *instead* of using the factory method, 
# and using keywaord arguments to set the values of the fields.
model = MyWeatherGridPointEndpointModel(latitude = 42.443962, longitude = -76.501884);

# Build a url string that has the proper format for the api call
points_url_string = build("https://api.weather.gov", model);

# make the api call, process the response, and return the result -
# New Pattern: This makes it look we are calling a method on on object, but we are not.
# We are calling the _api function that takes two arguments, the first is a type, and the second is a string.
result_points = MyWeatherGridPointEndpointModel(points_url_string);

# grab the forcast, and call api again -
forecast_url = result_points["properties"]["forecastHourly"];

# New Pattern: This makes it look we are calling a method on on object, but we are not.
# We are calling the _api function that takes two arguments, the first is a type, and the second is a string.
result_forecast = MyWeatherForecastEndpointModel(forecast_url);