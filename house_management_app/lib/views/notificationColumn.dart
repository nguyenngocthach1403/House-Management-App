import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:house_management_app/views/notification.dart';

class NotificationColumn extends StatelessWidget {
  final List<NotificationItem> notifications;

  const NotificationColumn({Key? key, required this.notifications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: notifications.map((item) => item).toList(),
    );
  }
}
