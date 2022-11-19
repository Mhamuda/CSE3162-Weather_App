import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import '../api/call_api.dart';

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
  var humidity = "Humidity";  //Adrota
  var pressure = "Pressure";
  // var sunrise = "sunrise";
  // var sunset = "sunset";
  var icon = "04d";
  var main = "Type";
  var description = "Description";
  var visibility = "Visibility";
  var longitude = "Longitude";  //draghimangso
  var latitude = "Latitude";  //Okkhangso

  TextEditingController textEditingController = TextEditingController();

  void getWeather() async {
    var machine = WeatherInformationMachine();

    Map<String, dynamic> response =
        await machine.getDataWithCity(textEditingController.text);
    if (response["cod"] == 200) {
      double tempDegree = response['main']['temp'] - 273;
      double tempFarenheit = tempDegree * 9 / 5 + 32;
      double feelsLikeDegree = response['main']['feels_like'] - 273;
      double feelsLikeFarenheit = feelsLikeDegree * 9 / 5 + 32;
      double visibility1 = response['visibility'] / 1000;


      setState(() {
        location = 'City Name: ' + response["name"] + "," + response["sys"]["country"];
        tempData = 'Temperature : ' + tempDegree.toStringAsPrecision(2) + degree + " / " + tempFarenheit.toStringAsPrecision(2) + fahrenheit;
        feelsLike = 'Feels Like : ' + feelsLikeDegree.toStringAsPrecision(2) + degree + " / " + feelsLikeFarenheit.toStringAsPrecision(2) + fahrenheit;
        humidity = 'Humidity : ' + response['main']['humidity'].toString() + '%';
        pressure = 'Pressure : ' + response['main']['pressure'].toString() + 'mBar';
        icon = response['weather'][0]['icon'];
        main = response['weather'][0]['main'];
        description = response['weather'][0]['description'];
        visibility = 'Visibility : ' + visibility1.toStringAsPrecision(2) + 'km';
        // sunrise = 'Sunrise : ' + response['sys']['sunrise'];
        // sunset = 'Sunset : ' +response['sys']['sunset'];
        latitude = 'Latitude : ' + response['coord']['lat'].toStringAsFixed(4);
        longitude = 'Longitude : ' + response['coord']['lon'].toStringAsFixed(4);


      });
    } else {
      Fluttertoast.showToast(
          msg: response["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void loadData() async {
    var serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (kDebugMode) { //kDebugmode = A constant that is true if the application was compiled in debug mode.
      print(serviceStatus);
    }

    LocationPermission locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.denied) {
        if (kDebugMode) {
          print("permission denied");
        }
      } else if (locationPermission == LocationPermission.deniedForever) {
        if (kDebugMode) {
          print("forget it. it's reject forever.");
        }
      } else {
        if (kDebugMode) {
          print("permission given");
        }
      }
    } else {
      if (kDebugMode) {
        print("Permission Hold");
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    longitude = position.longitude.toStringAsFixed(4);
    latitude = position.latitude.toStringAsFixed(4);

    var machine = WeatherInformationMachine();
    var response = await machine.getDataWithLonglat(longitude, latitude);

    if (response["cod"] == 200) {
      double tempDegree = response['main']['temp'] - 273;
      double tempFarenheit = tempDegree * 9 / 5 + 32;
      double feelsLikeDegree = response['main']['feels_like'] - 273;
      double feelsLikeFarenheit = feelsLikeDegree * 9 / 5 + 32;
      double visibility1 = response['visibility'] / 1000;

      setState(() {
        tempData ='Temperature : ' + tempDegree.toStringAsPrecision(2) + degree + " / " + tempFarenheit.toStringAsPrecision(2) + fahrenheit;
        location ='Currrently in ' + response["name"];
        feelsLike = 'Feels Like : ' + feelsLikeDegree.toStringAsPrecision(2) + degree + " / " + feelsLikeFarenheit.toStringAsPrecision(2) + fahrenheit;
        humidity = 'Humidity : ' + response['main']['humidity'].toString() + '%';
        pressure = 'Pressure : ' + response['main']['pressure'].toString() + 'mBar';
        icon = response['weather'][0]['icon'];
        main = response['weather'][0]['main'];
        description = response['weather'][0]['description'];
        visibility = 'Visibility : ' + visibility1.toStringAsPrecision(2) + 'km';
        // sunrise = 'Sunrise : ' + response['sys']['sunrise'];
        // sunset = 'Sunset : ' +response['sys']['sunset'];
        latitude = 'Latitude : ' + response['coord']['lat'].toString();
        longitude = 'Longitude : ' + response['coord']['lon'].toString();
      });
    } else {
      Fluttertoast.showToast(
          msg: response["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black12,
          textColor: Colors.white,
          fontSize: 16.0);
    }
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
    // Container(
    //   height: double.infinity,
    //   width: double.infinity,
    //   decoration: const BoxDecoration(
    //     image: DecorationImage(
    //       image: AssetImage("sa=i&url=https%3A%2F%2Fwww.pinterest.com%2Fpin%2F343469909079571629%2F&psig=AOvVaw0Pms6iDbZOPSKnNveM9478&ust=1668981370852000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCMCJx5-eu_sCFQAAAAAdAAAAABAO"),
    //       fit: BoxFit.cover,
    //     ),
    // ));
    // var dt=DateFormat("dd MMMM , yy       hh-mm a").format(DateTime.now());
     return Container(
        
        alignment: Alignment.topCenter,
        color: Colors.tealAccent,


         child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),

            // Text(formatted(dt),style: TextStyle(fontSize: 20,),),
            SizedBox(
              height: 20,
            ),

            Text(location,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal)),

            Text(
              tempData.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                fontSize: 30,
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
            // new Image.network('https://openweathermap.org/img/wn/$icon.png',
            //     height: 100,
            //     width: 10,
            //     fit: BoxFit.fitWidth,
            //     //scale: 1,
            //     // color: Color.fromARGB(255, 15, 147, 59),
            //     opacity: const AlwaysStoppedAnimation<double>(0.5)),
            Image.network(
                'https://openweathermap.org/img/wn/${icon}@2x.png'),
            // SizedBox(
            //   height: 10,
            // ),
            Text(
              main,
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
              description,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 5,
            ),
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
                child: const Text("Current Location",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
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

