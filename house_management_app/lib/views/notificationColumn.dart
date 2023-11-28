import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:house_management_app/views/notification.dart';

class NotificationColumn extends StatelessWidget {
  NotificationColumn({super.key});
  List<NotificationItem> a = List.filled(
      5,
      NotificationItem(
          iconData: Icons.notifications,
          message: "Thông báo",
          title: "",
          time: TimeOfDay.now()));
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(a.length, (index) => a[index]),
    );
  }
}
