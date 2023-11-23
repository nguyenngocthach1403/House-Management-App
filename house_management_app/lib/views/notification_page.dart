import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:house_management_app/custom_scaffold/weather.dart';
import 'package:house_management_app/views/notification.dart';
import 'package:house_management_app/views/notificationColumn.dart';

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
          centerTitle: true,
        ),
        body:
           
            ListView(
          children: [
            Text("New"),
            NotificationItem(
                iconData: Icons.notifications,
                message: "thông báo",
                title: "title",
                time: TimeOfDay.now()),
                Text("Before"),
                NotificationColumn()
          ],
        )
        );
  }
}
