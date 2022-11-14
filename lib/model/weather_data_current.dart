import 'dart:math';

import 'package:weatherapp_starter_project/model/weather/weather.dart';

class WeatherDataCurrent{
  final Current current;
  WeatherDataCurrent({
    required this.current
  });

  factory WeatherDataCurrent.fromJson(Map<String,dynamic> json)=>
    WeatherDataCurrent(current: Current.fromJson(json['current']));
  
}

class Current{
  // bunu bu şekilde yapmamızın sebebi json dosyasından hangi tür verilerin geleceğini bilmiyoruz
  double? temp;
  int? humudity;
  int? clouds;
  double? windSpeed;
  List<Weather>? weather;

  Current({
    this.temp,
    this.humudity,
    this.clouds,
    this.windSpeed,
    this.weather,
  });

  factory Current.fromJson(Map<String,dynamic> json) => Current(
    temp: json['temp'] as double,
    humudity: json['humudity'] as int,
    clouds: json['clouds'] as int,
    windSpeed: json['windSpeed'] as double,
    weather: (json['weather'] as List<dynamic>)
            .map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String,dynamic> toJson() => {
    'temp' : temp,
    'humudity' : humudity,
    'clouds' : clouds,
    'windSpeed' : windSpeed,
    'weather' : weather?.map((e) => e.toJson()).toList(),
  };

}

class Weather{
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({
      this.id,
      this.main,
      this.description,
      this.icon,
  });

  factory Weather.fromJson( Map<String, dynamic> json) => Weather(
    id: json['id'] as int,
    main: json['main'] as String,
    description: json['description'] as String,
    icon: json['icon'] as String,      
  );

  Map<String, dynamic> toJson() => {
    'id' : id,
    'main' : main,
    'description' : description,
    'icon' : icon,
  };
}