import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class notificationItem extends StatelessWidget {
  const notificationItem(
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: ListView.builder(
        itemCount: 30, // Số lượng thông báo
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.amber),
            child: ListTile(
              leading: Icon(iconData),
              title: Text(title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message),
                  Text("Time: ${time.format(context)}"),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
