import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:house_management_app/custom_scaffold/weather.dart';
import 'package:house_management_app/views/notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: ListView.builder(
        itemCount: 30, // Số lượng thông báo
        itemBuilder: (context, index) {
          return NotificationItem(
              iconData: Icons.abc,
              message: "thông báo",
              title: "",
              time: TimeOfDay.now());
        },
      ),
    );
  }
}
