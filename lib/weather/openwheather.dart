import 'package:http/http.dart' as http;

class OpenWeatherAPI {
  final String apiKey;
  const OpenWeatherAPI(this.apiKey);

  void getWeatherDetails({required double lat, required double lon}) {
    print('Getting weather details');

    var url =
    "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    var response = http.get(Uri.parse(url));
    response.then((value) => print("Weather details recieved ${value.body}"));
    print("Running getWeatherDetails $response");
  }
}
