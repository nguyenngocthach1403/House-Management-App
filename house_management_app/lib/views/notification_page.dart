import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          stream: notifications.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return ListView(
              children: [
                Text("Notifications"),
                for (var doc in snapshot.data!.docs)
                  NotificationItem(
                    iconData: Icons.notifications,
                    message: doc['message'],
                    title: doc['title'],
                    time: TimeOfDay.now(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
