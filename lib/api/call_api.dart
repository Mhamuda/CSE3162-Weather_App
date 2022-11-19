import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class WeatherInformationMachine {
  Future<Map<String, dynamic>> getDataWithCity(String cityName) async{
    final queryParameter = {
      "q" : cityName,
      "appid" : "54fe4944cbf6baff2c3500adeca99185"
    };
    final uri = Uri.https("api.openweathermap.org", "/data/2.5/weather",queryParameter);
    final response = await get(uri);
    final data = jsonDecode(response.body);
    if (kDebugMode) {
      print(data);
    }
    return data;
  }

  Future<Map<String, dynamic>> getDataWithLonglat(String lon,
      String lat) async {
    if (kDebugMode) {
      print(lon + lat);
    }

    final queryParameter = {
      "lon": lon,
      "lat": lat,
      "appid": "54fe4944cbf6baff2c3500adeca99185"
    };

    final uri = Uri.https(
        "api.openweathermap.org", "/data/2.5/weather", queryParameter);
    final response = await get(uri);
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (kDebugMode) {
      print(data);
    }
    return data;
  }
}