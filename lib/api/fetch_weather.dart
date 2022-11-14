import 'dart:convert';

import 'package:weatherapp_starter_project/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp_starter_project/model/weather_data_current.dart';
import 'api_key.dart';

class FetchWeatherAPI{
  WeatherData? weatherData;

  // datayı burada işleteceğiz
  Future<WeatherData> processData(lat, lon) async{
    var response = await http.get(Uri.parse(apiUrl(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(WeatherDataCurrent.fromJson(jsonString));
    return  weatherData!;
  }

  String apiUrl(lat, lon){
    String url;
    url = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey";
    return url;

  }
}