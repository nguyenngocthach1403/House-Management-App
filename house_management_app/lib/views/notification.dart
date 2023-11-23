import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.iconData,
    required this.message,
    required this.title,
    required this.time,
  });

  final IconData iconData;
  final String title;
  final String message;
  final TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 10,
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(16),
          color: Color.fromARGB(228, 53, 110, 77),
        ),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(title),
                  SizedBox(
                    height: 10,
                  ),
                  Text(message)
                ],
              ),
              Column(
                children: [
                  Icon(iconData),
                  SizedBox(
                    height: 30,
                  ),
                  Text("Time: ${time.format(context)}"),
                ],
              )
            ],
          ),
        ));
  }
}
