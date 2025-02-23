import 'dart:async';

import 'package:evently_c13/location/location_mang.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();
      GoogleMapController ?_controller;

  LocationMang locationMang = LocationMang();
// LocationData? userLocationDataa=lo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
    // locationMang.isCanHaveLocation();
    // if(await locationMang.isCanHaveLocation())
    // {
    // // userLocationDataa= await locationMang.getLocation();

    // }
//   }
//    getUserLocation()async{
//     final userLocationDataa= await locationMang.getLocation();
// return userLocationDataa;
  }

  getUserLocation() async {
    bool canGetLocation = await locationMang.isCanHaveLocation();
    if (!canGetLocation) {
      return;
    }
    var locationData = await locationMang.getUserLocation();
    userLocaton = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 14.4746,
    );
    ;
  }

  static CameraPosition userLocaton = CameraPosition(
    target: LatLng(29.987719, 31.1394304),
    zoom: 14.4746,
  );

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
      // zoom: 19.151926040649414);
static const String userLocationId='user';
Set<Marker> markers = {
  Marker(
    markerId: const MarkerId(userLocationId),
    position: LatLng(userLocaton.target.latitude, userLocaton.target.longitude),
  ),
};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: markers,
        mapType: MapType.normal,
        initialCameraPosition: userLocaton,
        onMapCreated: (GoogleMapController controller) {
          _controller=controller;
        },
      ),
      
    );
  }


}
