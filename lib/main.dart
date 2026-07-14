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
    var res =widget.openWeatherApi.getWeatherDetails(lat: 6.9271, lon: 79.8612);
    res.then((value) => print("Initial weather data: $value"));

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: widget.openWeatherApi.getWeatherDetails(lat: 6.9271, lon: 79.8612),
            builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                  return const CircularProgressIndicator();
                else if(snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                
                var data = snapshot.data;

                return Text(data! ["weather"][0]["main"].toString());

              
            },
          ),
        ),
      ),
    );
  }
}
