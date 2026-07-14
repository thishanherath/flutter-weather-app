import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:simple_wheather_app/constants.dart';
import 'package:simple_wheather_app/weather/openwheather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final openWeatherApi = const OpenWeatherAPI(OPEN_WEATHER_API_KEY);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: openWeatherApi.getWeatherDetails(lat: 6.9271, lon: 79.8612),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');

              var data = snapshot.data;

              return Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    openWeatherApi.getWeatherIcon(
                      data!['weather'][0]['icon'],
                    ),
                    height: 150,
                    width: 150,
                  ),
                  Text(
                    data['weather'][0]['description'].toString().toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data['main']['temp']}",
                        style: GoogleFonts.poppins(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      const Text(
                        "°C",
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                  Text(
                    data['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(MdiIcons.waterPercent, size: 35),
                            const SizedBox(height: 5),
                            Text("${data['main']['humidity']}%"),
                            const Text("Humidity"),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(MdiIcons.weatherWindy, size: 35),
                            const SizedBox(height: 5),
                            Text("${data['wind']['speed']} m/s"),
                            const Text("Wind"),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(MdiIcons.gauge, size: 35),
                            const SizedBox(height: 5),
                            Text("${data['main']['pressure']}"),
                            const Text("Pressure"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(MdiIcons.thermometer, size: 35),
                            const SizedBox(height: 5),
                            Text("${data['main']['feels_like']}°C"),
                            const Text("Feels Like"),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(MdiIcons.weatherCloudy, size: 35),
                            const SizedBox(height: 5),
                            Text("${data['clouds']['all']}%"),
                            const Text("Clouds"),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(MdiIcons.eyeOutline, size: 35),
                            const SizedBox(height: 5),
                            Text("${data['visibility'] / 1000} km"),
                            const Text("Visibility"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
