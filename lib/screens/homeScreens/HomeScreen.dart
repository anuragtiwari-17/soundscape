import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:soundscape/app_constants.dart';

import '../../model/weather_model.dart';
import '../../services/gps.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  WeatherModel? weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    Position position = await determinePosition();
    WeatherModel? fetchedData =
        await getGpsLocation(position.latitude, position.longitude);
    setState(() {
      weatherData = fetchedData;
    });
  }
   Widget _getWeatherIcon() {
    if (weatherData?.condition == null) {
      return Icon(Icons.help_outline,
          color: Colors.white, size: 80); // Default icon if no condition
    }

    switch (weatherData!.condition!.toLowerCase()) {
      case 'clear sky':
        return SvgPicture.asset('assets/images/sunny.svg', width: 80, height: 80);
      case 'cloudy':
        return SvgPicture.asset('assets/images/sun cloudy.svg', width: 80, height: 80);
      case 'rainy':
        return SvgPicture.asset('assets/images/rainy.svg', width: 80, height: 80);
      case 'snowy':
        return SvgPicture.asset('assets/images/snowy.svg', width: 80, height: 80);
      case 'storme':
        return SvgPicture.asset('assets/images/storme.svg', width: 80, height: 80);
      default:
        return Icon(Icons.cloud,
            color: Colors.white,
            size: 80); // Fallback icon if condition is unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double textScale = size.width / 375;

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Container(
          decoration: BoxDecoration(gradient: appGradient()),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Location and Refresh Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.white, size: 20 * textScale),
                            const SizedBox(width: 5),
                            Text(
                              weatherData?.location ?? 'Loading...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18 * textScale,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.refresh,
                              color: Colors.white, size: 20 * textScale),
                          onPressed: _fetchWeatherData,
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    // Weather Icon
                    _getWeatherIcon(),
                    SizedBox(height: size.height * 0.01),
                    // Date, Temperature, and Condition
                    
                    SizedBox(height: size.height * 0.02),
                    // Weather Details
                    Container(
                      padding: EdgeInsets.all(16.0 * textScale),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                           "Today "+( weatherData?.date ?? 'Date not available'),
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14 * textScale),
                          ),
                          Text(
                            weatherData != null
                                ? '${weatherData!.temperature}°C'
                                : '...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 60 * textScale,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            weatherData?.condition ?? 'Condition not available',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20 * textScale,
                            ),
                          ),
                          _weatherDetailRow(
                              'Time', weatherData?.time ?? 'N/A', textScale),
                          _weatherDetailRow(
                              'Temperature',
                              '${weatherData?.temperature}°C' ?? 'N/A',
                              textScale),
                          _weatherDetailRow('Max Temperature',
                              '${weatherData?.maxTemp}°C' ?? 'N/A', textScale),
                          _weatherDetailRow('Min Temperature',
                              '${weatherData?.minTemp}°C' ?? 'N/A', textScale),
                          _weatherDetailRow('Condition',
                              weatherData?.condition ?? 'N/A', textScale),
                          _weatherDetailRow(
                              'Wind Speed',
                              '${weatherData?.windSpeed} km/h' ?? 'N/A',
                              textScale),
                          _weatherDetailRow('Humidity',
                              '${weatherData?.humidity}%' ?? 'N/A', textScale),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    // Forecast Button
                    ElevatedButton(
                      onPressed: _fetchWeatherData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.15,
                          vertical: size.height * 0.015,
                        ),
                      ),
                      child: Text(
                        'Forecast report',
                        style: TextStyle(
                            color: Colors.blue, fontSize: 16 * textScale),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create rows for weather details
  Widget _weatherDetailRow(String label, String value, double textScale) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0 * textScale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.air, color: Colors.white, size: 16 * textScale),
              const SizedBox(width: 5),
              Text(
                label,
                style:
                    TextStyle(color: Colors.white70, fontSize: 14 * textScale),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 14 * textScale),
          ),
        ],
      ),
    );
  }
}
