import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather {
  int status;
  String city;
  String desc;
  double temp;
  int humidity;
  double minTemp;
  double maxTemp;

  Weather({this.status, this.city, this.desc, this.temp, this.humidity, this.minTemp, this.maxTemp});

  factory Weather.fromJSON(Map json) {

    return Weather(
      status: json['cod'],
      city: json['name'],
      desc: json['weather'][0]['description'],
      temp: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'],
      minTemp: json['main']['temp_min'].toDouble(),
      maxTemp: json['main']['temp_max'].toDouble()
    );
  }

  factory Weather.fromErrorJSON(Map json) {
    return Weather(status: json['cod']);
  }
}

Future<dynamic> fetchWeather({String city}) async {
  String weatherCity = city.replaceAll(RegExp(r"\s+\b|\b\s"), "+");
  http.Response response = await http.get("http://api.openweathermap.org/data/2.5/weather?q=$weatherCity&appid=80695573cee51cabb62a364ee5fa1d87&units=metric");

  if(response.statusCode == 200) {
    Map mapWeather = json.decode(response.body);
    return Weather.fromJSON(mapWeather);
  }
  else if(response.statusCode == 404)
    return Weather.fromErrorJSON({'cod': 404});
  else {
    throw Exception('Something went wrong');
  }
}