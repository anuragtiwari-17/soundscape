import 'package:dio/dio.dart';

import '../model/weather_model.dart';

Future<WeatherModel?> getApi(String URL) async {
  Dio dio = Dio();
  try {
    final response = await dio.get(URL);
    if (response.statusCode == 200) {
      print("Data received: ${response.data}");
      // Parse the JSON response into a WeatherModel instance
      WeatherModel weatherData = WeatherModel.fromJson(response.data);
      // Print parsed data for verification
      print("Location: ${weatherData.location}");
      print("Temperature: ${weatherData.temperature}°C");
      print("Condition: ${weatherData.condition}");
      return weatherData;
    } else {
      // Handle non-200 status codes
      print("Error: API call failed with status code ${response.statusCode}");
      return null;
    }
  } catch (error) {
    // Handle errors during the network call
    print("Error: An error occurred while fetching data: $error");
    return null;
  }
}
