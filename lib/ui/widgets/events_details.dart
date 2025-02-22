import 'package:evently_c13/ui/screens/add_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:evently_c13/db/model/event_model.dart';
import 'package:evently_c13/db/model/event_type_model.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( "Event Details"),
        actions: [IconButton(onPressed: (){

          Navigator.pushNamed(context,AddEditEventScreen.routeName,arguments: event);
        }, icon: Icon(Icons.edit))],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            Container(
              // padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(
                    EventType.getEventImageById(event.eventTypeId ?? 0),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Event Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title: ${event.title ?? "No Title"}"
                    ,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Date: ${event.date?.toDate()}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ), Text(
                    "lat: ${event.lat}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ), Text(
                    "long: ${event.long}",
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


// import 'package:flutter/material.dart';
// import 'package:evently_c13/db/model/event_model.dart';

// class EventDetailsScreen extends StatelessWidget {
//   final EventModel event;

//   const EventDetailsScreen({super.key, required this.event});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(event.title ?? "Event Details"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               event.title ?? "No Title",
//               style: Theme.of(context).textTheme.headlineSmall,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "Date: ${event.date?.toDate()}",
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "Description: ${event.description ?? "No Description"}",
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//              Container(
//             // height: height * 0.25,
//             margin: const EdgeInsets.all(10),
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(20)),
//                 image: DecorationImage(
//                   image: AssetImage(
//                     event.getEventImageById(event.eventTypeId ?? 0),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }



// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:evently_c13/core/app_colors.dart';
// // import 'package:evently_c13/db/model/event_model.dart';
// // import 'package:evently_c13/db/model/event_type_model.dart';
// // import 'package:evently_c13/l10n/DateTimeUtils.dart';
// // import 'package:flutter/material.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// // typedef OnFavoriteCallBack = void Function(EventModel event);

// // class EventDetails extends StatelessWidget {
// //   EventModel event;
// //   // OnFavoriteCallBack onFavoriteCallBack;

// // static String  routeName ='details';
// //   EventDetails(this.event, {super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final height = MediaQuery.of(context).size.height;
// //     return Scaffold(
// //       body: Column(
// //         children: [
// //           Container(
// //             height: height * 0.25,
// //             margin: const EdgeInsets.all(10),
// //             padding: const EdgeInsets.all(10),
// //             decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.all(Radius.circular(20)),
// //                 image: DecorationImage(
// //                   image: AssetImage(
// //                     EventType.getEventImageById(event.eventTypeId ?? 0),
// //                   ),
// //                 )),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 buildDateContainer(event.date),
// //                 const Spacer(),
// //                 buildTitleContainer(context)
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Container buildTitleContainer(BuildContext context) {
// //     return Container(
// //           padding: const EdgeInsets.all(8),
// //           decoration: const BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.all(Radius.circular(10)),
// //           ),
// //           child: Row(
// //             children: [
// //               Text(
// //             event.title ?? "",
// //             style: Theme.of(context).textTheme.bodyLarge,
// //               ),
// //               const Spacer(),
// //           InkWell(
// //             onTap: () {
// //               // onFavoriteCallBack.call(event);
// //             },
// //             child: FaIcon(
// //               event.isFavorite
// //                   ? FontAwesomeIcons.solidHeart
// //                   : FontAwesomeIcons.heart,
// //               color: AppColors.purple,
// //             ),
// //           ),
// //             ],
// //           ),
// //         );
// //   }

// //   Container buildDateContainer(Timestamp? timeStamp) {
// //     return Container(
// //       padding: const EdgeInsets.all(8),
// //       decoration: const BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.all(Radius.circular(10)),
// //       ),
// //       child: Column(
// //         children: [
// //           Text(
// //             "${timeStamp?.toDate().day}",
// //             style: TextStyle(
// //                 fontSize: 25,
// //                 fontWeight: FontWeight.bold,
// //                 color: AppColors.purple),
// //           ),
// //           Text(
// //             "${getMonthNameFromDate(timeStamp!.toDate())}",
// //             style: TextStyle(
// //                 fontSize: 25,
// //                 fontWeight: FontWeight.bold,
// //                 color: AppColors.purple),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
