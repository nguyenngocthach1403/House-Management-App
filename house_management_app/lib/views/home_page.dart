import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:house_management_app/custom_scaffold/weather.dart';
import 'package:house_management_app/models/sharedPreferences.dart';
import 'package:house_management_app/screen_login/welcome_screen.dart';
import 'package:house_management_app/views/feature.dart';
import 'package:house_management_app/views/notification.dart';
import 'package:house_management_app/views/room.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  bool isOpendoor = false;
  String doorstatus = '';
  bool isAlarmLight = false;
  String alarmLightStatus = '';

  List<Map<String, dynamic>> featureLst = [
    {"icon": Icons.lock_open_rounded, 'name': "open_door"},
    {"icon": Icons.lightbulb, 'name': "alarm"},
  ];
  List<ListRoom> lstroom = List.filled(
      5,
      ListRoom(
          iconLight: Icons.lightbulb,
          iconC: Icons.thermostat,
          iconWater: Icons.water_drop,
          textLight: "ON",
          textC: "22°C",
          textWater: "10%"));
  Color _getIconColor(IconData icon) {
    if (icon == Icons.lightbulb) {
      return isAlarmLight
          ? Colors.yellow
          : Colors.white; // Màu khi bật hoặc tắt đèn
    } else if (icon == Icons.lock_open_rounded) {
      return isOpendoor ? Colors.green : Colors.red; // Màu khi mở hoặc đóng cửa
    } else {
      return Colors.white; // Màu mặc định cho các biểu tượng khác
    }
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference _isOpen = FirebaseDatabase.instance.ref("door/status");
    _isOpen.onValue.listen((event) {
      setState(() {
        doorstatus = event.snapshot.value
            .toString(); //Gán dữ liệu được lấy trên firebase vào chuỗi
        // print(event.snapshot.value);
        (doorstatus == 'OPEN')
            ? isOpendoor = true
            : isOpendoor =
                false; // So sánh dữ liệu được lấy (Nếu là ON thì đèn sáng ,OFF đèn tắt)
      });
    });
    DatabaseReference _isOn = FirebaseDatabase.instance.ref("alarmLed/status");
    _isOn.onValue.listen((event) {
      setState(() {
        alarmLightStatus = event.snapshot.value.toString();
        (alarmLightStatus == 'ON') ? isAlarmLight = true : isAlarmLight = false;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: CircleAvatar(backgroundImage: AssetImage("images/h1.png")),
            ),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 1),
              builder: ((context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20 - value * 20),
                    child: child,
                  ),
                );
              }),
              child: const Text(
                "Controll Panel",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_active,
                      color: Colors.white),
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: () async {
                    _auth.signOut();
                    SharedPreferencesInfo.updateData(false);
                    Navigator.popAndPushNamed(context, '/');
                  },
                  icon: const Icon(Icons.exit_to_app_outlined,
                      color: Colors.white),
                  iconSize: 30,
                ),
              ],
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(58, 126, 111, 1),
        elevation: 0,
      ),
      backgroundColor: const Color.fromRGBO(58, 126, 111, 1),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Welcome Toan",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Weather(
              weatherIcon: const AssetImage("images/icon/cloudy.png"),
              weather: "Good",
              temperature: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
                          child: Text(
                            "Feature",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          height: 90,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                children: List.generate(
                                  featureLst.length,
                                  (index) => Feature(
                                    icon: Icon(
                                      featureLst[index]['icon'],
                                      // color: (featureLst[index]['icon'] ==
                                      //                 Icons.lightbulb &&
                                      //             isAlarmLight) ||
                                      //         (featureLst[index]['icon'] ==
                                      //                 Icons.lock_open_rounded &&
                                      //             isOpendoor)
                                      //     ? Colors.yellow
                                      //     : Colors.white,
                                      color: _getIconColor(
                                          featureLst[index]['icon']),
                                      size: 50,
                                    ),
                                    action: () {
                                      setState(() {
                                        if (featureLst[index]['name'] ==
                                            'open_door') {
                                          if (isOpendoor) {
                                            isOpendoor = !isOpendoor;
                                            try {
                                              doorstatus = _isOpen
                                                  .set("CLOSE")
                                                  .toString();
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return const AlertDialog(
                                                      content: Text(
                                                          'Close the door'),
                                                    );
                                                  });
                                            } catch (e) {
                                              print(e.toString());
                                            }
                                          } else {
                                            isOpendoor = !isOpendoor;
                                            doorstatus =
                                                _isOpen.set("OPEN").toString();
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const AlertDialog(
                                                    content:
                                                        Text('Open the door'),
                                                  );
                                                });
                                          }
                                        }
                                        if (featureLst[index]['name'] ==
                                            'alarm') {
                                          if (isAlarmLight) {
                                            isAlarmLight = !isAlarmLight;
                                            try {
                                              alarmLightStatus =
                                                  _isOn.set("OFF").toString();
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return const AlertDialog(
                                                      content: Text(
                                                          'Turn Off Alarm Led'),
                                                    );
                                                  });
                                            } catch (e) {
                                              print(e.toString());
                                            }
                                          } else {
                                            isAlarmLight = !isAlarmLight;
                                            alarmLightStatus =
                                                _isOn.set("ON").toString();
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const AlertDialog(
                                                    content: Text(
                                                        'Turn On Alarm Led'),
                                                  );
                                                });
                                          }
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Room",
                              style: TextStyle(
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/settingscreen');
                                },
                                child: const Text(
                                  "See all",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 1, left: 6, right: 7),
                        child: Column(children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Row(
                                  children: List.generate(lstroom.length,
                                      (index) => lstroom[index]),
                                )
                              ],
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Notification",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/notifications');
                          },
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('notifications')
                                .orderBy('timeline', descending: true)
                                .limit(1)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Lỗi: ${snapshot.error}');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // Kiểm tra xem có dữ liệu nào trong cache không để tránh hiển thị CircularProgressIndicator liên tục.
                                if (snapshot.hasData &&
                                    snapshot.data!.docs.isNotEmpty) {
                                  var latestNotification =
                                      snapshot.data!.docs.first;
                                  var notificationItem = NotificationItem(
                                    iconData: Icons.notifications,
                                    message: latestNotification['message'],
                                    title: latestNotification['title'],
                                    time: TimeOfDay.fromDateTime(
                                      (latestNotification['timeline']
                                              as Timestamp)
                                          .toDate(),
                                    ),
                                  );

                                  return notificationItem;
                                } else {
                                  return NotificationItem(
                                      iconData:
                                          Icons.not_listed_location_outlined,
                                      message: "",
                                      title: "Not Found Notification",
                                      time: TimeOfDay.now());
                                }
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Text(
                                    'Không có thông báo nào.'); // Hiển thị thông báo khi không có thông báo.
                              }

                              var latestNotification =
                                  snapshot.data!.docs.first;
                              var notificationItem = NotificationItem(
                                iconData: Icons.notifications,
                                message: latestNotification['message'],
                                title: latestNotification['title'],
                                time: TimeOfDay.fromDateTime(
                                  (latestNotification['timeline'] as Timestamp)
                                      .toDate(),
                                ),
                              );

                              return notificationItem;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
