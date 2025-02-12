import 'package:evently/core/manager/location_manager.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _EventMapState();
}

class _EventMapState extends State<MapView> {


  var initialCameraPosition=const CameraPosition
    (target: LatLng(30.12, 35.2)
  );
  late GoogleMapController _controller;
  Marker currentLocationMarker = const Marker(
    markerId: MarkerId("1"),
    position:LatLng(30.12, 35.2)
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         var location= await LocationManager.getCurrentLocation();
         _listenOnLocationChanged();
         // initialCameraPosition=CameraPosition
         //   (
         //     zoom: 12,
         //     target: LatLng(location.latitude, location.longitude)
         // );
         currentLocationMarker= Marker(
           markerId: const MarkerId("1"),
           position: LatLng(location.latitude, location.longitude),
         );
         _controller.animateCamera(
           CameraUpdate.newLatLngZoom(
             LatLng(location.latitude, location.longitude),
             14
           ),
         );
         setState(() {

         });
        },
        child: const Icon(
            Icons.location_searching_rounded
        ),
      ),
      body:  GoogleMap(
        myLocationButtonEnabled: false,
          myLocationEnabled: false,
          zoomControlsEnabled: false,
          key: UniqueKey(),
          markers: {
          currentLocationMarker,
          },
          onMapCreated: (controller){
            _controller = controller;
          },
          initialCameraPosition:initialCameraPosition

      ),
    );
  }
  _listenOnLocationChanged(){
    var stream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        timeLimit: Duration(seconds: 1)
      ),

    );
    stream.listen(
            (Position newLocation) {
              var newLatLng = LatLng(newLocation.latitude, newLocation.longitude);
              _controller.animateCamera(
                CameraUpdate.newLatLngZoom(
                  newLatLng,
                  14,
                ),

              );
              currentLocationMarker = Marker(
                markerId: const MarkerId("1"),
                position: newLatLng
              );
              setState(() {

              });
            }
    );
  }
}
