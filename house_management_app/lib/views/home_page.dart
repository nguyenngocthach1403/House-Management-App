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

  List<Map<String, dynamic>> featureLst = [
    {"icon": Icons.lock_open_rounded, 'name': "open_door"}
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
  @override
  Widget build(BuildContext context) {
    DatabaseReference _isOpen = FirebaseDatabase.instance.ref("door/status");
    _isOpen.onValue.listen((event) {
      setState(() {
        doorstatus = event.snapshot.value
            .toString(); //Gán dữ liệu được lấy trên firebase vào chuỗi
        print(event.snapshot.value);
        (doorstatus == 'OPEN')
            ? isOpendoor = true
            : isOpendoor =
                false; // So sánh dữ liệu được lấy (Nếu là ON thì đèn sáng ,OFF đèn tắt)
      });
    });
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child:
                    CircleAvatar(backgroundImage: AssetImage("images/h1.png")),
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
                          padding: EdgeInsets.fromLTRB(15, 20, 0, 5),
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
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                  children: List.generate(
                                      featureLst.length,
                                      (index) => Feature(
                                          icon: Icon(
                                            featureLst[index]['icon'],
                                            color: isOpendoor
                                                ? Colors.red
                                                : Colors.white,
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
                                                  } catch (e) {
                                                    print(e.toString());
                                                  }
                                                } else {
                                                  isOpendoor = !isOpendoor;
                                                  doorstatus = _isOpen
                                                      .set("OPEN")
                                                      .toString();
                                                }
                                              }
                                            });
                                          }))),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
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
                          child: NotificationItem(
                              iconData: Icons.notifications,
                              message:
                                  "Nhiet do ngoai troi ddang o muc kha cao hay dung kem chong nang khi ra ngoai",
                              title: "Nhiet do ngoai troi hien tai",
                              time: TimeOfDay.now()),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
