import 'package:evently_c13/ui/screens/add_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:evently_c13/db/model/event_model.dart';
import 'package:evently_c13/db/model/event_type_model.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;
  final List<EventModel> events;

  const EventDetailsScreen(
      {super.key, required this.event, required this.events});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Details"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddEditEventScreen.routeName,
                    arguments: event);
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(
                    EventType.getEventImageById(event.eventTypeId ?? 0),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title: ${event.title ?? "No Title"}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Date: ${event.date?.toDate()}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "lat: ${event.geoPoint?.latitude ?? ""}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "long: ${event.geoPoint?.longitude ?? ""}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Description: ${event.description ?? "No Description"}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
