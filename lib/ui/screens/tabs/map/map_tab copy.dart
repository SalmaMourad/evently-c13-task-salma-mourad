


// import 'dart:async';
// import 'package:evently_c13/location/location_mang.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// import '../../../../db/model/event_model.dart';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapTab extends StatefulWidget {
//   const MapTab({super.key, required this.events});
// final List<EventModel> events; // List of events with locations
//   @override
//   State<MapTab> createState() => _MapTabState();
// }

// class _MapTabState extends State<MapTab> {

//   GoogleMapController? _controller;
//   LocationMang locationMang = LocationMang();
//   LatLng? selectedLocation; // Holds the picked location

//   @override
//   void initState() {
//     super.initState();
//     getUserLocation();loadEventMarkers();
//   }

//   getUserLocation() async {
//     bool canGetLocation = await locationMang.isCanHaveLocation();
//     if (!canGetLocation) return;

//     var locationData = await locationMang.getUserLocation();
//     setState(() {
//       userLocaton = CameraPosition(
//         target: LatLng(29.987719, 31.1394304),
//         // target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
//         zoom: 14.4746,
//       );
//     });
//   }
// Set<Marker> eventMarkers = {};

// void loadEventMarkers() {
//   setState(() {
//     eventMarkers = widget.events.map((event) {
//       return Marker(
//         markerId: MarkerId(event.id??""), // Unique ID for each marker
//         position: LatLng(event.geoPoint?.latitude??0, event.geoPoint?.longitude??0),
//         infoWindow: InfoWindow(title: event.title),
//       );
//     }).toSet();
//   });
// }

//   static CameraPosition userLocaton = CameraPosition(
//     target: LatLng(29.987719,31.1394304),
//     zoom: 14.4746,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(title: Text("Pick Location")),
//       body: GoogleMap(
//   mapType: MapType.normal,
//   initialCameraPosition: userLocaton,
//   onMapCreated: (GoogleMapController controller) {
//     _controller = controller;
//   },
//   markers: {
//     ...eventMarkers, // Show all event markers
//     if (selectedLocation != null)
//       Marker(
//         markerId: MarkerId("selected"),
//         position: selectedLocation!,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // Different color for picked location
//       ),
//   },
//   onTap: (LatLng latLng) {
//     setState(() {
//       selectedLocation = latLng;
//     });
//   },
// ),

     
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (selectedLocation != null) {
//             Navigator.pop(context, selectedLocation);
//           }
//         },
//         child: Icon(Icons.check),
//       ),
//     );
//   }
// }



//  // body: GoogleMap(
//       //   mapType: MapType.normal,
//       //   initialCameraPosition: userLocaton,
//       //   onMapCreated: (GoogleMapController controller) {
//       //     _controller = controller;
//       //   },
//       //   markers: selectedLocation != null
//       //       ? {
//       //           Marker(
//       //             markerId: MarkerId("selected"),
//       //             position: selectedLocation!,
//       //           ),
//       //         }
//       //       : {},
//       //   onTap: (LatLng latLng) {
//       //     setState(() {
//       //       selectedLocation = latLng;
//       //     });
//       //   },
//       // ),



// // // import 'package:evently_c13/db/model/event_model.dart';
// // // import 'package:evently_c13/location/location_mang.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // // class MapTab extends StatefulWidget {
// // //   final List<EventModel> events; // List of events passed in

// // //   const MapTab({Key? key, required this.events}) : super(key: key);

// // //   @override
// // //   State<MapTab> createState() => _MapTabState();
// // // }

// // // class _MapTabState extends State<MapTab> {
// // //   GoogleMapController? _controller;
// // //   LocationMang locationMang = LocationMang();

// // //   // Default initial camera position
// // //   CameraPosition cameraPosition = const CameraPosition(
// // //     target: LatLng(29.987719, 31.1394304),
// // //     zoom: 14.4746,
// // //   );

// // //   // Marker set for both user and event markers
// // //   Set<Marker> markers = {};

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     // First, add event markers from the passed events list
// // //     addEventMarkers();
// // //     // Then, get the user's location and add/update marker
// // //     getUserLocation();
// // //   }

// // //   /// Creates markers for each event that has a valid geoPoint
// // //   void addEventMarkers() {
// // //     for (var event in widget.events) {
// // //       if (event.geoPoint != null) {
// // //         markers.add(
// // //           Marker(
// // //             markerId: MarkerId(event.id ?? event.title!),
// // //             position: LatLng(
// // //               event.geoPoint!.latitude,
// // //               event.geoPoint!.longitude,
// // //             ),
// // //             infoWindow: InfoWindow(
// // //               title: event.title,
// // //               snippet: event.description,
// // //             ),
// // //           ),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   /// Fetches the user location, updates the map camera and adds a user marker
// // //   void getUserLocation() async {
// // //     bool canGetLocation = await locationMang.isCanHaveLocation();
// // //     if (!canGetLocation) {
// // //       return;
// // //     }
// // //     var locationData = await locationMang.getUserLocation();
// // //     LatLng userLatLng = LatLng(
// // //       locationData.latitude ?? 0,
// // //       locationData.longitude ?? 0,
// // //     );

// // //     // Update or add the user location marker (using a different hue for differentiation)
// // //     markers.add(
// // //       Marker(
// // //         markerId: const MarkerId('user'),
// // //         position: userLatLng,
// // //         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
// // //       ),
// // //     );

// // //     // Update the camera position to the user's location
// // //     cameraPosition = CameraPosition(target: userLatLng, zoom: 14.4746);

// // //     // Refresh the UI
// // //     setState(() {});

// // //     // Animate camera if the map controller is already initialized
// // //     _controller?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: GoogleMap(
// // //         markers: markers,
// // //         mapType: MapType.normal,
// // //         initialCameraPosition: cameraPosition,
// // //         onMapCreated: (GoogleMapController controller) {
// // //           _controller = controller;
// // //           // Optional: Refresh the location when the map is created
// // //           getUserLocation();
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }

