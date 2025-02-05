import 'package:evently_c13/core/app_colors.dart';
import 'package:evently_c13/core/dialog_utils.dart';
import 'package:evently_c13/db/dao/events_dao.dart';
import 'package:evently_c13/db/model/event_model.dart';
import 'package:evently_c13/db/model/event_type_model.dart';
import 'package:evently_c13/providers/AuthProvider.dart';
import 'package:evently_c13/ui/screens/add_event_screen.dart';
import 'package:evently_c13/ui/screens/login_screen.dart';
import 'package:evently_c13/ui/widgets/events_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  static const String routeName = "home";

  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<EventModel>? events = [];

  @override
  initState() {
    super.initState();
  }

  var eventTypes = EventType.getEventTypes();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    return SafeArea(
      child: DefaultTabController(
        length: eventTypes.length,
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(
              side: BorderSide(color: AppColors.white, width: 5),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AddEventScreen.routeName);
            },
            backgroundColor: AppColors.purple,
            child: const Icon(
              Icons.add,
              color: AppColors.white,
              size: 30,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.purple,
            selectedItemColor: AppColors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: AppColors.purple,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on_outlined),
                label: 'Map',
                backgroundColor: AppColors.purple,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Love',
                backgroundColor: AppColors.purple,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: AppColors.purple,
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
          appBar: AppBar(
            toolbarHeight: height * 0.15,
            backgroundColor: AppColors.purple,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            centerTitle: false,
            bottom: TabBar(
              unselectedLabelColor: AppColors.white,
              labelColor: AppColors.purple,
              indicatorSize: TabBarIndicatorSize.label,
              dividerHeight: 0,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.white),
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              isScrollable: true,
              tabs: [
                ...eventTypes.map((eventType) => Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        spacing: 8,
                        children: [eventType.icon, Text(eventType.name)],
                      ),
                    ))
              ],
            ),
            title: buildAppBarTitle(),
            actions: buildAppBarActions,
          ),
          body: TabBarView(
            children: [
              ...eventTypes.map((eventType) => FutureBuilder(
                    future: EventsDao.loadEvents(authProvider.appUser?.id ?? "",
                        eventTypes[_selectedIndex].id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // waiting for future to complete
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      var events = snapshot.data?.data;
                      if (events == null || events.isEmpty) {
                        return Center(
                          child: Text("No Events Found"),
                        );
                      }
                      return EventsListView(events: events);
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void loadEvents() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var eventsResponse = await EventsDao.loadEvents(
        authProvider.appUser?.id ?? "", eventTypes[_selectedIndex].id);
    setState(() {
      events = eventsResponse.data;
    });
  }

  List<Widget> get buildAppBarActions {
    return [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.wb_sunny_outlined,
            color: AppColors.white,
            size: 30,
          )),
      IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: AppColors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          icon: const Text("EN",
              style: TextStyle(
                  color: AppColors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.w400))),
    ];
  }

  Column buildAppBarTitle() {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome Back ✨",
          style: TextStyle(
              fontSize: 16,
              color: AppColors.white,
              fontWeight: FontWeight.w400),
        ),
        Text(
          authProvider.appUser?.name ?? "",
          style: TextStyle(
              fontSize: 25,
              color: AppColors.white,
              fontWeight: FontWeight.w700),
        ),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: AppColors.white,
            ),
            Text(
              "Cairo, Egypt",
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.white,
                  fontWeight: FontWeight.w400),
            ),
          ],
        )
      ],
    );
  }

  void logout() {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    showMessageDialog("Please Confirm logout", posActionTitle: "logout",
        posAction: () {
      authProvider.logout();
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }, negActionTitle: "cancel");
  }
}
