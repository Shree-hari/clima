import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String apiKey = '6e30ea19180322e52a03bd28c6bcb3c6';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double longitude ,latitude;

  void getLocation() async {

    Location location = Location();
    await location.getCurrentLocation();
    longitude = location.longitude;
    latitude = location.latitude;

    getData();
  }

  void getData() async {
    http.Response response = await http.get('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    if (response.statusCode == 200){
      String data = response.body;
      var decodedData = jsonDecode(data);
      int condition = decodedData['weather'][0]['id'];
      String cityData = decodedData['name'];
      double temprature = decodedData['main']['temp'];
      print(condition);
      print(cityData);
      print(temprature);
    }
    else {
      print(response.statusCode);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Get the current location
            getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
