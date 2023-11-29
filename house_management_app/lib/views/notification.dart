import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem(
      {super.key,
      required this.iconData,
      required this.message,
      required this.title,
      required this.time});
  final IconData iconData;
  final String title;
  final String message;
  final TimeOfDay time;
//git
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromRGBO(53, 110, 95, 1)),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Row(
                        children: [
                          const Icon(Icons.title_rounded, color: Colors.white),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                              title.length > 30
                                  ? title.substring(0, 27) + "..."
                                  : title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 7, 10, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              message.length > 110
                                  ? message.substring(0, 107) + "..."
                                  : message,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Time: ${time.format(context)}",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 214, 214, 214),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconData,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ))
          ],
        ));
  }
}

// ListTile(
//         leading: Icon(iconData),
//         title: Text(title.length > 30 ? title.substring(0, 27) + "..." : title,
//             style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20)),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(
//               message.length > 90 ? message.substring(0, 87) + "..." : message,
//               style: TextStyle(color: Colors.white),
//             ),
//             Text("Time: ${time.format(context)}"),
//           ],
//         ),
//       ),
