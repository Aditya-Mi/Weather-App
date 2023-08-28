import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/units.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/widgets/additional_info_item.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/widgets/daily_forecast.dart';
import 'package:weather_app/widgets/hourly_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/widgets/rise_row.dart';
import 'package:weather_app/screens/settings_screen.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;
  late String lat;
  late String long;

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final position = await getCurrentLocation();
      lat = position.latitude.toString();
      long = position.longitude.toString();
      return weather = getWeather();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Position> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied.');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map<String, dynamic>> getWeather() async {
    try {
      final result = await http.get(Uri.parse(
          'https://api.weatherapi.com/v1/forecast.json?key=$weatherApiKey&q=$lat,$long&days=3&aqi=no&alerts=no'));
      final data = jsonDecode(result.body);
      if (result.statusCode != 200) {
        throw 'An unexpected error occurred';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final currentHour = int.parse(DateFormat.H().format(DateTime.now()));
    final units = ref.watch(unitsProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              setState(() {
                weather = getWeather();
              });
            },
            icon: const Icon(Icons.refresh)),
        title: const Text('Weather App'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 28, 16, 46),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (ctx) => const SettingsScreen()))
                    .whenComplete(() => setState(() {}));
              },
              icon: const Icon(Icons.settings_rounded))
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 28, 16, 46),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            final weatherData = WeatherData.fromJson(data);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            weatherData.location,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            units.temperatureUnit == 'Celsius'
                                ? '${weatherData.currentTempInC.round()}°C'
                                : '${weatherData.currentTempInF.round()}°F',
                            style: const TextStyle(
                                fontSize: 52, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 14),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 54, 46, 101),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              weatherData.currentCondition,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        getIcons(data['forecast']['forecastday'][0]['day']
                            ['condition']['code']),
                        size: 100,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdditionalInfoItem(
                          title: '${weatherData.humidity}%',
                          icon: Icons.water_drop_outlined),
                      AdditionalInfoItem(
                          title: units.pressureUnit == 'mBar'
                              ? '${weatherData.currentPressureInBar} mBar'
                              : '${weatherData.currentPressureInIn} in',
                          icon: Icons.arrow_downward),
                      AdditionalInfoItem(
                          title: units.windSpeedUnit == 'km/h'
                              ? '${weatherData.currentWindSpeedInKph} km/h'
                              : '${weatherData.currentWindSpeedInMph} mph',
                          icon: Icons.air),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: [
                      SvgPicture.asset('assets/line/6.svg'),
                      Positioned(
                        top: 25,
                        left: 0,
                        child: RiseRow(
                          image: 'assets/images/sun2.svg',
                          text: data['forecast']['forecastday'][0]['astro']
                              ['sunrise'],
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 0,
                        child: RiseRow(
                          image: 'assets/images/moon1.svg',
                          text: data['forecast']['forecastday'][0]['astro']
                              ['sunset'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Today',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5), fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 24 - currentHour,
                      itemBuilder: (context, index) {
                        final hourlyForecast = data['forecast']['forecastday']
                            [0]['hour'][index + currentHour];
                        final hourlyTime =
                            DateTime.parse(hourlyForecast['time']);
                        return HourlyItem(
                            hour: DateFormat.j().format(hourlyTime),
                            icon: getIcons(hourlyForecast['condition']['code']),
                            temp: units.temperatureUnit == 'Celsius'
                                ? '${hourlyForecast['temp_c'].round()}°C'
                                : '${hourlyForecast['temp_f'].round()}°F');
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: [
                      for (int i = 0;
                          i < data['forecast']['forecastday'].length;
                          i++) ...[
                        DailyForecast(
                          day: data['forecast']['forecastday'][i]['date'],
                          icon: getIcons(data['forecast']['forecastday'][i]
                              ['day']['condition']['code']),
                          maxTemp: units.temperatureUnit == 'Celsius'
                              ? '${data['forecast']['forecastday'][i]['day']['maxtemp_c'].round()}°C'
                              : '${data['forecast']['forecastday'][i]['day']['maxtemp_f'].round()}°F',
                          minTemp: units.temperatureUnit == 'Celsius'
                              ? '${data['forecast']['forecastday'][i]['day']['mintemp_c'].round()}°C'
                              : '${data['forecast']['forecastday'][i]['day']['mintemp_f'].round()}°F',
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(
                child: Text('Weather data not available yet. Try Refresh'));
          }
        },
      ),
    );
  }
}
