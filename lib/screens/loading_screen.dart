import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../models/location.dart';
import '../services/location_service.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> getLocation() async {
    LocationService location = LocationService();
    Location locations = await location.getCurrentLocation();

    log("Altitude: ${locations.latitude} - Longitude: ${locations.longitude}");
  }

  Future<void> getWeatherData() async {
    var url = Uri.parse(
        "https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = response.body;
      log(data);
    } else {
      log(response.statusCode.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // obtém a localização atual
            getLocation();
          },
          child: const Text('Obter Localização'),
        ),
      ),
    );
  }
}
