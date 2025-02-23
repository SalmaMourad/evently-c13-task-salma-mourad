import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'map_tab.dart';
import '../../../../db/dao/events_dao.dart';
import 'package:evently_c13/db/model/event_type_model.dart';
import 'package:evently_c13/providers/AuthProvider.dart';

class MapScreen extends StatelessWidget {
  final EventType eventType; 
  const MapScreen({Key? key, required this.eventType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.appUser == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: FutureBuilder(
        future:
            EventsDao.loadEvents(authProvider.appUser?.id ?? "", eventType.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          var events = snapshot.data?.data ?? [];

          if (events.isEmpty) {
            return Center(child: Text("No Events Found"));
          }

          return MapTab(
            events: events,
            isbutton: false,
          );
        },
      ),
    );
  }
}
