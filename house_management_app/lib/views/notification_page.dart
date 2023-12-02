import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house_management_app/views/notificationColumn.dart';

import 'notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: StreamBuilder(
          stream:
              notifications.orderBy('timeline', descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            List<NotificationItem> newNotifications = [];
            List<NotificationItem> oldNotifications = [];

            // Thêm tất cả thông báo vào danh sách oldNotifications
            for (var doc in snapshot.data!.docs) {
              NotificationItem notificationItem = NotificationItem(
                iconData: Icons.notifications,
                message: doc['message'],
                title: doc['title'],
                time: TimeOfDay.fromDateTime(
                    (doc['timeline'] as Timestamp).toDate()),
              );
              oldNotifications.add(notificationItem);
            }

            // Kiểm tra xem có thông báo nào hay không
            bool hasNotifications = oldNotifications.isNotEmpty;

            // Nếu có ít nhất một thông báo, thêm thông báo mới nhất vào danh sách newNotifications
            if (hasNotifications) {
              newNotifications.add(oldNotifications.removeAt(0));
            }

            return ListView(
              children: [
                // Hiển thị thông báo nếu có
                if (hasNotifications) ...[
                  Text("News"),
                  ...newNotifications,
                  Text("Before"),
                  NotificationColumn(notifications: oldNotifications),
                ] else
                  Text(
                    "Không có thông báo nào.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
