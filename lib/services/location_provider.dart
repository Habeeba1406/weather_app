import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/location_service.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  //access for outside
  Position? get currentPostion => _currentPosition;
  //latitude longitude reverse
  final LocationService _locationService = LocationService();

  Placemark? _currentLocationName;
  Placemark? get currentLocationName => _currentLocationName;

//location enabled
  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _currentPosition = null;
      notifyListeners();
      return;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.checkPermission(); //request permission
      if (permission == LocationPermission.denied) {
        _currentPosition = null;
        notifyListeners();
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _currentPosition = null;
      return;
    }

    _currentPosition = await Geolocator.getCurrentPosition();
    print(_currentPosition);
    _currentLocationName =
        await _locationService.getLocationName(_currentPosition);
    print(_currentLocationName);
    notifyListeners();
  }

  //Ask permission

  //get the location
  //get the place
}
