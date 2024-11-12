class WeatherModel {
  final String location;
  final String date;
  final String temperature;
  final String condition;
  final String maxTemp;
  final String minTemp;
  final String windSpeed;
  final String humidity;
  final String time;
  WeatherModel({
    required this.time,
    required this.location,
    required this.date,
    required this.temperature,
    required this.condition,
    required this.maxTemp,
    required this.minTemp,
    required this.windSpeed,
    required this.humidity,
  });

  // Factory method to create a WeatherModel from JSON data
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    // Helper function to convert Kelvin to Celsius
    String kelvinToCelsius(double kelvin) =>
        (kelvin - 273.15).toStringAsFixed(1);

    // Parsing fields from the JSON
    final location = json["name"] ?? "Unknown location";
    final date = DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000)
        .toLocal()
        .toString()
        .split(' ')[0];
    final time = DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000)
        .toLocal()
        .toString()
        .split(' ')[1]
        .substring(0, 5);
    final temp = kelvinToCelsius(json["main"]["temp"]);
    final maxTemp = kelvinToCelsius(json["main"]["temp_max"]);
    final minTemp = kelvinToCelsius(json["main"]["temp_min"]);
    final condition = json["weather"][0]["description"] ?? "Unknown";
    final windSpeed = json["wind"]["speed"].toString();
    final humidity = json["main"]["humidity"].toString();

    return WeatherModel(
      time: time,
      location: location,
      date: date,
      temperature: temp,
      condition: condition,
      maxTemp: maxTemp,
      minTemp: minTemp,
      windSpeed: windSpeed,
      humidity: humidity,
    );
  }
}
