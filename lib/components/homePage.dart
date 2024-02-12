import 'dart:convert';
import 'package:app3/components/searchForm.dart';
import 'package:app3/components/weatherCard.dart';
import 'package:app3/helpers/helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? _position;
  String _city = "";
  int _temp = 0;
  String _icon = "04n";
  String _desc = "";
  WeatherFetch _weatherFetch = new WeatherFetch();

  @override
  void initState() {
    super.initState();

    _getCurrent();
  }

  /* Render data */
  void updateData(weatherData) {
    setState(() {
      if (weatherData != null) {
        debugPrint(jsonEncode(weatherData));
        //{"temp":10.49,"feels_like":5.54,"temp_min":10,"temp_max":11,"pressure":1009,"humidity":61}
        _temp = weatherData['main']['temp'].toInt();
        _icon = weatherData['weather'][0]['icon'];
        _desc = weatherData['main']['feels_like'].toString();
//        _color = _getBackgroudColor(_temp);
      } else {
        _temp = 0;
        _city = "In the middle of nowhere";
        _icon = "04n";
      }
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Center(child: Column(children: [
        Search(parentCallback: _changeCity),
        Text(
          _city, 
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
        ),
        WeatherCard(title: _desc, temperature: _temp, iconCode: _icon)
      ])))
    );
  }

  _getCurrent() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } 

    _position = await Geolocator.getCurrentPosition();

    _getCityAndWeather();
  }

  _getCityAndWeather() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
      _position!.latitude, 
      _position!.longitude
    );

    var data = await _weatherFetch.getWeatherByCoord(
      _position!.latitude, 
      _position!.longitude
    );
    updateData(data);

    setState(() {
      _city = p[0].locality!;
    });
    } catch (e) {
      print(e);
    }
  }

  _changeCity(city) async {
    try {
      var data = await _weatherFetch.getWeatherByName(city);
      updateData(data);
      
      setState(() {
        _city = city;
      });
    } catch (e) {
      print(e);
    }
  }
}