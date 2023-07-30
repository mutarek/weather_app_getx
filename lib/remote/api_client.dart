import 'dart:convert';
import 'package:http/http.dart' as https;
import '../config/strings.dart';
import '../models/CurrentWeatherData.dart';
import '../models/HourlyWeatherData.dart';

class ApiClient {
  static var client = https.Client();

  getCurrentWeather(lat, long) async {
    var link = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric";
    var res = await https.get(Uri.parse(link));
    if (res.statusCode == 200) {
      var data = currentWeatherDataFromJson(res.body.toString());
      return data;
    }
  }

  getHourlyWeather(lat, long) async {
    var link = "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$apiKey&units=metric";
    var res = await https.get(Uri.parse(link));
    if (res.statusCode == 200) {
      var data = hourlyWeatherDataFromJson(res.body.toString());
      return data;
    }
  }
}
