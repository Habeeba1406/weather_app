import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weathermodel.dart';
import 'package:weather_app/secrets/api.dart';

class WeatherProvider extends ChangeNotifier {
  //method for fetching weather

  WeatherModel? _weather;
  WeatherModel? get Weather => _weather;

  //error
  bool _isloading = false;
  bool get isloading => _isloading;

  String _error = "";
  String get error => _error;

  Future<void> fetchWeatherData(String city) async {
    _isloading = true;
    _error = "";

    try {
      final String apiUrl =
          "${ApiEndPoints().cityurl}${city}&appid =${ApiEndPoints().apikey}${ApiEndPoints().unit}";
      print(apiUrl);

      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        _weather = WeatherModel.fromJson(data);

        notifyListeners();
      } else {
        _error = 'Failed to load data';
      }
    } catch (e) {
      _error = 'Failed to load data $e';
    } finally {
      _isloading = false;
      notifyListeners();
    }
    // try {
    //   // Make API call
    //   final response = await http.get(Uri.parse(
    //       'https://api.openweathermap.org/data/2.5/weather?q=dubai&appid=dd708744bb92df926a5be64713be27c4&units=metric'));

    //   if (response.statusCode == 200) {
    //     // Parse the JSON and update the provider's state
    //   } else {
    //     throw Exception('Failed to load weather data');
    //   }
    // } catch (error) {
    //   // Handle errors properly
    //   print('Error fetching weather data: $error');
    // } finally {
    //   _isloading = false;
    //   notifyListeners();
    // }
  }
}