// // // // import 'package:evently_c13/location/location_mang.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // // // class MapTab extends StatefulWidget {
// // // //   const MapTab({super.key});

// // // //   @override
// // // //   State<MapTab> createState() => _MapTabState();
// // // // }

// // // // class _MapTabState extends State<MapTab> {
// // // //   GoogleMapController? _controller;
// // // //   LocationMang locationMang = LocationMang();

// // // //   static CameraPosition userLocaton = CameraPosition(
// // // //     target: LatLng(29.987719, 31.1394304),
// // // //     zoom: 14.4746,
// // // //   );

// // // //   static const String userLocationId = 'user';
// // // //   Set<Marker> markers = {};

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     getUserLocation();
// // // //   }

// // // //   getUserLocation() async {
// // // //     bool canGetLocation = await locationMang.isCanHaveLocation();
// // // //     if (!canGetLocation) {
// // // //       return;
// // // //     }

// // // //     var locationData = await locationMang.getUserLocation();
// // // //     LatLng newPosition =
// // // //         LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0);

// // // //     setState(() {
// // // //       userLocaton = CameraPosition(target: newPosition, zoom: 14.4746);
// // // //       markers = {
// // // //         Marker(
// // // //           markerId: const MarkerId(userLocationId),
// // // //           position: newPosition,
// // // //         ),
// // // //       };
// // // //     });

// // // //     _controller?.animateCamera(CameraUpdate.newCameraPosition(userLocaton));
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       body: GoogleMap(
// // // //         markers: markers,
// // // //         mapType: MapType.normal,
// // // //         initialCameraPosition: userLocaton,
// // // //         onMapCreated: (GoogleMapController controller) {
// // // //           _controller = controller;
// // // //           getUserLocation(); // Fetch location again once map is created
// // // //         },
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // // import 'package:evently_c13/location/location_mang.dart';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // // // // class MapTab extends StatefulWidget {
// // // // //   const MapTab({super.key});

// // // // //   @override
// // // // //   State<MapTab> createState() => _MapTabState();
// // // // // }

// // // // // class _MapTabState extends State<MapTab> {
// // // // //   GoogleMapController? _controller;

// // // // //   LocationMang locationMang = LocationMang();

// // // // //   @override
// // // // //   void initState() {
// // // // //     // TODO: implement initState
// // // // //     super.initState();
// // // // //     getUserLocation();
// // // // //   }

// // // // //   getUserLocation() async {
// // // // //     bool canGetLocation = await locationMang.isCanHaveLocation();
// // // // //     if (!canGetLocation) {
// // // // //       return;
// // // // //     }
// // // // //     var locationData = await locationMang.getUserLocation();
// // // // //     userLocaton = CameraPosition(
// // // // //       target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
// // // // //       zoom: 14.4746,
// // // // //     );
// // // // //     ;
// // // // //   }

// // // // //   static CameraPosition userLocaton = CameraPosition(
// // // // //     target: LatLng(29.987719, 31.1394304),
// // // // //     zoom: 14.4746,
// // // // //   );

// // // // //   static const String userLocationId = 'user';
// // // // //   Set<Marker> markers = {
// // // // //     Marker(
// // // // //       markerId: const MarkerId(userLocationId),
// // // // //       position:
// // // // //           LatLng(userLocaton.target.latitude, userLocaton.target.longitude),
// // // // //     ),
// // // // //   };
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       body: GoogleMap(
// // // // //         markers: markers,
// // // // //         mapType: MapType.normal,
// // // // //         initialCameraPosition: userLocaton,
// // // // //         onMapCreated: (GoogleMapController controller) {
// // // // //           _controller = controller;
// // // // //         },
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
