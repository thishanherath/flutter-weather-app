import 'package:flutter/material.dart';
import 'package:simple_wheather_app/constants.dart';
import 'package:simple_wheather_app/weather/openwheather.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {

  final openWeatherApi = const OpenWeatherAPI(OPEN_WEATHER_API_KEY);
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  initState() {
    super.initState();
    widget.openWeatherApi.getWeatherDetails(lat: 35.6895, lon: 139.6917);
  }
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
