// weather_controller.dart (Example)
import 'package:get/get.dart';

class WeatherController extends GetxController {
  var location = 'Semarang'.obs; // Observable variable
  var temperature = '29°C'.obs; // Observable variable
  var condition = 'Cloudy'.obs; // Observable variable
  var humidity = '54%'.obs; // Observable variable
  var time = '06:00 AM'.obs; // Observable variable
  var windSpeed = '15 km/h'.obs; // Observable variable

  // You can add methods to update these values
  void updateWeather(String newLocation, String newTemperature) {
    location.value = newLocation;
    temperature.value = newTemperature;
  }
}
