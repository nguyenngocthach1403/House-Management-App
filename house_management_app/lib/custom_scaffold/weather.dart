import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  Weather(
      {super.key,
      required this.weatherIcon,
      required this.weather,
      required this.temperature});
  AssetImage weatherIcon;
  String weather;
  double temperature;

  @override
  State<Weather> createState() => _WeatherState();
}

double toFahrenheit(double celsius) {
  return celsius * 1.8 + 32;
}

double toCelsius(double fahrenheit) {
  return (fahrenheit - 32) * 5 / 9;
}

class _WeatherState extends State<Weather> {
  static final String API_KEY = 'FBKWS65ULGDDQZAN7KKSL2ZMU';
  // static String location = 'Ho Chi Minh';
  String weatherIcon = '';
  int temperature = 0;
  String currentWeatherStatus = '';
  int temperature_f = 0;
  int temperature_c = 0;
  String searchWeatherAPI =
      "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Ho Chi Minh?key=$API_KEY";

  bool iscelsius = true;
  DateTime _currentTime = DateTime.now();

  void fetchWeatherData() async {
    try {
      // var client = http.Client();

      var searchResult = await http.get(Uri.parse(searchWeatherAPI));
      final weatherData =
          Map<String, dynamic>.from(jsonDecode(searchResult.body) ?? 'No data');
      var locationData = weatherData['address'];

      Map<String, dynamic> currentWeather = weatherData['currentConditions'];

      weatherIcon = currentWeather['icon'] + '.png';
      print(currentWeather['icon']);

      currentWeatherStatus = currentWeather['conditions'];

      var temp_f = currentWeather['temp'];

      var temp_c = toCelsius(temp_f);

      temperature_c = temp_c.toInt();

      temperature_f = temp_f.toInt();

      temperature = temperature_c;

      setState(() {
        print(locationData);
      });
    } catch (e) {
      print("not call");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    fetchWeatherData();
    super.initState();
    Timer.periodic(const Duration(minutes: 1), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    if (mounted) {
      setState(() {
        _currentTime = DateTime.now();
        fetchWeatherData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (weatherIcon.isEmpty) {
      weatherIcon = 'clear-day.png';
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3 - 5,
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 45,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/${weatherIcon}'))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    currentWeatherStatus,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3 - 5,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        if (iscelsius) {
                          temperature = temperature_f;
                        } else {
                          temperature = temperature_c;
                        }
                        iscelsius = !iscelsius;
                      });
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 45,
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              temperature.toString(),
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.white),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: Text(
                                "o",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Text(
                              iscelsius ? "C" : "F",
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "Temperature",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3 - 5,
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 45,
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        "${_currentTime.hour}:${_currentTime.minute < 10 ? "0${_currentTime.minute}" : _currentTime.minute}",
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "${_currentTime.day}/${_currentTime.month}/${_currentTime.year}",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
