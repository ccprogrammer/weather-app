import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  String apiId = 'd69084504d6a5b7eb2c433dd2d308a1a';
  Future<WeatherModel> fetchWeather(String city) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiId');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      WeatherModel weatherInfo = WeatherModel.fromJson(result);

      return weatherInfo;
    } else {
      throw 'Error';
    }
  }
}
