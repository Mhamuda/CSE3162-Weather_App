import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class WeatherInformationMachine {
  Future<Map<String, dynamic>> getDataWithCity(String cityName) async{
    final queryParameter = {

      "key" : "75d78adb3c384c8995f33751222011",
      "q" : cityName,
    };
    final uri = Uri.https("api.weatherapi.com", "/v1/current.json",queryParameter);
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
    "key": "75d78adb3c384c8995f33751222011",
    "q": lon + "," + lat,

    };

    final uri = Uri.https("api.weatherapi.com", "/v1/current.json",queryParameter);
    final response = await get(uri);
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (kDebugMode) {
      print(data);
    }
    return data;
  }
}