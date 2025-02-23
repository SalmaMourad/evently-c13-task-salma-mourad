import 'package:evently_c13/location/location_mang.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../db/model/event_model.dart';

class MapTab extends StatefulWidget {
  MapTab({super.key, required this.events, required this.isbutton});
  final List<EventModel> events;
  bool isbutton = false;
  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  GoogleMapController? _controller;
  LocationMang locationMang = LocationMang();
  LatLng? selectedLocation;
  int? _selectedEventIndex;

  Set<Marker> eventMarkers = {};

  @override
  void initState() {
    super.initState();
    getUserLocation();
    loadEventMarkers();
  }

  getUserLocation() async {
    bool canGetLocation = await locationMang.isCanHaveLocation();
    if (!canGetLocation) return;

    var locationData = await locationMang.getUserLocation();
    setState(() {
      userLocaton = CameraPosition(
        target: LatLng(29.987719, 31.1394304),
        zoom: 14.4746,
      );
    });
  }

  void loadEventMarkers() {
    setState(() {
      eventMarkers = widget.events.asMap().entries.map((entry) {
        int index = entry.key;
        EventModel event = entry.value;

        return Marker(
          markerId: MarkerId(event.id ?? ""),
          position: LatLng(
              event.geoPoint?.latitude ?? 0, event.geoPoint?.longitude ?? 0),
          infoWindow: InfoWindow(title: event.title),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            _selectedEventIndex == index
                ? BitmapDescriptor.hueBlue
                : BitmapDescriptor.hueRed,
          ),
          onTap: () => _onEventSelected(index),
        );
      }).toSet();
    });
  }

  void _onEventSelected(int index) {
    setState(() {
      _selectedEventIndex = index;
      selectedLocation = LatLng(
        widget.events[index].geoPoint?.latitude ?? 0,
        widget.events[index].geoPoint?.longitude ?? 0,
      );
    });

    _controller?.animateCamera(CameraUpdate.newLatLng(selectedLocation!));

    loadEventMarkers();
  }

  static CameraPosition userLocaton = CameraPosition(
    target: LatLng(29.987719, 31.1394304),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: userLocaton,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            markers: {
              ...eventMarkers,
              if (selectedLocation != null)
                Marker(
                  markerId: MarkerId("selected"),
                  position: selectedLocation!,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue),
                ),
            },
            onTap: (LatLng latLng) {
              setState(() {
                selectedLocation = latLng;
              });
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.events.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedEventIndex == index;

                  return GestureDetector(
                    onTap: () => _onEventSelected(index),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 340,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        // border: ,
                        color: isSelected ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 4)
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      child: Container(
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //         image: AssetImage("assets/images/sport.png"))),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset("assets/images/sport.png"),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  maxLines: 1,
                                  widget.events[index].title ?? "",
                                  style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(
                                  maxLines: 1,
                                  widget.events[index].description ?? "",
                                  style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      maxLines: 1,
                                      "lat:${widget.events[index].geoPoint?.latitude ?? 0}",
                                      style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      maxLines: 1,
                                      "long:${widget.events[index].geoPoint?.longitude ?? 0}",
                                      style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: widget.isbutton == true
          ? FloatingActionButton(
              onPressed: () {
                if (selectedLocation != null) {
                  Navigator.pop(context, selectedLocation);
                }
              },
              child: Icon(Icons.check),
            )
          : null,
    );
  }
}
