import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationManager{

  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;


    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
    var result= await Geolocator.openLocationSettings();
      //var status = await Permission.locationWhenInUse.request();
      return Future.error('Location services are disabled.');
    }



    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var location= await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);

    if(placemarks.isNotEmpty){
      print("Street: ${placemarks[0].street}");
    }
    print(location.toString());
    return location;
  }

}