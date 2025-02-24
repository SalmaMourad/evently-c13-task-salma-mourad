import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:evently_c13/db/model/event_model.dart';
import 'package:evently_c13/db/model/event_type_model.dart';

import '../../core/app_colors.dart';
import '../screens/add_edit_screen.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;
  final List<EventModel> events;

  const EventDetailsScreen({
    super.key,
    required this.event,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    LatLng eventLocation = LatLng(
      event.geoPoint?.latitude ?? 0.0,
      event.geoPoint?.longitude ?? 0.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Event Details"),
        actions: [
          IconButton(
           onPressed: () {
                Navigator.pushNamed(context, AddEditEventScreen.routeName,
                    arguments: event);
              },
            icon: Icon(Icons.edit),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 14,right: 14,bottom: 2),
              height: 225,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: AssetImage(
                    EventType.getEventImageById(event.eventTypeId ?? 0),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${event.title ?? "No Title"}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),


                  buildDateContainer( "Date: ${event.date?.toDate()}"),
                  
                  
                  // Text(maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                  //   "Date: ${event.date?.toDate()}",
                  //   style: Theme.of(context).textTheme.bodyMedium,
                  // ),
                  const SizedBox(height: 10),
                  Text(
                    "Location:",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: eventLocation,
                          zoom: 14,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId("event_location"),
                            position: eventLocation,
                            infoWindow: InfoWindow(title: event.title),
                          ),
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Description:",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                    Text(
                    "${event.description ?? "No Description"}",
                    style:TextStyle(fontSize: 18,fontWeight: FontWeight.normal,color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
   Container buildDateContainer(String date) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.purple),
      ),
      child: Row(children: [
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.purple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.date_range,
              color: AppColors.white,
            )),
            SizedBox(width: 5,),
         Text(date??"",maxLines: 1,style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,),
        const Spacer(),
        // const Icon(
        //   Icons.arrow_forward_ios,
        //   color: AppColors.purple,
        // )
      ]),
    );
  }

 
}
