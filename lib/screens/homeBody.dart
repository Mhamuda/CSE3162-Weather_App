import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import '../api/call_api.dart';
import 'package:weather/weather.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  var degree = "\u00B0" "C";
  var fahrenheit = "\u00B0" "F";
  var feelsLike = "Feels Like";
  var tempData = "Loading...";
  var location = "Current Location";
  var search = "Search";
  var humidity = "Humidity"; //Adrota
  var pressure = "Pressure";
  // var sunrise = "sunrise";
  // var sunset = "sunset";
  var icon = "//cdn.weatherapi.com/weather/64x64/night/296.png";
  var text = "type";
  var description = "Description";
  var visibility = "Visibility";
  var longitude = "Longitude"; //draghimangso
  var latitude = "Latitude"; //Okkhangso

  TextEditingController textEditingController = TextEditingController();

  void getWeather() async {
    var machine = WeatherInformationMachine();

    Map<String, dynamic> response =
        await machine.getDataWithCity(textEditingController.text);

    setState(() {
      location = 'City Name: ' +
          response['location']['name'] +
          "," +
          response['location']['country'];
      tempData =
          'Temperature : ' + response['current']['temp_c'].toString() + degree;
      feelsLike = 'Feels Like : ' +
          response['current']["feelslike_c"].toString() +
          degree;
      humidity =
          'Humidity : ' + response['current']['humidity'].toString() + '%';
      pressure = 'Pressure : ' +
          response['current']['pressure_mb'].toString() +
          'mBar';
      icon = response['current']['condition']['icon'];
      text = response['current']['condition']['text'];
      visibility =
          'Visibility : ' + response['current']['vis_km'].toString() + 'km';
      // sunrise = 'Sunrise : ' + response['sys']['sunrise'];
      // sunset = 'Sunset : ' +response['sys']['sunset'];
      latitude = 'Latitude : ' + response['location']['lat'].toStringAsFixed(4);
      longitude =
          'Longitude : ' + response['location']['lon'].toStringAsFixed(4);
    });
  }

  void loadData() async {
    var serviceStatus = await Geolocator.isLocationServiceEnabled();
    // if (kDebugMode) { //kDebugmode = A constant that is true if the application was compiled in debug mode.
    //   print(serviceStatus);
    // }
    //
    // LocationPermission locationPermission = await Geolocator.checkPermission();
    //
    // if (locationPermission == LocationPermission.denied) {
    //   locationPermission = await Geolocator.requestPermission();
    //
    //   if (locationPermission == LocationPermission.denied) {
    //     if (kDebugMode) {
    //       print("permission denied");
    //     }
    //   } else if (locationPermission == LocationPermission.deniedForever) {
    //     if (kDebugMode) {
    //       print("forget it. it's reject forever.");
    //     }
    //   } else {
    //     if (kDebugMode) {
    //       print("permission given");
    //     }
    //   }
    // } else {
    //   if (kDebugMode) {
    //     print("Permission Hold");
    //   }
    // }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    longitude = position.longitude.toStringAsFixed(4);
    latitude = position.latitude.toStringAsFixed(4);

    var machine = WeatherInformationMachine();
    var response = await machine.getDataWithLonglat(longitude, latitude);

    setState(() {
      location = 'Currrently in ' +
          response['location']['name'] +
          "," +
          response['location']['country'];
      tempData =
          'Temperature : ' + response['current']['temp_c'].toString() + degree;
      feelsLike = 'Feels Like : ' +
          response['current']["feelslike_c"].toString() +
          degree;
      humidity =
          'Humidity : ' + response['current']['humidity'].toString() + '%';
      pressure = 'Pressure : ' +
          response['current']['pressure_mb'].toString() +
          'mBar';
      icon = response['current']['condition']['icon'];
      text = response['current']['condition']['text'];
      visibility =
          'Visibility : ' + response['current']['vis_km'].toString() + 'km';
      // sunrise = 'Sunrise : ' + response['sys']['sunrise'];
      // sunset = 'Sunset : ' +response['sys']['sunset'];
      latitude = 'Latitude : ' + response['location']['lat'].toStringAsFixed(4);
      longitude =
          'Longitude : ' + response['location']['lon'].toStringAsFixed(4);

    });
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.black,
    backgroundColor: Colors.pinkAccent,
    minimumSize: Size(100, 50),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  final ButtonStyle ancentFlatbuttonStyle = TextButton.styleFrom(
    primary: Colors.black,
    backgroundColor: Colors.deepOrangeAccent,
    minimumSize: Size(200, 50),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        color: Colors.tealAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),

            Text(location,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal)),
            SizedBox(
              height: 5,
            ),
            Text(
              "Today's Weather Information",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),

            Text(
              tempData.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              feelsLike.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 7,
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    latitude,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    longitude,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 15,
            ),

            Text(
              humidity,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                fontSize: 20,
              ),
            ),

            SizedBox(
              height: 5,
            ),

            Text(
              pressure,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              visibility,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Image.network("https:" + icon),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Text(
            //   description,
            //   style: const TextStyle(
            //     fontWeight: FontWeight.w900,
            //     fontStyle: FontStyle.normal,
            //     fontSize: 20,
            //   ),
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.amberAccent,
                width: 200,
                child: TextField(
                  controller: textEditingController,
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                    hintText: "Enter the city name",
                    labelStyle: TextStyle(color: Colors.black12),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: flatButtonStyle,
                onPressed: getWeather,
                child: Text(
                  search,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ancentFlatbuttonStyle,
                onPressed: loadData,
                child: const Text(
                  "Current Location",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),

          ],
        ));
  }
}

// String formatted(timeStamp) {
//   final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(
//       timeStamp * 1000);
//   return date1.toString();
// }
